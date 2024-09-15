import 'package:component_library/component_library.dart';
import 'package:change_email/src/l10n/change_email_localizations.dart';
import 'package:change_email/src/change_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class CurrentEmail extends StatefulWidget {
  const CurrentEmail({
    super.key,
  });

  @override
  State<CurrentEmail> createState() => _CurrentEmailState();
}

class _CurrentEmailState extends State<CurrentEmail> {
  final _focusNode = FocusNode();
  bool isEmailVisible = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangeEmailCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onCurrentEmailUnfocused();
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
        final error = state.currentEmail.isNotValid
            ? state.currentEmail.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangeEmailCubit>();
        final l10n = ChangeEmailLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.currentEmailTextFieldLabel + ' *',
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
                errorText: error == EmailValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : error == EmailValidationError.invalidCredentials
                        ? l10n.wrongEmailErrorMessage
                        : null,
                hintText: l10n.currentEmailTextFieldHint,
              ),
              onChanged: cubit.onCurrentEmailChanged,
              enabled: !isSubmissionInProgress,
            ),
          ],
        );
      },
    );
  }
}
