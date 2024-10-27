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
    return BlocConsumer<FormSectionCubit, FormSectionState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success &&
            state.isLastSection) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
            ),
          );
          Navigator.of(context).pop();
        }
      },
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
        final textTheme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: () =>
                          cubit.fetchFormSection(state.currentSectionIndex),
                    )
                  : Column(
                      children: [
                        VerticalGap.large(),
                        Container(
                          padding: const EdgeInsets.all(Spacing.medium),
                          margin: EdgeInsets.symmetric(
                              horizontal: theme.screenMargin),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: theme.secondaryColor,
                              ),
                              left: BorderSide(
                                color: theme.secondaryColor,
                              ),
                              right: BorderSide(
                                color: theme.secondaryColor,
                              ),
                              top: BorderSide(
                                color: theme.secondaryColor,
                                width: 10,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(
                              theme.textFieldBorderRadius,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${l10n.sectionLabel} ${state.currentSectionIndex + 1}',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: theme.dimmedTextColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${l10n.formSectionQuestionsCountLabel} ${state.formSection!.questions.length}',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: theme.dimmedTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              VerticalGap.small(),
                              Text(
                                state.formSection?.name ?? '--',
                                style: textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IgnorePointer(
                            ignoring: submissionInProgress,
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
                                  case QuestionType.imageAndText:
                                    return ImageAndTextQuestion(
                                      imageDownloadUrl: cubit.imageDownloadUrl,
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
                        ),
                        Row(
                          children: [
                            HorizontalGap.custom(theme.screenMargin),
                            if (state.currentSectionIndex > 0) ...[
                              Expanded(
                                child: GrowthInElevatedButton(
                                  label: l10n.previousSectionButtonLabel,
                                  onTap: cubit.onPreviousSectionTapped,
                                  height: 40,
                                  bgColor: Colors.white,
                                  borderColor: theme.primaryColor,
                                  labelColor: theme.primaryColor,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: theme.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                              HorizontalGap.custom(Spacing.medium)
                            ],
                            Expanded(
                              child: submissionInProgress
                                  ? GrowthInElevatedButton.inProgress(
                                      iconAlignment: IconAlignment.end,
                                      label:
                                          l10n.submissionInProgressButtonLabel,
                                      height: 40,
                                    )
                                  : GrowthInElevatedButton(
                                      iconAlignment: IconAlignment.end,
                                      onTap: cubit.onSubmit,
                                      icon: state.isLastSection
                                          ? null
                                          : Icon(
                                              Icons.arrow_forward,
                                              color: theme.primaryColor,
                                              size: 20,
                                            ),
                                      labelColor: theme.primaryColor,
                                      borderColor: theme.primaryColor,
                                      bgColor: Colors.white,
                                      label: state.isLastSection
                                          ? l10n.submitLastSectionButtonLabel
                                          : '${l10n.nextSectionButtonLabel} (${state.currentSectionIndex + 1}/${state.totalSections})',
                                      height: 40,
                                    ),
                            ),
                            HorizontalGap.custom(theme.screenMargin),
                          ],
                        ),
                        VerticalGap.medium(),
                      ],
                    ),
        );
      },
    );
  }
}
