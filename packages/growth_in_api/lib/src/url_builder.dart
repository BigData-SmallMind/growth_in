class UrlBuilder {
  UrlBuilder._internal({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://laravel.growth-in.net/subgrowthin/api';

  final String _baseUrl;
  // static const String imageDownloadUrl = 'https://laravel.growth-in.net/subgrowthin/public/images';
  static const String filesDownloadUrl = 'https://laravel.growth-in.net/subgrowthin/public/files';

  static final UrlBuilder _instance = UrlBuilder._internal();

  factory UrlBuilder() {
    return _instance;
  }

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

  String buildGetRequestsUrl({
    required int page,
    String? searchText,
    String? status,
    List<int>? projectIds,
  }) {
    final pageQuery = '?page=$page';
    final searchTextQuery = searchText != null ? '&query=$searchText' : '';
    final statusQuery = status != null ? '&status=$status' : '';
    final projectNameQuery = projectIds != null && projectIds.isNotEmpty
        ? projectIds.indexed
            .map((indexedId) => '&project[${indexedId.$1}]=${indexedId.$2}')
            .reduce((value, element) => value + element)
        : '';

    final cgiParams = '$pageQuery'
        '$searchTextQuery'
        '$statusQuery'
        '$projectNameQuery';
    return '$_baseUrl/tasks$cgiParams';
  }

  String buildGetProjectsUrl() {
    return '$_baseUrl/fetch-project-companies';
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

  String buildToggleRequestCompleteUrl(bool isComplete, int requestId) {
    if (!isComplete) {
      return '$_baseUrl/mark-task-complete/$requestId';
    } else {
      return '$_baseUrl/mark-task-in-complete/$requestId';
    }
  }

  String buildToggleActionStepsCompleteUrl(
    bool isComplete,
    int actionId,
  ) {
    if (!isComplete) {
      return '$_baseUrl/mark-all-contents-complete/$actionId';
    } else {
      return '$_baseUrl/mark-all-contents-in-complete/$actionId';
    }
  }

  String buildToggleSingleActionStepCompleteUrl(
    bool isComplete,
    int actionId,
    int actionStepId,
  ) {
    if (!isComplete) {
      return '$_baseUrl/mark-content-task-complete/$actionStepId?item_id=$actionId';
    } else {
      return '$_baseUrl/mark-content-task-in-complete/$actionStepId?item_id=$actionId';
    }
  }

  String buildAddCommentUrl(
    int? actionId,
  ) {
    final actionIdSlug = actionId != null ? '/$actionId' : '/null';
    return '$_baseUrl/store-comment-task$actionIdSlug';
  }

  String buildGetMeetingsUrl() {
    return '$_baseUrl/meetings';
  }

  String buildGetMeetingTypesUrl() {
    return '$_baseUrl/meeting-types';
  }
}
