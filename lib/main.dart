import 'dart:io';
import 'package:action_comments/action_comments.dart';
import 'package:action/action.dart';
import 'package:change_email/change_email.dart';
import 'package:change_password/change_password.dart';
import 'package:chat/chat.dart';
import 'package:component_library/component_library.dart';
import 'package:create_meeting/create_meeting.dart';
import 'package:delete_meeting/delete_meeting.dart';
import 'package:dio/dio.dart';
import 'package:domain_models/domain_models.dart';
import 'package:files/files.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:folders/folders.dart';
import 'package:form_section/form_section.dart';
import 'package:forms/forms.dart';
import 'package:growth_in/firebase_options.dart';
import 'package:growth_in/routing_table.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:home/home.dart';
import 'package:key_value_storage/key_value_storage.dart';
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

String? fontFamily;

final ValueNotifier<bool> _isUserUnAuthVN = ValueNotifier(false);
final ValueNotifier<InternetConnectionGrowthInException?>
    _internetConnectionErrorVN = ValueNotifier(null);
final ValueNotifier<bool> _signInSuccessVN = ValueNotifier(false);

final dynamic _connectInApi = GrowthInApi(
  urlBuilder: UrlBuilder(),
  dio: Dio(),
  userTokenSupplier: () => _userRepository.getUserToken(),
  otpVerificationTokenSupplier: () =>
      _userRepository.getOtpVerificationTokenSupplierToken(),
  isUserUnAuthenticatedVN: _isUserUnAuthVN,
  internetConnectionErrorVN: _internetConnectionErrorVN,
);

final _userRepository = UserRepository(
  remoteApi: _connectInApi,
  noSqlStorage: _keyValueStorage,
);
final _requestRepository = RequestRepository(
  remoteApi: _connectInApi,
  noSqlStorage: _keyValueStorage,
);
final _meetingRepository = MeetingRepository(
  remoteApi: _connectInApi,
  noSqlStorage: _keyValueStorage,
);
final _folderRepository = FolderRepository(
  remoteApi: _connectInApi,
  noSqlStorage: _keyValueStorage,
);

final _keyValueStorage = KeyValueStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(
    const GrowthIn(),
  );
}

class GrowthIn extends StatefulWidget {
  const GrowthIn({
    super.key,
  });

  @override
  GrowthInState createState() => GrowthInState();
}

class GrowthInState extends State<GrowthIn> with WidgetsBindingObserver {
  Brightness? _appBrightness;

  @override
  void initState() {
    super.initState();
    _userRepository.getUser().first.then((user) {
      _signInSuccessVN.value = user?.id != null;
    });
    _userRepository.upsertLocalePreference(LocalePreferenceDM.arabic);
    WidgetsBinding.instance.addObserver(this);
  }

  // This callback is invoked every time the platform brightness changes.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Get the brightness.
    setState(() {
      _appBrightness = View.of(context).platformDispatcher.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late final dynamic _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
          requestRepository: _requestRepository,
          meetingRepository: _meetingRepository,
          folderRepository: _folderRepository,
          signInSuccessVN: _signInSuccessVN,
          isUserUnAuthSC: _isUserUnAuthVN,
        ),
      );
    },
  );
  final _lightTheme = LightGrowthInThemeData();
  final _darkTheme = DarkGrowthInThemeData();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalePreferenceDM?>(
      stream: _userRepository.getLocalePreference(),
      builder: (context, snapshot) {
        final localePreference = snapshot.data;

        final isArabic = localePreference?.toLocale() == const Locale('ar');
        if (Platform.isAndroid) {
          fontFamily = isArabic ? 'Cairo' : 'Gotham';
        } else if (Platform.isIOS) {
          fontFamily = isArabic ? 'Cairo' : null;
        }
        return GrowthInTheme(
          context: context,
          lightTheme: _lightTheme,
          darkTheme: _darkTheme,
          child: AnnotatedRegion(
            // To control the system nav bar when it is changed
            // and when the widget first initializes
            value: _appBrightness == Brightness.dark ||
                    SchedulerBinding
                            .instance.platformDispatcher.platformBrightness ==
                        Brightness.dark
                ? SystemUiOverlayStyle.light.copyWith(
                    systemNavigationBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: Colors.black,
                  )
                : SystemUiOverlayStyle.light.copyWith(
                    systemNavigationBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white,
                  ),
            child: MaterialApp.router(
              theme: _lightTheme.materialThemeData.copyWith(
                textTheme: _lightTheme.materialThemeData.textTheme.apply(
                  fontFamily: fontFamily,
                ),
              ),
              darkTheme: _darkTheme.materialThemeData.copyWith(
                textTheme: _darkTheme.materialThemeData.textTheme.apply(
                  fontFamily: fontFamily,
                ),
              ),
              themeMode: ThemeMode.light,
              builder: (context, child) {
                return Directionality(
                  textDirection:
                      isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: InternetErrorIndicator(
                    child: child!,
                  ),
                );
              },
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                // Global Localizations
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                ComponentLibraryLocalizations.delegate,
                TabContainerLocalizations.delegate,
                MoreLocalizations.delegate,
                HomeLocalizations.delegate,
                ChatLocalizations.delegate,

                // Authentication
                SignInLocalizations.delegate,
                SendOtpLocalizations.delegate,
                VerifyOtpLocalizations.delegate,
                ResetPasswordLocalizations.delegate,
                ChangePasswordLocalizations.delegate,
                ChangeEmailLocalizations.delegate,
                SwitchAccountCompanyLocalizations.delegate,

                // Profile
                ProfileSettingsLocalizations.delegate,
                ProfileInfoLocalizations.delegate,
                TicketsLocalizations.delegate,
                SubmitTicketLocalizations.delegate,
                TicketMessagesLocalizations.delegate,

                // Requests
                RequestsLocalizations.delegate,
                RequestDetailsLocalizations.delegate,
                RequestActionsLocalizations.delegate,
                ActionLocalizations.delegate,
                ActionCommentsLocalizations.delegate,
                RequestCommentsLocalizations.delegate,

                // Meetings
                MeetingsLocalizations.delegate,
                SearchMeetingsLocalizations.delegate,
                MeetingDetailsLocalizations.delegate,
                DeleteMeetingLocalizations.delegate,
                ScheduleMeetingLocalizations.delegate,
                CreateMeetingLocalizations.delegate,

                // Forms
                FormsLocalizations.delegate,
                FormSectionLocalizations.delegate,

                //Files and folders
                FilesLocalizations.delegate,
                FoldersLocalizations.delegate,
              ],
              // locale: const Locale('en'),
              locale: localePreference?.toLocale(),
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              routerDelegate: _routerDelegate,
              routeInformationParser: const RoutemasterParser(),
            ),
          ),
        );
      },
    );
  }
}

class InternetErrorIndicator extends StatefulWidget {
  const InternetErrorIndicator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<InternetErrorIndicator> createState() => _InternetErrorIndicatorState();
}

class _InternetErrorIndicatorState extends State<InternetErrorIndicator> {
  @override
  void initState() {
    super.initState();
    _internetConnectionErrorVN.addListener(
      () {
        if (_internetConnectionErrorVN.value != null) {
          showSnackBar(
            context: context,
            snackBar: const InternetErrorSnackBar(),
          );
        }
      },
    );

    _isUserUnAuthVN.addListener(
      () {
        if (_isUserUnAuthVN.value) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: ComponentLibraryLocalizations.of(context)
                  .unAuthSnackBarErrorMessage,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}

extension on LocalePreferenceDM {
  Locale toLocale() {
    switch (this) {
      case LocalePreferenceDM.english:
        return const Locale('en');
      case LocalePreferenceDM.arabic:
        return const Locale('ar');
    }
  }
}
