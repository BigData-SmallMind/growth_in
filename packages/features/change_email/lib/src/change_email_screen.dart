import 'package:change_email/src/change_email_cubit.dart';
import 'package:change_email/src/components/components.dart';
import 'package:change_email/src/l10n/change_email_localizations.dart';
import 'package:change_email/src/l10n/change_password_localizations.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({
    required this.userRepository,
    required this.onBackTapped,
    required this.onChangeEmailSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onChangeEmailSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeEmailCubit>(
      create: (_) => ChangeEmailCubit(
        userRepository: userRepository,
      ),
      child: ChangeEmailView(
        onBackTapped: onBackTapped,
        onChangeEmailSuccess: onChangeEmailSuccess,
      ),
    );
  }
}

class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({
    super.key,
    required this.onBackTapped,
    required this.onChangeEmailSuccess,
  });

  final VoidCallback onBackTapped;
  final VoidCallback onChangeEmailSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = ChangeEmailLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ChangeEmailCubit, ChangeEmailState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.changeEmailSuccessMessage,
              marginalSpace: EdgeInsets.only(
                left: theme.screenMargin,
                right: theme.screenMargin,
                bottom: Spacing.huge,
              ),
            ),
          );
          onChangeEmailSuccess();
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
              title: l10n.changeEmailScreenTitle,
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: theme.screenMargin,
              ),
              children: [
                VerticalGap.xLarge(),
                Text(
                  l10n.changeEmailScreenTitle,
                  style: textTheme.headlineSmall,
                ),
                VerticalGap.medium(),
                Text(
                  l10n.changeEmailScreenSubtitle,
                  style: textTheme.bodyMedium,
                ),
                VerticalGap.medium(),
                NewEmail(),
                VerticalGap.medium(),
                NewEmailConfirmation(),
                VerticalGap.xLarge(),
                const ChangeEmailButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
