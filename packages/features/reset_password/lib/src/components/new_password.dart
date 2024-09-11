import 'package:component_library/component_library.dart';
import 'package:reset_password/src/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    super.key,
  });

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ResetPasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordUnfocused();
      } else {
        cubit.onNewPasswordFocused();
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
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final error =
            state.newPassword.isNotValid ? state.newPassword.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ResetPasswordCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'l10n.newPasswordTextFieldLabel' ' *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                errorText: error == PasswordValidationError.empty
                    ? 'l10n.requiredFieldErrorMessage'
                    : error == PasswordValidationError.weak
                        ? 'l10n.passwordTextFieldWeakPasswordError'
                        : null,
                hintText: 'l10n.passwordTextFieldHint',
              ),
              onChanged: cubit.onNewPasswordChanged,
              enabled: !isSubmissionInProgress,
            ),
          ],
        );
      },
    );
  }
}
