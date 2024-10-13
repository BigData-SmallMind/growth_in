import 'package:component_library/component_library.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';
import 'package:change_password/src/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class CurrentPassword extends StatefulWidget {
  const CurrentPassword({
    super.key,
  });

  @override
  State<CurrentPassword> createState() => _CurrentPasswordState();
}

class _CurrentPasswordState extends State<CurrentPassword> {
  final _focusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangePasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onCurrentPasswordUnfocused();
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
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final error = state.currentPassword.isNotValid
            ? state.currentPassword.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangePasswordCubit>();
        final l10n = ChangePasswordLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.currentPasswordTextFieldLabel} *',
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
                        ? l10n.wrongPasswordErrorMessage
                        : null,
                hintText: l10n.currentPasswordTextFieldHint,
              ),
              onChanged: cubit.onCurrentPasswordChanged,
              enabled: !isSubmissionInProgress,
            ),
          ],
        );
      },
    );
  }
}
