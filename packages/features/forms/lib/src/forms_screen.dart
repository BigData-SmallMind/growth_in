import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms/src/forms_cubit.dart';
import 'package:forms/src/l10n/forms_localizations.dart';
import 'package:user_repository/user_repository.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormsCubit>(
      create: (_) => FormsCubit(userRepository: userRepository),
      child: const FormsView(),
    );
  }
}

class FormsView extends StatelessWidget {
  const FormsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsCubit, FormsState>(
      builder: (context, state) {
        final l10n = FormsLocalizations.of(context);
        final loading =
            state.formsFetchingStatus == FormsFetchingStatus.loading;
        final error = state.formsFetchingStatus == FormsFetchingStatus.error;
        final theme = GrowthInTheme.of(context);
        final textTheme = Theme.of(context).textTheme;
        final hasNoForms =
            state.forms!.list.isEmpty && state.forms!.previous.isEmpty;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : error || hasNoForms
                  ? ExceptionIndicator(
                      onTryAgain: () => context.read<FormsCubit>().fetchForms(),
                      message: hasNoForms ? l10n.noFormsErrorMessage : null,
                      title: hasNoForms ? l10n.noFormsErrorTitle : null,
                    )
                  : ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                      children: [
                        if (state.forms!.list.isNotEmpty) ...[
                          Text(
                            l10n.incompleteFormsSectionTitle,
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          VerticalGap.small(),
                          ColumnBuilder(
                            itemCount: state.forms!.list.length,
                            itemBuilder: (context, index) {
                              final form = state.forms!.list[index];
                              return FormCard(form: form);
                            },
                          ),
                        ],
                        if (state.forms!.previous.isNotEmpty) ...[
                          VerticalGap.large(),
                          const Divider(),
                          VerticalGap.large(),
                          Text(
                            l10n.previousFormsSectionTitle,
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          VerticalGap.small(),
                          ColumnBuilder(
                            itemCount: state.forms!.previous.length,
                            itemBuilder: (context, index) {
                              final form = state.forms!.previous[index];
                              return FormCard(form: form);
                            },
                          ),
                        ]
                      ],
                    ),
        );
      },
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.form,
  });

  final FormDM form;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    final l10n = FormsLocalizations.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.secondaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalGap.small(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HorizontalGap.custom(theme.screenMargin),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    form.name,
                    style: textTheme.titleMedium,
                  ),
                  VerticalGap.medium(),
                  Text(form.services.first.name),
                  VerticalGap.medium(),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: theme.secondaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.secondaryColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: Spacing.small),
            child: Center(
              child: Row(
                children: [
                  HorizontalGap.custom(theme.screenMargin),
                  Text(
                    l10n.waitingToCompleteFormText,
                    style: textTheme.bodyMedium?.copyWith(
                        color: theme.materialThemeData.colorScheme.surface),
                  ),
                  const Spacer(),
                  Text(
                    '${form.totalAnsweredQuestions}/${form.totalQuestions}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.materialThemeData.colorScheme.surface,
                    ),
                  ),
                  HorizontalGap.custom(theme.screenMargin),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
