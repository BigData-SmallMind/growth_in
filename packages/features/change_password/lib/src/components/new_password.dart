import 'package:component_library/component_library.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';
import 'package:change_password/src/change_password_cubit.dart';
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
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangePasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordUnfocused();
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
        final error =
            state.newPassword.isNotValid ? state.newPassword.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangePasswordCubit>();
        final l10n = ChangePasswordLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.newPasswordTextFieldLabel} *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              obscuringCharacter: '*',
              obscureText: !isPasswordVisible,
              focusNode: _focusNode,
              decoration: InputDecoration(
                prefix: error == PasswordValidationError.weak
                    ? GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.passwordTextFieldWeakPasswordErrorDescription,
                              style: textTheme.titleMedium,
                            ),
                          ),

                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
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
                    : error == PasswordValidationError.weak
                        ? l10n.passwordTextFieldWeakPasswordError
                        : null,
                hintText: l10n.passwordTextFieldHint,
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
