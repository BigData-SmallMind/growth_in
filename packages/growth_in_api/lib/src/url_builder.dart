class UrlBuilder {
  UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://laravel.growth-in.net/subgrowthin/api';

  final String _baseUrl;

  String buildSignInUrl() {
    final completeUrl = '$_baseUrl/login';
    return completeUrl;
  }

  String buildChooseAccountCompanyUrl(int companyId) {
    final completeUrl = '$_baseUrl/switch-company?company_id=$companyId';
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
    final completeUrl = '$_baseUrl/change-password';
    return completeUrl;
  }

  String buildChangeEmailUrl() {
    final completeUrl = '$_baseUrl/change-email';
    return completeUrl;
  }

  String buildSendOtpUrl(String email) {
    return '$_baseUrl/forget_email?email=$email';
  }

  String buildReSendOtpUrl() {
    return '$_baseUrl/forget_email_verification';
  }

  String buildGetTicketsUrl() {
    return '$_baseUrl/fetch-tickets';
  }

  String buildGetTicketsTypesUrl() {
    return '$_baseUrl/message-types';
  }

  String buildSubmitTicketUrl() {
    return '$_baseUrl/tickets';
  }

  String buildGetTicketMessagesUrl(int ticketId) {
    return '$_baseUrl/fetch-messages-ticket/$ticketId';
  }

  String buildCreateMessageUrl(int ticketId) {
    return '$_baseUrl/message/$ticketId';
  }

  String buildChangeEmailOtpVerificationUrl() {
    return '$_baseUrl/change-email-verification';
  }

  String buildVerifyOtpUrl(String email, String otp) {
    return '$_baseUrl/forget_email_verification?email=$email&otp=$otp';
  }

  String buildResetPasswordUrl(
    String newPassword,
    String newPasswordConfirmation,
  ) {
    return '$_baseUrl/reset_password?new_password=$newPassword&new_password_confirmation=$newPasswordConfirmation';
  }

  String buildGetRequestsUrl() {
    return '$_baseUrl/tasks';
  }

  String buildGetRequestUrl(int requestId) {
    return '$_baseUrl/tasks/$requestId';
  }

  String buildGetCommentsUrl(int? requestId, int? actionId) {
    // assert (requestId != null || actionId != null);
    assert(requestId != null || actionId != null);
    if (requestId != null) {
      return '$_baseUrl/fetch-comment-task/null?task_id=$requestId';
    }
    if (actionId != null) {
      return '$_baseUrl/fetch-comment-task/$actionId';
    }
    return '';
  }
}
