import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:verify_otp/src/l10n/verify_otp_localizations.dart';

import 'package:verify_otp/src/verify_otp_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({
    required this.userRepository,
    required this.onVerifyOtpSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyOtpCubit>(
      create: (_) => VerifyOtpCubit(
        userRepository: userRepository,
      ),
      child: VerifyOtpView(
        onVerifyOtpSuccess: onVerifyOtpSuccess,
      ),
    );
  }
}

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({
    required this.onVerifyOtpSuccess,
    super.key,
  });

  final VoidCallback onVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Scaffold(
        appBar: const GrowthInAppBar(
          logoVariation: false,
        ),
        extendBody: true,
        body: _VerifyOtpForm(
          onVerifyOtpSuccess: onVerifyOtpSuccess,
        ),
      ),
    );
  }
}

class _VerifyOtpForm extends StatelessWidget {
  const _VerifyOtpForm({
    required this.onVerifyOtpSuccess,
  });

  final VoidCallback onVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = VerifyOtpLocalizations.of(context);
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus ||
          oldState.resendOtpStatus != newState.resendOtpStatus,
      listener: (context, state) {
        if (state.resendOtpStatus == ResendOtpStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.otpResentSuccessfullySnackBarMessage,
            ),
          );
        }
        if (state.resendOtpStatus == ResendOtpStatus.error) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.otpResentErrorSnackBarMessage,
            ),
          );
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.otpVerifiedSuccessfullySnackBarMessage,
            ),
          );
          onVerifyOtpSuccess();
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
        final otpCodeError =
            state.otpCode.isNotValid ? state.otpCode.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;

        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<VerifyOtpCubit>();
        final theme = GrowthInTheme.of(context);

        return Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: theme.screenMargin,
            ),
            children: [
              Text(
                l10n.verifyOtpTitle,
                style: textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              VerticalGap.smallMedium(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: state.otpVerification?.isChangingEmail == true
                          ? l10n.changeEmailSubtitle
                          : l10n.verifyOtpSubtitle,
                      style: textTheme
                          .bodyMedium, // Default style for the subtitle
                    ),
                    TextSpan(
                      text: ' ${state.otpVerification?.email}', // Email text
                      style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold), // Make email bold
                    ),
                  ],
                ),
              ),
              VerticalGap.large(),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  controller: cubit.pinTEController,
                  length: 6,
                  appContext: context,
                  cursorHeight: 20,
                  enablePinAutofill: false,
                  onChanged: cubit.onOtpCodeChanged,
                  onCompleted: (_) => cubit.onSubmit(),
                  textStyle: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 45,
                    fieldWidth: 45,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(10),
                    activeBorderWidth: 1,
                    disabledBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    errorBorderWidth: 1,
                    selectedBorderWidth: 1,
                    activeColor: otpCodeError != null ? theme.errorColor : null,
                    activeFillColor: theme.primaryColor,
                    inactiveColor: otpCodeError != null
                        ? theme.errorColor
                        : theme.borderColor,
                  ),
                  separatorBuilder: (context, index) => index == 2
                      ? const Padding(
                          padding: EdgeInsets.only(
                              bottom: Spacing.mediumLarge),
                          child: Icon(
                            Icons.minimize,
                          ),
                        )
                      : HorizontalGap.smallMedium(),
                ),
              ),
              if (otpCodeError != null) ...[
                const SizedBox(
                  height: Spacing.xSmall,
                ),
                if (otpCodeError == OtpCodeValidationError.empty ||
                    otpCodeError == OtpCodeValidationError.incomplete)
                  Text(
                    l10n.requiredFieldErrorMessage,
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.errorColor,
                    ),
                  ),
                if (otpCodeError == OtpCodeValidationError.incorrect)
                  Text(
                    l10n.incorrectOtpCodeErrorMessage,
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.errorColor,
                    ),
                  ),
              ],
              const SizedBox(
                height: Spacing.huge,
              ),
              VerticalGap.large(),
              const ResendOtp(),
              VerticalGap.large(),
              isSubmissionInProgress
                  ? GrowthInElevatedButton.inProgress(
                      label: l10n.verifyingOtpButtonLabel)
                  : GrowthInElevatedButton(
                      label: l10n.verifyOtpButtonLabel,
                      onTap: cubit.onSubmit,
                    ),
            ],
          ),
        );
      },
    );
  }
}
