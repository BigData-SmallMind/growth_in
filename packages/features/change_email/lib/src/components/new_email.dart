import 'package:change_email/src/l10n/change_email_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:change_email/src/change_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class NewEmail extends StatefulWidget {
  const NewEmail({
    super.key,
  });

  @override
  State<NewEmail> createState() => _NewEmailState();
}

class _NewEmailState extends State<NewEmail> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangeEmailCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewEmailUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEmailCubit, ChangeEmailState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final error = state.newEmail.isNotValid ? state.newEmail.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangeEmailCubit>();
        final l10n = ChangeEmailLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.newEmailTextFieldLabel} *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              obscuringCharacter: '*',
              focusNode: _focusNode,
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                errorText: error == EmailValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : error == EmailValidationError.invalidFormat
                        ? l10n.invalidEmailFormatErrorMessage
                        : error == EmailValidationError.alreadyRegistered
                            ? l10n.emailTextFieldAlreadyRegisteredError
                            : null,
                hintText: l10n.emailTextFieldHint,
              ),
              onChanged: cubit.onNewEmailChanged,
              enabled: !isSubmissionInProgress,
            ),
          ],
        );
      },
    );
  }
}
