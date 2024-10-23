import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:form_section/src/form_section_cubit.dart';
import 'package:form_section/src/l10n/form_section_localizations.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:user_repository/user_repository.dart';

class FormSectionScreen extends StatelessWidget {
  const FormSectionScreen({
    super.key,
    required this.userRepository,
    required this.imageDownloadUrl,
    required this.formId,
  });

  final UserRepository userRepository;
  final String imageDownloadUrl;
  final int formId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormSectionCubit>(
      create: (_) => FormSectionCubit(
        userRepository: userRepository,
        imageDownloadUrl: imageDownloadUrl,
        formId: formId,
      ),
      child: GestureDetector(
        onTap: context.releaseFocus,
        child: const FormSectionView(),
      ),
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
        final cubit = context.read<FormSectionCubit>();
        final theme = GrowthInTheme.of(context);
        final submissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
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
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                VerticalGap.large(),
                            itemCount: state.formSection!.questions.length,
                            padding: EdgeInsets.all(
                              theme.screenMargin,
                            ),
                            itemBuilder: (context, index) {
                              final question =
                                  state.formSection!.questions[index];
                              final error = state.questions
                                  .firstWhere(
                                    (q) => q.value?.id == question.id,
                                    orElse: () =>
                                        const FormQuestion.unvalidated(),
                                  )
                                  .error;
                              switch (question.type) {
                                case QuestionType.essay ||
                                      QuestionType.longEssay:
                                  return EssayQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.multipleChoice ||
                                      QuestionType.dropdown ||
                                      QuestionType.multipleImageChoice:
                                  return MultipleChoiceQuestion(
                                    imageUrl: cubit.imageDownloadUrl,
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.slider:
                                  return SliderQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.fileUpload:
                                  return FileUploadQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.dateOnly:
                                  return DateQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.timeOnly:
                                  return TimeQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.dateAndTime:
                                  return DateAndTimeQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.dateRange:
                                  return DateRangeQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.timeRange:
                                  return TimeRangeQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                case QuestionType.dateAndTimeRange:
                                  return DateAndTimeRangeQuestion(
                                    question: question,
                                    error: error,
                                    onChanged: (answer) {
                                      cubit.onQuestionChanged(
                                        question.copyWith(
                                          answer: answer,
                                        ),
                                      );
                                    },
                                  );
                                default:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            theme.screenMargin,
                          ),
                          child: submissionInProgress
                              ? GrowthInElevatedButton.inProgress(
                                  label: 'l10n.submissionInProgressButtonLabel',
                                )
                              : GrowthInElevatedButton(
                                  onTap: cubit.onSubmit,
                                  bgColor: theme.secondaryColor,
                                  label: 'l10n.submitButtonLabel',
                                ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
