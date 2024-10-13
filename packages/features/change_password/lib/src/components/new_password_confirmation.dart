import 'package:component_library/component_library.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';
import 'package:change_password/src/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class NewPasswordConfirmation extends StatefulWidget {
  const NewPasswordConfirmation({
    super.key,
  });

  @override
  State<NewPasswordConfirmation> createState() =>
      _NewPasswordConfirmationState();
}

class _NewPasswordConfirmationState extends State<NewPasswordConfirmation> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangePasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordConfirmationUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        final error = state.newPasswordConfirmation.isNotValid
            ? state.newPasswordConfirmation.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final textTheme = Theme.of(context).textTheme;
        // final theme = GrowthInTheme.of(context);
        final cubit = context.read<ChangePasswordCubit>();
        final l10n = ChangePasswordLocalizations.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.newPasswordConfirmationTextFieldLabel} *',
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
                hintText: l10n.newPasswordConfirmationTextFieldHint,
                errorText: error == PasswordConfirmationValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : error == PasswordConfirmationValidationError.doesNotMatch
                        ? l10n.passwordConfirmationTextFieldDoesNotMatchError
                        : null,
              ),
              onChanged: cubit.onNewPasswordConfirmationChanged,
              enabled: !isSubmissionInProgress,
              onEditingComplete: cubit.onSubmit,
            ),
          ],
        );
      },
    );
  }
}
