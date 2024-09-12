import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:more/more.dart';
import 'package:reset_password/reset_password.dart';

import 'package:routemaster/routemaster.dart';
import 'package:send_otp/send_otp.dart';
import 'package:sign_in/sign_in.dart';
import 'package:switch_account_company/switch_account_company.dart';
import 'package:tab_container/tab_container.dart';
import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required ValueNotifier<bool> signInSuccessVN,
}) {
  return {
    _PathConstants.tabContainerPath: (_) => TabPage(
          backBehavior: TabBackBehavior.history,
          paths: [
            _PathConstants.homePath,
            _PathConstants.homePath,
            _PathConstants.homePath,
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
              routerDelegate.push(_PathConstants.resetPasswordPath);
            },
            otpVerification: userRepository.changeNotifier.otpVerification!,
          ),
        ),
    // Task paths
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get tabContainerPath => '/';

  static String get homePath => '${tabContainerPath}home';

  static String get morePath => '${tabContainerPath}more';

  static String get sendOtpPath => '${tabContainerPath}send-otp';

  static String get verifyOtpPath => '${tabContainerPath}verify-otp';

  static String get resetPasswordPath => '${tabContainerPath}reset-password';
}
