part of 'form_section_cubit.dart';

class FormSectionState extends Equatable {
  const FormSectionState({
    this.currentSectionIndex = 0,
    this.isLastSection = false,
    this.totalSections = 0,
    this.formSections = const [],
    this.formSection,
    this.formSectionFetchingStatus = FormSectionFetchingStatus.initial,
    this.questions = const [FormQuestion.unvalidated()],
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final int currentSectionIndex;
  final bool isLastSection;
  final int totalSections;
  final List<FormSection> formSections;
  final FormSection? formSection;
  final FormSectionFetchingStatus formSectionFetchingStatus;
  final List<FormQuestion> questions;
  final FormzSubmissionStatus submissionStatus;

  FormSectionState copyWith({
    int? currentSectionIndex,
    bool? isLastSection,
    int? totalSections,
    List<FormSection>? formSections,
    FormSection? formSection,
    FormSectionFetchingStatus? formSectionFetchingStatus,
    List<FormQuestion>? questions,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return FormSectionState(
      currentSectionIndex: currentSectionIndex ?? this.currentSectionIndex,
      isLastSection: isLastSection ?? this.isLastSection,
      totalSections: totalSections ?? this.totalSections,
      formSections: formSections ?? this.formSections,
      formSection: formSection ?? this.formSection,
      formSectionFetchingStatus:
          formSectionFetchingStatus ?? this.formSectionFetchingStatus,
      questions: questions ?? this.questions,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        currentSectionIndex,
        isLastSection,
        totalSections,
        formSections,
        formSection,
        formSectionFetchingStatus,
        questions,
        submissionStatus,
      ];
}

enum FormSectionFetchingStatus {
  initial,
  loading,
  success,
  error,
}
