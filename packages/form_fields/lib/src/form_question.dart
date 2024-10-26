import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class FormQuestion extends FormzInput<Question?, FormQuestionValidationError>
    with EquatableMixin {
  const FormQuestion.unvalidated([
    super.value,
  ]) : super.pure();

  const FormQuestion.validated(super.value) : super.dirty();



  @override
  FormQuestionValidationError? validator(Question? value) {
    if (isPure) return null;
    if (value == null && value?.isRequired == true) {
      return FormQuestionValidationError.empty;
    }
    if (value?.isRequired == true &&
        value?.answer == null &&
        value?.otherAnswer == null) {
      return FormQuestionValidationError.empty;
    }
    //if it is an empty list return empty
    if (value?.isRequired == true &&
        value?.answer is List &&
        (value?.answer as List).isEmpty) {
      return FormQuestionValidationError.empty;
    }
    //if it is a list of empty strings return empty
    if (value?.isRequired == true &&
        value?.answer is List &&
        (value?.answer as List).every((element) => element == '')) {
      return FormQuestionValidationError.empty;
    }
    if (value?.isRequired == true &&
        value?.answer is List &&
        (value?.answer as List).every((element) => element == null)) {
      return FormQuestionValidationError.empty;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];
}

enum FormQuestionValidationError {
  empty,
  invalidFormat,
}
