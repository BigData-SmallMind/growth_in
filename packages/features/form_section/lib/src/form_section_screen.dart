import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:form_section/src/form_section_cubit.dart';
import 'package:form_section/src/l10n/form_section_localizations.dart';
import 'package:user_repository/user_repository.dart';

class FormSectionScreen extends StatelessWidget {
  const FormSectionScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormSectionCubit>(
      create: (_) => FormSectionCubit(userRepository: userRepository),
      child: const FormSectionView(),
    );
  }
}

class FormSectionView extends StatelessWidget {
  const FormSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormSectionCubit, FormSectionState>(
      builder: (context, state) {
        final l10n = FormSectionLocalizations.of(context);
        final loading = state.formSectionFetchingStatus ==
            FormSectionFetchingStatus.loading;
        final error =
            state.formSectionFetchingStatus == FormSectionFetchingStatus.error;
        final theme = GrowthInTheme.of(context);
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<FormSectionCubit>();
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: () => cubit.fetchFormSection(),
                    )
                  : ListView.builder(
                      itemCount: state.formSection!.questions.length,
                      itemBuilder: (context, index) {
                        final question = state.formSection!.questions[index];
                        final error = state.questions
                            .firstWhere(
                              (q) => q.value?.id == question.id,
                              orElse: () => const FormQuestion.unvalidated(),
                            )
                            .error;
                        switch (question.type) {
                          case QuestionType.essay:
                            return EssayQuestion(
                              question: question,
                              error: error,
                              onChanged: (value) {
                                cubit.updateAnswer(
                                  question: question,
                                  answer: value,
                                );
                              },
                            );
                          default:
                            return Container();
                        }
                      },
                    ),
        );
      },
    );
  }
}
