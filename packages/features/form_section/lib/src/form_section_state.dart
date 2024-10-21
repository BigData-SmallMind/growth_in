part of 'form_section_cubit.dart';

class FormSectionState extends Equatable {
  const FormSectionState({
    this.formSection,
    this.formSectionFetchingStatus = FormSectionFetchingStatus.initial,
    this.questions = const [FormQuestion.unvalidated()],
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final FormSection? formSection;
  final FormSectionFetchingStatus formSectionFetchingStatus;
  final List<FormQuestion> questions;
  final FormzSubmissionStatus submissionStatus;

  FormSectionState copyWith({
    FormSection? formSection,
    FormSectionFetchingStatus? formSectionFetchingStatus,
    List<FormQuestion>? questions,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return FormSectionState(
      formSection: formSection ?? this.formSection,
      formSectionFetchingStatus:
          formSectionFetchingStatus ?? this.formSectionFetchingStatus,
      questions: questions ?? this.questions,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
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
