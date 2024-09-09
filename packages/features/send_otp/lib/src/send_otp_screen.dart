import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:send_otp/src/components/email.dart';
import 'package:send_otp/src/components/send_otp_button.dart';
import 'package:send_otp/src/l10n/send_otp_localizations.dart';

import 'package:send_otp/src/send_otp_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({
    required this.userRepository,
    required this.onSendOtpSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onSendOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendOtpCubit>(
      create: (_) => SendOtpCubit(
        userRepository: userRepository,
      ),
      child: SendOtpView(
        onSendOtpSuccess: onSendOtpSuccess,
      ),
    );
  }
}

class SendOtpView extends StatelessWidget {
  const SendOtpView({
    super.key,
    required this.onSendOtpSuccess,
  });

  final VoidCallback onSendOtpSuccess;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    final l10n = SendOtpLocalizations.of(context);
    return BlocConsumer<SendOtpCubit, SendOtpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.otpSentSuccessfullySnackBarMessage,
            ),
          );
          onSendOtpSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.generalErrorSnackBarMessage,
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.releaseFocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: SvgAsset(AssetPathConstants.logoPath),
              actions: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(Spacing.small),
                    margin:  EdgeInsetsDirectional.only(end:theme.screenMargin),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.borderColor),
                    ),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                )
              ],
            ),

            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
              children: [
                VerticalGap.xxLarge(),
                Text(
                  l10n.sendOtpTitle,
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                VerticalGap.large(),
                Text(
                  l10n.sendOtpSubtitle,
                  style: textTheme.titleMedium,
                ),
                VerticalGap.xLarge(),
                const EmailTextField(),
                VerticalGap.xxLarge(),
                const SendOtpButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
