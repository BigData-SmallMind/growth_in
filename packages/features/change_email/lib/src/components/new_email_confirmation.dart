import 'package:component_library/component_library.dart';
import 'package:change_email/src/l10n/change_email_localizations.dart';
import 'package:change_email/src/change_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class NewEmailConfirmation extends StatefulWidget {
  const NewEmailConfirmation({
    super.key,
  });

  @override
  State<NewEmailConfirmation> createState() =>
      _NewEmailConfirmationState();
}

class _NewEmailConfirmationState extends State<NewEmailConfirmation> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangeEmailCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewEmailConfirmationUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  bool isEmailVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
      builder: (context, state) {
        final error = state.newEmailConfirmation.isNotValid
            ? state.newEmailConfirmation.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final textTheme = Theme.of(context).textTheme;
        // final theme = GrowthInTheme.of(context);
        final cubit = context.read<ChangeEmailCubit>();
        final l10n = ChangeEmailLocalizations.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.newEmailConfirmationTextFieldLabel + ' *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              obscuringCharacter: '*',
              obscureText: !isEmailVisible,
              focusNode: _focusNode,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => isEmailVisible = !isEmailVisible),
                  child: Icon(
                    isEmailVisible ? Icons.visibility_off : Icons.visibility,
                    size: 25,
                  ),
                ),
                hintText: l10n.newEmailConfirmationTextFieldHint,
                errorText: error == EmailConfirmationValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : error == EmailConfirmationValidationError.doesNotMatch
                        ? l10n.emailConfirmationTextFieldDoesNotMatchError
                        : null,
              ),
              onChanged: cubit.onNewEmailConfirmationChanged,
              enabled: !isSubmissionInProgress,
              onEditingComplete: cubit.onSubmit,
            ),
          ],
        );
      },
    );
  }
}
