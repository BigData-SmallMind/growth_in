import 'package:change_email/src/l10n/change_email_localizations.dart';
import 'package:change_email/src/change_email_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';





class ChangeEmailButton extends StatelessWidget {
  const ChangeEmailButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangeEmailCubit>();
        // final theme = GrowthInTheme.of(context);
        final l10n = ChangeEmailLocalizations.of(context);
        return isSubmissionInProgress
            ? GrowthInElevatedButton.inProgress(
                label: l10n.submissionInProgressButtonLabel,
              )
            : GrowthInElevatedButton(
                onTap: cubit.onSubmit,
                label: l10n.submitButtonLabel,
              );
      },
    );
  }
}

