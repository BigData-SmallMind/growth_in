import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  ChangeEmailCubit({
    required this.userRepository,
  }) : super(
          const ChangeEmailState(),
        );

  final UserRepository userRepository;

  void onNewEmailChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.newEmail;
    final shouldValidate = previousEmailState.isNotValid;
    final newEmailState = shouldValidate
        ? Email.validated(
            newValue,
          )
        : Email.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      newEmail: newEmailState,
    );

    emit(newScreenState);
  }

  void onNewEmailUnfocused() {
    final newScreenState = state.copyWith(
      newEmail: Email.validated(
        state.newEmail.value,
      ),
    );
    emit(newScreenState);
  }

  void onNewEmailConfirmationChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.newEmailConfirmation;
    final shouldValidate = previousEmailState.isNotValid;
    final newEmailConfirmation = shouldValidate
        ? EmailConfirmation.validated(
            email: state.newEmail,
            newValue,
          )
        : EmailConfirmation.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      newEmailConfirmation: newEmailConfirmation,
    );

    emit(newScreenState);
  }

  void onNewEmailConfirmationUnfocused() {
    final newScreenState = state.copyWith(
      newEmailConfirmation: EmailConfirmation.validated(
        email: state.newEmail,
        state.newEmailConfirmation.value,
      ),
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final newEmail = Email.validated(
      state.newEmail.value,
    );
    final newEmailConfirmation = EmailConfirmation.validated(
      email: newEmail,
      state.newEmailConfirmation.value,
    );

    final isFormValid = Formz.validate([
      newEmail,
      newEmailConfirmation,
      newEmailConfirmation,
    ]);

    final newState = state.copyWith(
      newEmail: newEmail,
      newEmailConfirmation: newEmailConfirmation,
      password: password,
      submissionStatus: isFormValid ? FormzSubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.changeEmail(
          newEmail: newEmail.value!,
          newEmailConfirmation: newEmail.value!,
          password: password.value!,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is! EmailNotRegisteredException &&
                  error is! WrongPasswordException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          currentEmail: Email.validated(
            state.currentEmail.value,
            isAlreadyRegistered:
                error is EmailAlreadyRegisteredException ? true : false,
          ),
        );
        emit(newState);
      }
    }
  }

  @override
  Future<void> close() async {
    userRepository.deleteOtpVerificationTokenSupplierToken();
    return super.close();
  }
// @override
// Future<void> onChange(change) async {
//   print('+++++++${change.currentState.email}');
//   print('-------${change.nextState.email}');
//   super.onChange(change);
// }
}
