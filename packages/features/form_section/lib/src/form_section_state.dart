part of 'form_section_cubit.dart';

class FormSectionState extends Equatable {
  const FormSectionState({
    this.currentSection = 0,
    this.isLastSection = false,
    this.totalSections = 0,
    this.formSection,
    this.formSectionFetchingStatus = FormSectionFetchingStatus.initial,
    this.questions = const [FormQuestion.unvalidated()],
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final int currentSection;
  final bool isLastSection;
  final int totalSections;
  final FormSection? formSection;
  final FormSectionFetchingStatus formSectionFetchingStatus;
  final List<FormQuestion> questions;
  final FormzSubmissionStatus submissionStatus;

  FormSectionState copyWith({
    int? currentSection,
    bool? isLastSection,
    int? totalSections,
    FormSection? formSection,
    FormSectionFetchingStatus? formSectionFetchingStatus,
    List<FormQuestion>? questions,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return FormSectionState(
      currentSection: currentSection ?? this.currentSection,
      isLastSection: isLastSection ?? this.isLastSection,
      totalSections: totalSections ?? this.totalSections,
      formSection: formSection ?? this.formSection,
      formSectionFetchingStatus:
          formSectionFetchingStatus ?? this.formSectionFetchingStatus,
      questions: questions ?? this.questions,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        currentSection,
        isLastSection,
        totalSections,
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
