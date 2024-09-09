class UrlBuilder {
  UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://laravel.growth-in.net/growthin/api';

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

  buildSendOtpUrl() {
    return '$_baseUrl/sendOtp';
  }
  buildVerifyOtpUrl() {
    return '$_baseUrl/verifyOtp';
  }

  buildResetPasswordUrl() {
    return '$_baseUrl/resetPassword';
  }
}
