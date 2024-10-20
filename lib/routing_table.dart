import 'package:action/action.dart';
import 'package:action_comments/action_comments.dart';
import 'package:change_email/change_email.dart';
import 'package:change_password/change_password.dart';
import 'package:chat/chat.dart';
import 'package:create_meeting/create_meeting.dart';
import 'package:delete_meeting/delete_meeting.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_section/form_section.dart';
import 'package:forms/forms.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:home/home.dart';
import 'package:meeting_details/meeting_details.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:meetings/meetings.dart';
import 'package:more/more.dart';
import 'package:profile_info/profile_info.dart';
import 'package:profile_settings/profile_settings.dart';
import 'package:request_actions/request_actions.dart';
import 'package:request_comments/request_comments.dart';
import 'package:request_details/request_details.dart';
import 'package:request_repository/request_repository.dart';
import 'package:requests/requests.dart';
import 'package:reset_password/reset_password.dart';

import 'package:routemaster/routemaster.dart';
import 'package:schedule_meeting/schedule_meeting.dart';
import 'package:search_meetings/search_meetings.dart';
import 'package:send_otp/send_otp.dart';
import 'package:sign_in/sign_in.dart';
import 'package:submit_ticket/submit_ticket.dart';
import 'package:switch_account_company/switch_account_company.dart';
import 'package:tab_container/tab_container.dart';
import 'package:ticket_messages/ticket_messages.dart';
import 'package:tickets/tickets.dart';
import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required RequestRepository requestRepository,
  required MeetingRepository meetingRepository,
  required ValueNotifier<bool> signInSuccessVN,
  required ValueNotifier<bool> isUserUnAuthSC,
}) {
  routerDelegate.addListener(() {
    debugPrint('${routerDelegate.currentConfiguration?.path}');
  });
  isUserUnAuthSC.addListener(() {
    if (isUserUnAuthSC.value) {
      signInSuccessVN.value = false;
    }
  });
  final meetingDetailsScreen = Builder(builder: (context) {
    return MeetingDetailsScreen(
      meetingRepository: meetingRepository,
      downloadUrl: UrlBuilder.filesDownloadUrl,
      onCancelMeetingTapped: (Meeting meeting) => showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => DeleteMeetingBottomSheet(
          meetingRepository: meetingRepository,
          meeting: meeting,
          onCancellationSuccess: () async {
            final isCurrentRouteSearch = routerDelegate
                    .currentConfiguration?.path
                    .contains(_PathConstants.searchMeetingsPath) ==
                true;
            await routerDelegate.pop();
            await routerDelegate.pop();
            if (isCurrentRouteSearch) {
              await routerDelegate.pop();
            }
          },
        ),
      ),
      onScheduleMeetingTapped: (Meeting meeting) => showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) => ScheduleMeetingBottomSheet(
          meetingRepository: meetingRepository,
          meeting: meeting,
          onSchedulingSuccess: () async {
            await routerDelegate.pop();
          },
        ),
      ),
    );
  });
  return {
    _PathConstants.tabContainerPath: (_) => TabPage(
          backBehavior: TabBackBehavior.history,
          paths: [
            _PathConstants.homePath,
            _PathConstants.homePath,
            _PathConstants.chatPath,
            _PathConstants.homePath,
            _PathConstants.morePath,
          ],
          child: BackButtonListener(
            onBackButtonPressed: () async {
              return routerDelegate.history.canGoBack ? false : true;
            },
            child: ValueListenableBuilder(
              valueListenable: signInSuccessVN,
              builder: (context, signInSuccess, __) {
                return signInSuccess
                    ? TabContainerScreen(
                        userRepository: userRepository,
                      )
                    : SignInScreen(
                        userRepository: userRepository,
                        onForgotPasswordTapped: () =>
                            routerDelegate.push(_PathConstants.sendOtpPath),
                        onSignInSuccess: () => signInSuccessVN.value = true,
                      );
              },
            ),
          ),
        ),
    _PathConstants.homePath: (_) => MaterialPage(
          name: 'home',
          child: HomeScreen(
            userRepository: userRepository,
            onLogout: () => signInSuccessVN.value = false,
          ),
        ),
    _PathConstants.chatPath: (_) => MaterialPage(
          name: 'chat',
          child: ChatScreen(
            userRepository: userRepository,
          ),
        ),
    _PathConstants.morePath: (_) => MaterialPage(
          name: 'more',
          child: Builder(builder: (context) {
            return MoreScreen(
              userRepository: userRepository,
              onCompanyTileTap: () => showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) => SwitchAccountCompanyBottomSheet(
                  userRepository: userRepository,
                ),
              ),
              onLogout: () => signInSuccessVN.value = false,
              onProfileSettingsTapped: () =>
                  routerDelegate.push(_PathConstants.profileSettingsPath),
              onRequestsTapped: () =>
                  routerDelegate.push(_PathConstants.requestsPath),
              onFormsTapped: () =>
                  routerDelegate.push(_PathConstants.formsPath),
              onMeetingsTapped: () =>
                  routerDelegate.push(_PathConstants.meetingsPath),
              onHelpAndSupportTapped: () =>
                  routerDelegate.push(_PathConstants.ticketsPath),
            );
          }),
        ),
    _PathConstants.requestsPath: (_) => MaterialPage(
          name: 'requests',
          child: Builder(builder: (context) {
            return RequestsScreen(
              requestRepository: requestRepository,
              onRequestTapped: (int requestId) => routerDelegate.push(
                  _PathConstants.requestDetailsPath(requestId: requestId)),
            );
          }),
        ),
    _PathConstants.requestDetailsPath(): (info) => MaterialPage(
          name: 'request-details',
          child: Builder(builder: (context) {
            final requestId = int.parse(
              info.pathParameters[_PathConstants.requestIdPathParameter] ?? '',
            );
            return RequestDetailsScreen(
              requestRepository: requestRepository,
              requestId: requestId,
              onViewAllActionsTapped: () => routerDelegate.push(
                _PathConstants.requestActionsPath(
                  requestId: requestId,
                ),
              ),
              onViewActionStepsTapped: (int actionId) => routerDelegate.push(
                _PathConstants.actionPath(
                  requestId: requestId,
                  actionId: actionId,
                ),
              ),
              onViewAllCommentsTapped: () => routerDelegate.push(
                _PathConstants.requestCommentsPath(
                  requestId: requestId,
                ),
              ),
            );
          }),
        ),
    _PathConstants.requestCommentsPath(): (info) => MaterialPage(
          name: 'request-comments',
          child: RequestCommentsScreen(
            requestRepository: requestRepository,
            requestId: int.parse(
              info.pathParameters[_PathConstants.requestIdPathParameter] ?? '',
            ),
          ),
        ),
    _PathConstants.requestActionsPath(): (info) => MaterialPage(
          name: 'request-actions',
          child: Builder(builder: (context) {
            return RequestActionsScreen(
              requestRepository: requestRepository,
              onViewActionStepsTapped: (int actionId) => routerDelegate.push(
                _PathConstants.actionPath(
                  requestId: int.parse(
                    info.pathParameters[
                            _PathConstants.requestIdPathParameter] ??
                        '',
                  ),
                  actionId: actionId,
                ),
              ),
            );
          }),
        ),
    _PathConstants.actionPath(): (info) {
      final requestId = int.parse(
        info.pathParameters[_PathConstants.requestIdPathParameter] ?? '',
      );
      final actionId = int.parse(
        info.pathParameters[_PathConstants.actionIdPathParameter] ?? '',
      );
      return MaterialPage(
        name: 'action',
        child: ActionScreen(
          requestRepository: requestRepository,
          onBackTapped: routerDelegate.popRoute,
          actionId: actionId,
          onViewAllCommentsTapped: () => routerDelegate.push(
            _PathConstants.actionCommentsPath(
              requestId: requestId,
              actionId: actionId,
            ),
          ),
        ),
      );
    },
    _PathConstants.actionCommentsPath(): (info) => MaterialPage(
          name: 'action-comments',
          child: ActionCommentsScreen(
            requestRepository: requestRepository,
            actionId: int.parse(
              info.pathParameters[_PathConstants.actionIdPathParameter] ?? '',
            ),
          ),
        ),
    _PathConstants.formsPath: (_) => MaterialPage(
          name: 'forms',
          child: Builder(
            builder: (context) {
              return FormsScreen(
                userRepository: userRepository,
                imageDownloadUrl: UrlBuilder.imageDownloadUrl,
                onFormTapped: (formId) => routerDelegate.push(
                  _PathConstants.formSectionPath(
                    formId: formId,
                  ),
                ),
              );
            },
          ),
        ),
    _PathConstants.formSectionPath(): (info) {
      final formId = int.parse(
        info.pathParameters['formId'] ?? '',
      );
      return MaterialPage(
        name: 'form-section',
        child: FormSectionScreen(
          userRepository: userRepository,
          imageDownloadUrl: UrlBuilder.imageDownloadUrl,
          formId: formId,
        ),
      );
    },
    _PathConstants.meetingsPath: (_) => MaterialPage(
          name: 'meetings',
          child: Builder(builder: (context) {
            return MeetingsScreen(
              meetingRepository: meetingRepository,
              onViewAllTapped: () =>
                  routerDelegate.push(_PathConstants.searchMeetingsPath),
              onCreateMeetingTapped: () => routerDelegate.push(
                _PathConstants.createMeetingPath,
              ),
              onMeetingTapped: (int meetingId) => routerDelegate.push(
                _PathConstants.meetingDetailsPath(
                  meetingId: meetingId,
                ),
              ),
              onCancelMeetingTapped: (Meeting meeting) => showModalBottomSheet(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => DeleteMeetingBottomSheet(
                  meetingRepository: meetingRepository,
                  meeting: meeting,
                  onCancellationSuccess: () async {
                    await routerDelegate.pop();
                  },
                ),
              ),
              onScheduleMeetingTapped: (Meeting meeting) =>
                  showModalBottomSheet(
                showDragHandle: true,
                isScrollControlled: true,
                useSafeArea: true,
                context: context,
                builder: (context) => ScheduleMeetingBottomSheet(
                  meetingRepository: meetingRepository,
                  meeting: meeting,
                  onSchedulingSuccess: () async {
                    await routerDelegate.pop();
                  },
                ),
              ),
            );
          }),
        ),
    _PathConstants.createMeetingPath: (_) => MaterialPage(
          name: 'create-meeting',
          child: Builder(builder: (context) {
            return CreateMeetingScreen(
              meetingRepository: meetingRepository,
              userRepository: userRepository,
            );
          }),
        ),
    _PathConstants.searchMeetingsPath: (_) => MaterialPage(
          name: 'search-meetings',
          child: SearchMeetingsScreen(
            meetingRepository: meetingRepository,
            oMeetingTapped: (int meetingId) => routerDelegate.push(
              _PathConstants.meetingDetailsPathTwo(
                meetingId: meetingId,
              ),
            ),
          ),
        ),
    _PathConstants.meetingDetailsPath(): (info) {
      return MaterialPage(
        name: 'meeting-details',
        child: meetingDetailsScreen,
      );
    },
    _PathConstants.meetingDetailsPathTwo(): (info) {
      return MaterialPage(
        name: 'meeting-details-two',
        child: meetingDetailsScreen,
      );
    },
    _PathConstants.profileSettingsPath: (_) => MaterialPage(
          name: 'profile-settings',
          child: ProfileSettingsScreen(
            onProfileInfoTapped: () =>
                routerDelegate.push(_PathConstants.profileInfoPath),
            onChangePasswordTapped: () => routerDelegate.push(
              _PathConstants.changePasswordPath,
            ),
            onChangeEmailTapped: () => routerDelegate.push(
              _PathConstants.changeEmailPath,
            ),
          ),
        ),
    _PathConstants.profileInfoPath: (_) => MaterialPage(
          name: 'profile-info',
          child: ProfileInfoScreen(
            userRepository: userRepository,
          ),
        ),
    _PathConstants.changePasswordPath: (_) => MaterialPage(
          name: 'change-password',
          child: ChangePasswordScreen(
            userRepository: userRepository,
            onBackTapped: routerDelegate.popRoute,
            onChangePasswordSuccess: () async {
              await routerDelegate.popRoute();
              routerDelegate.popRoute();
            },
          ),
        ),
    _PathConstants.changeEmailPath: (_) => MaterialPage(
          name: 'change-email',
          child: ChangeEmailScreen(
            userRepository: userRepository,
            onBackTapped: routerDelegate.popRoute,
            onChangeEmailSuccess: () =>
                routerDelegate.push(_PathConstants.verifyOtpPath),
          ),
        ),
    _PathConstants.ticketsPath: (_) => MaterialPage(
          name: 'tickets',
          child: Builder(builder: (context) {
            return TicketsScreen(
              userRepository: userRepository,
              onAddTicketTapped: () => showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                useSafeArea: true,
                showDragHandle: true,
                builder: (_) => SubmitTicketBottomSheet(
                  userRepository: userRepository,
                ),
              ),
              navigateToTicketMessages: (int ticketId) => routerDelegate
                  .push(_PathConstants.ticketMessagesPath(ticketId: ticketId)),
            );
          }),
        ),
    _PathConstants.ticketMessagesPath(): (_) => MaterialPage(
          name: 'ticket-messages',
          child: Builder(builder: (context) {
            return TicketMessagesScreen(
              userRepository: userRepository,
            );
          }),
        ),
    _PathConstants.resetPasswordPath: (_) => MaterialPage(
          name: 'reset-password',
          child: ResetPasswordScreen(
            userRepository: userRepository,
            onResetPasswordSuccess: () async {
              await routerDelegate.popRoute();
              routerDelegate.popRoute();
            },
            onBackTapped: routerDelegate.popRoute,
          ),
        ),
    _PathConstants.sendOtpPath: (_) => MaterialPage(
          name: 'send-otp',
          child: SendOtpScreen(
            userRepository: userRepository,
            onSendOtpSuccess: () async {
              await routerDelegate.popRoute();
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
          ),
        ),
    _PathConstants.verifyOtpPath: (_) => MaterialPage(
          name: 'verify-otp',
          child: VerifyOtpScreen(
            userRepository: userRepository,
            onVerifyOtpSuccess: () async {
              await routerDelegate.popRoute();
              final otpVerification =
                  userRepository.changeNotifier.otpVerification;
              if (otpVerification?.isResettingPassword == true) {
                routerDelegate.push(_PathConstants.resetPasswordPath);
              }
              if (otpVerification?.isChangingEmail == true) {
                await routerDelegate.popRoute();
                routerDelegate.popRoute();
              }
            },
          ),
        ),
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get ticketIdPathParameter => 'ticket-id';

  static String get requestIdPathParameter => 'request-id';

  static String get actionIdPathParameter => 'action-id';

  static String get tabContainerPath => '/';

  static String get homePath => '${tabContainerPath}home';

  static String get chatPath => '${tabContainerPath}chat';

  static String get morePath => '${tabContainerPath}more';

  static String get requestsPath => '${tabContainerPath}requests';

  static String get formsPath => '${tabContainerPath}forms';

  static String formSectionPath({
    int? formId,
  }) {
    final completePath = '$formsPath'
        '/${formId ?? ':formId'}';
    return completePath;
  }

  static String get meetingsPath => '${tabContainerPath}meetings';

  static String get createMeetingPath => '$meetingsPath/create';

  static String get searchMeetingsPath => '$meetingsPath/search';

  static String get meetingIdPathParameter => 'meetingId';

  static String meetingDetailsPath({
    int? meetingId,
  }) {
    final completePath = '$meetingsPath'
        '/${meetingId ?? ':$meetingIdPathParameter'}';
    return completePath;
  }

  static String meetingDetailsPathTwo({
    int? meetingId,
  }) {
    final completePath = '$searchMeetingsPath'
        '/${meetingId ?? ':$meetingIdPathParameter'}';
    return completePath;
  }

  static String requestDetailsPath({int? requestId}) =>
      '$requestsPath/${requestId ?? ':$requestIdPathParameter'}';

  static String requestCommentsPath({int? requestId}) =>
      '${requestDetailsPath(requestId: requestId)}/comments';

  static String requestActionsPath({int? requestId}) =>
      '${requestDetailsPath(requestId: requestId)}/actions';

  static String actionPath({
    String? currentUrl,
    int? requestId,
    int? actionId,
  }) {
    final isRequestDetailsPath = currentUrl?.contains('details') == true;
    final currentPath = isRequestDetailsPath
        ? requestDetailsPath(requestId: requestId)
        : requestActionsPath(requestId: requestId);
    final completePath = '$currentPath'
        '/${actionId ?? ':$actionIdPathParameter'}';
    return completePath;
  }

  static String actionCommentsPath({
    int? requestId,
    int? actionId,
  }) {
    final currentPath = actionPath(
      requestId: requestId,
      actionId: actionId,
    );
    final completePath = '$currentPath/comments';
    return completePath;
  }

  static String get profileSettingsPath =>
      '${tabContainerPath}profile-settings';

  static String get ticketsPath => '${tabContainerPath}tickets';

  static String ticketMessagesPath({int? ticketId}) =>
      '$ticketsPath/${ticketId ?? ':$ticketIdPathParameter'}/messages';

  static String get profileInfoPath => '$profileSettingsPath/profile-info';

  static String get changePasswordPath =>
      '$profileSettingsPath/change-password';

  static String get changeEmailPath => '$profileSettingsPath/change-email';

  static String get sendOtpPath => '${tabContainerPath}send-otp';

  static String get verifyOtpPath => '${tabContainerPath}verify-otp';

  static String get resetPasswordPath => '${tabContainerPath}reset-password';
}
