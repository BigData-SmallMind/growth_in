class OtpVerification {
  const OtpVerification({
    required this.email,
    required this.reason,
  });

  final String email;
  final OtpVerificationReason reason;

  bool get isResettingPassword => reason == OtpVerificationReason.resetPassword;

  bool get isChangingEmail => reason == OtpVerificationReason.changeEmail;
}

enum OtpVerificationReason {
  changeEmail,
  resetPassword,
}
