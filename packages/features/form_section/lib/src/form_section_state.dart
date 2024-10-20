part of 'form_section_cubit.dart';

class FormSectionState extends Equatable {
  const FormSectionState({
    this.formSection,
    this.formSectionFetchingStatus = FormSectionFetchingStatus.initial,
    this.questions = const [FormQuestion.unvalidated()],
  });

  final FormSection? formSection;
  final FormSectionFetchingStatus formSectionFetchingStatus;
  final List<FormQuestion> questions;

  FormSectionState copyWith({
    FormSection? formSection,
    FormSectionFetchingStatus? formSectionFetchingStatus,
    List<FormQuestion>? questions,
  }) {
    return FormSectionState(
      formSection: formSection ?? this.formSection,
      formSectionFetchingStatus:
          formSectionFetchingStatus ?? this.formSectionFetchingStatus,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [
        formSection,
        formSectionFetchingStatus,
        questions,
      ];
}

enum FormSectionFetchingStatus {
  initial,
  loading,
  success,
  error,
}
