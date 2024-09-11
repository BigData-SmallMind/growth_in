part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.shouldRememberCredentials = true,
    this.rememberMeLoading = false,
    this.rememberMe = const RememberMe(),
    this.email = const Email.unvalidated(),
    this.password = const Password.unvalidated(),
    this.error,
    this.user,
    this.companyChoiceStatus = CompanyChoiceStatus.initial,
    this.companyBeingSelected,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool shouldRememberCredentials;
  final bool rememberMeLoading;
  final RememberMe rememberMe;
  final Email email;
  final Password password;
  final dynamic error;
  final User? user;
  final CompanyChoiceStatus companyChoiceStatus;
  final Company? companyBeingSelected;
  final FormzSubmissionStatus submissionStatus;

  SignInState copyWith({
    bool? shouldRememberCredentials,
    bool? rememberMeLoading,
    RememberMe? rememberMe,
    Email? email,
    Password? password,
    dynamic error,
    User? user,
    CompanyChoiceStatus? companyChoiceStatus,
    Company? companyBeingSelected,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SignInState(
      shouldRememberCredentials:
          shouldRememberCredentials ?? this.shouldRememberCredentials,
      rememberMeLoading: rememberMeLoading ?? this.rememberMeLoading,
      rememberMe: rememberMe ?? this.rememberMe,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error,
      user: user ?? this.user,
      companyChoiceStatus: companyChoiceStatus ?? this.companyChoiceStatus,
      companyBeingSelected: companyBeingSelected ?? this.companyBeingSelected,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        shouldRememberCredentials,
        rememberMeLoading,
        rememberMe,
        email,
        password,
        error,
        user,
        companyChoiceStatus,
        companyBeingSelected,
        submissionStatus,
      ];
}

enum CompanyChoiceStatus {
  initial,
  inProgress,
  remoteSubmissionInProgress,
  success,
  failure;
}
