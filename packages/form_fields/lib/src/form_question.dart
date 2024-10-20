import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class FormQuestion extends FormzInput<Question?, FormQuestionValidationError>
    with EquatableMixin {
  const FormQuestion.unvalidated([
    super.value,
  ]) : super.pure();

  const FormQuestion.validated(super.value) : super.dirty();

  static final _domainRegex =
      RegExp(r'^(?!://)([a-zA-Z0-9-_]+\.)+[a-zA-Z]{2,}$');

  @override
  FormQuestionValidationError? validator(Question? value) {
    if (isPure) return null;
    if (value == null && value?.isRequired == true) {
      return FormQuestionValidationError.empty;
    }
    if (value?.isRequired == true &&
        value?.answer == null &&
        value?.anotherAnswer == null) {
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
