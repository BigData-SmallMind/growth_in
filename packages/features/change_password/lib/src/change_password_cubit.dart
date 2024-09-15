import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.userRepository,
  }) : super(
          const ChangePasswordState(),
        );

  final UserRepository userRepository;

  void togglePasswordInfoOverlay(double yOffset) {
    final overLayToggled = state.copyWith(
      passwordInfoOverlayShown: !state.passwordInfoOverlayShown,
      passwordInfoOverlayYOffset: yOffset,
    );
    emit(overLayToggled);
  }

  void hidePasswordFormatInfoOverlay() {
    if (state.passwordInfoOverlayShown == true) {
      togglePasswordInfoOverlay(
        state.passwordInfoOverlayYOffset,
      );
    }
  }

  void onCurrentPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.currentPassword;
    final shouldValidate = previousPasswordState.isNotValid;
    final currentPasswordState = shouldValidate
        ? Password.validated(
            newValue,
            shouldCheckStrength: false,
          )
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      currentPassword: currentPasswordState,
    );

    emit(newScreenState);
  }

  void onCurrentPasswordUnfocused() {
    final newScreenState = state.copyWith(
      currentPassword: Password.validated(
        state.currentPassword.value,
        shouldCheckStrength: false,
      ),
    );
    emit(newScreenState);
  }

  void onNewPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.newPassword;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
            shouldCheckStrength: true,
          )
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      newPassword: newPasswordState,
    );

    emit(newScreenState);
  }

  void onNewPasswordUnfocused() {
    final newScreenState = state.copyWith(
      newPassword: Password.validated(
        state.newPassword.value,
        shouldCheckStrength: true,
      ),
    );
    emit(newScreenState);
  }

  void onNewPasswordConfirmationChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.newPasswordConfirmation;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordConfirmation = shouldValidate
        ? PasswordConfirmation.validated(
            password: state.newPassword,
            newValue,
          )
        : PasswordConfirmation.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      newPasswordConfirmation: newPasswordConfirmation,
    );

    emit(newScreenState);
  }

  void onNewPasswordConfirmationUnfocused() {
    final newScreenState = state.copyWith(
      newPasswordConfirmation: PasswordConfirmation.validated(
        password: state.newPassword,
        state.newPasswordConfirmation.value,
      ),
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final currentPassword = Password.validated(
      state.currentPassword.value,
      shouldCheckStrength: false,
    );
    final newPassword = Password.validated(
      state.newPassword.value,
      shouldCheckStrength: true,
    );
    final newPasswordConfirmation = PasswordConfirmation.validated(
      password: newPassword,
      state.newPasswordConfirmation.value,
    );

    final isFormValid = Formz.validate([
      currentPassword,
      newPassword,
      newPasswordConfirmation,
    ]);

    final newState = state.copyWith(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      submissionStatus: isFormValid ? FormzSubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.changePassword(
          currentPassword: currentPassword.value!,
          newPassword: newPassword.value!,
          newPasswordConfirmation: newPassword.value!,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is! WrongPasswordException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          currentPassword: Password.validated(
            state.currentPassword.value,
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
