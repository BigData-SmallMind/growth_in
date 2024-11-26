import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.userRepository,
    required this.onForgotPasswordTapped,
    required this.onSignInSuccess,
  }) : super(
          const SignInState(),
        ) {
    // getAppDependencies();
    getRememberMeFromCache().then(
      (_) async {
        onEmailChanged(state.rememberMe.email);
        onPasswordChanged(state.rememberMe.password);
        if (state.rememberMe.email != null) {
          emit(state.copyWith(shouldRememberCredentials: true));
        }
      },
    );
  }

  final UserRepository userRepository;
  final VoidCallback onForgotPasswordTapped;
  final VoidCallback onSignInSuccess;

  void onEmailChanged(String? newValue) {
    final previousEmail = state.email;
    final shouldValidate = previousEmail.isNotValid;
    final newState = state.copyWith(
      email: shouldValidate
          ? Email.validated(
              newValue,
              isRequired: true,
            )
          : Email.unvalidated(
              newValue,
            ),
      password: Password.unvalidated(state.password.value),
    );
    emit(newState);
  }

  void onEmailUnfocused() {
    final newState = state.copyWith(
      email: Email.validated(
        state.email.value,
        invalidCredentials: state.email.invalidCredentials,
        invalidFormat: state.email.invalidFormat,
        isRequired: true,
      ),
    );

    emit(newState);
  }

  void onPasswordChanged(String? newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
            shouldCheckStrength: false,
          )
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      password: newPasswordState,
      email: Email.unvalidated(state.email.value),
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.validated(
      previousPasswordValue,
      shouldCheckStrength: false,
      invalidCredentials: state.password.invalidCredentials,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  void rememberMeEmitter(bool shouldRememberCredentials) {
    emit(state.copyWith(shouldRememberCredentials: shouldRememberCredentials));
  }

  Future getRememberMeFromCache() async {
    final rememberMeLoading = state.copyWith(rememberMeLoading: true);
    emit(rememberMeLoading);

    final rememberMe = await userRepository.getRememberedCredentials();
    emit(state.copyWith(rememberMe: rememberMe));

    final rememberMeLoadingDone = state.copyWith(rememberMeLoading: false);
    emit(rememberMeLoadingDone);
  }

  void onSubmit() async {
    final email = Email.validated(
      state.email.value,
      isRequired: true,
    );
    final password = Password.validated(
      state.password.value,
      shouldCheckStrength: false,
    );

    final isFormValid = Formz.validate([
      email,
      password,
    ]);

    final newState = state.copyWith(
      email: email,
      password: password,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        final user = await userRepository.signIn(
          email: email.value!,
          password: password.value!,
        );
        if (state.shouldRememberCredentials) {
          userRepository.cacheRememberedCredentials(
            email: email.value!,
            password: password.value!,
          );
        } else {
          userRepository.deleteRememberedCredentials();
        }

        final newState = state.copyWith(
          user: user,
          companyChoiceStatus: /*user.companies.length > 1
              ? */CompanyChoiceStatus.inProgress
              /*: CompanyChoiceStatus.initial*/,
          submissionStatus: user.companies.length < 2
              ? FormzSubmissionStatus.initial
              : FormzSubmissionStatus.inProgress,
        );

        emit(newState);

      } catch (error) {
        final newState = state.copyWith(
          password: Password.validated(password.value,
              invalidCredentials:
                  error is InvalidCredentialsException ? true : false,
              shouldCheckStrength: false),
          email: Email.validated(
            email.value,
            isRequired: true,
            invalidCredentials:
                error is InvalidCredentialsException ? true : false,
            invalidFormat: error is InvalidEmailFormatException ? true : false,
          ),
          submissionStatus: error is! InvalidCredentialsException &&
                  error is! InvalidEmailFormatException &&
                  error is! UserExpiredException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          error: error,
        );
        emit(newState);
      }
    }
  }

  Future onCompanySelected(Company company) async {
    final selectedSameCompany = company.id ==
        state.user!.companies.firstWhere((element) => element.isSelected).id;
    if (selectedSameCompany) {
      final companySelectionSuccess = state.copyWith(
        companyChoiceStatus: CompanyChoiceStatus.success,
        submissionStatus: FormzSubmissionStatus.success,
      );
      emit(companySelectionSuccess);
      return;
    }
    final companyRemoteSelectionInProgress = state.copyWith(
      companyBeingSelected: company,
      companyChoiceStatus: CompanyChoiceStatus.remoteSubmissionInProgress,
    );
    emit(companyRemoteSelectionInProgress);
    try {
      await userRepository.switchAccountCompany(companyId: company.id);
      final companySelectionSuccess = state.copyWith(
        companyChoiceStatus: CompanyChoiceStatus.success,
        submissionStatus: FormzSubmissionStatus.success,
      );
      emit(companySelectionSuccess);
    } catch (error) {
      final companySelectionFailure = state.copyWith(
        companyChoiceStatus: CompanyChoiceStatus.failure,
        submissionStatus: FormzSubmissionStatus.inProgress,
        error: error,
      );
      emit(companySelectionFailure);
      rethrow;
    }
  }
// @override
// Future<void> close() async {
//   return super.close();
// }
//   @override
//   Future<void> onChange(change) async {
//     print('+++++++${change.currentState.email}');
//     print('-------${change.nextState.email}');
//     super.onChange(change);
//   }
}
