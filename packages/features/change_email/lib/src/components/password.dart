import 'package:change_email/src/change_email_cubit.dart';
import 'package:change_email/src/l10n/change_email_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
  });

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  final _focusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangeEmailCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPasswordUnfocused();
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
        final error = state.password.isNotValid ? state.password.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangeEmailCubit>();
        final l10n = ChangeEmailLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.passwordTextFieldLabel} *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              obscuringCharacter: '*',
              obscureText: !isPasswordVisible,
              focusNode: _focusNode,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => isPasswordVisible = !isPasswordVisible),
                  child: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    size: 25,
                  ),
                ),
                errorText: error == PasswordValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : error == PasswordValidationError.invalidCredentials
                        ? l10n.invalidPasswordsErrorMessage
                        : null,
                hintText: l10n.passwordTextFieldHint,
              ),
              onChanged: cubit.onPasswordChanged,
              enabled: !isSubmissionInProgress,
            ),
          ],
        );
      },
    );
  }
}
