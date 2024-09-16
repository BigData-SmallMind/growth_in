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
            isRequired: true,
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
        isRequired: true,
        isAlreadyRegistered: state.newEmail.isAlreadyRegistered
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

  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(newValue, shouldCheckStrength: false)
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final newScreenState = state.copyWith(
      password: Password.validated(
        state.password.value,
        shouldCheckStrength: false,
      ),
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final newEmail = Email.validated(
      state.newEmail.value,
      isRequired: true,
    );
    final newEmailConfirmation = EmailConfirmation.validated(
      email: newEmail,
      state.newEmailConfirmation.value,
    );
    final password = Password.validated(
      state.password.value,
      shouldCheckStrength: false,
    );

    final isFormValid =
        Formz.validate([newEmail, newEmailConfirmation, password]);

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
          newEmailConfirmation: newEmailConfirmation.value,
          password: password.value!,
        );
        final otpVerification = OtpVerification(
          email: newEmailConfirmation.value,
          reason: OtpVerificationReason.changeEmail,
        );
        userRepository.changeNotifier.setOtpVerification(otpVerification);
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is! EmailAlreadyRegisteredException &&
                  error is! WrongPasswordException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          newEmail: Email.validated(
            state.newEmail.value,
            isAlreadyRegistered:
                error is EmailAlreadyRegisteredException ? true : false,
          ),
          password: Password.validated(
            state.password.value,
            shouldCheckStrength: false,
            invalidCredentials: error is WrongPasswordException ? true : false,
          ),
        );
        emit(newState);
      }
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
// @override
// Future<void> onChange(change) async {
//   print('+++++++${change.currentState.email}');
//   print('-------${change.nextState.email}');
//   super.onChange(change);
// }
}
