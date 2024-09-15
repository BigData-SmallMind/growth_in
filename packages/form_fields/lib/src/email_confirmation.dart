import 'package:equatable/equatable.dart';
import 'package:form_fields/src/email.dart';
import 'package:formz/formz.dart';


class EmailConfirmation
    extends FormzInput<String, EmailConfirmationValidationError>
    with EquatableMixin {
  const EmailConfirmation.unvalidated([
    super.value = '',
  ])  : email = const Email.unvalidated(),
        super.pure();

  const EmailConfirmation.validated(
    super.value, {
    required this.email,
  }) : super.dirty();

  final Email email;

  @override
  EmailConfirmationValidationError? validator(String value) {
    if (isPure) return null;
    if (value.isEmpty) return EmailConfirmationValidationError.empty;
    if (value != email.value) {
      return EmailConfirmationValidationError.doesNotMatch;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        value,
        isPure,
        email,
      ];
}

enum EmailConfirmationValidationError {
  empty,
  doesNotMatch,
}
