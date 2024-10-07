import 'package:change_password/src/change_password_cubit.dart';
import 'package:change_password/src/components/change_password_button.dart';
import 'package:change_password/src/components/components.dart';
import 'package:change_password/src/components/current_password.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({
    required this.userRepository,
    required this.onBackTapped,
    required this.onChangePasswordSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onChangePasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => ChangePasswordCubit(
        userRepository: userRepository,
      ),
      child: ChangePasswordView(
        onBackTapped: onBackTapped,
        onChangePasswordSuccess: onChangePasswordSuccess,
      ),
    );
  }
}

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({
    super.key,
    required this.onBackTapped,
    required this.onChangePasswordSuccess,
  });

  final VoidCallback onBackTapped;
  final VoidCallback onChangePasswordSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = ChangePasswordLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.changePasswordSuccessMessage,
              marginalSpace: EdgeInsets.only(
                left: theme.screenMargin,
                right: theme.screenMargin,
                bottom: Spacing.huge,
              ),
            ),
          );
          onChangePasswordSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
                context: context,
                message: l10n.generalErrorSnackBarMessage,
                marginalSpace: EdgeInsets.only(
                  left: theme.screenMargin,
                  right: theme.screenMargin,
                  bottom: Spacing.huge,
                )),
          );
          return;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: GrowthInAppBar(
              logoVariation: false,
              title: Text(l10n.changePasswordScreenTitle),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: theme.screenMargin,
              ),
              children: [
                VerticalGap.xLarge(),
                Text(
                  l10n.changePasswordScreenTitle,
                  style: textTheme.headlineSmall,
                ),
                VerticalGap.medium(),
                Text(
                  l10n.changePasswordScreenSubtitle,
                  style: textTheme.bodyMedium,
                ),
                VerticalGap.medium(),
                CurrentPassword(),
                VerticalGap.medium(),
                NewPassword(),
                VerticalGap.medium(),
                NewPasswordConfirmation(),
                VerticalGap.xLarge(),
                const ChangePasswordButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
