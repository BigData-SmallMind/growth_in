class UrlBuilder {
  UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://laravel.growth-in.net/subgrowthin/api';

  final String _baseUrl;

  String buildSignInUrl() {
    final completeUrl = '$_baseUrl/login';
    return completeUrl;
  }

  String buildUpdateUserUrl() {
    final completeUrl = '$_baseUrl/updateUser';
    return completeUrl;
  }

  String buildUpdateAccountUrl() {
    final completeUrl = '$_baseUrl/update_user_setup';
    return completeUrl;
  }

  String buildChangePasswordUrl() {
    final completeUrl = '$_baseUrl/changePassword';
    return completeUrl;
  }

  buildSendOtpUrl(String email) {
    return '$_baseUrl/forget_email?email=$email';
  }

  buildReSendOtpUrl() {
    return '$_baseUrl/forget_email_verification';
  }

  buildVerifyOtpUrl(String email, String otp) {
    return '$_baseUrl/forget_email_verification?email=$email&otp=$otp';
  }

  buildResetPasswordUrl(
    String newPassword,
    String newPasswordConfirmation,
  ) {
    return '$_baseUrl/reset_password?new_password=$newPassword&new_password_confirmation=$newPasswordConfirmation';
  }
}
