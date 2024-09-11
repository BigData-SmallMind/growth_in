import 'package:component_library/component_library.dart';
import 'package:reset_password/src/reset_password_cubit.dart';
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
    final cubit = context.read<ResetPasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordConfirmationUnfocused();
      } else {
        cubit.onNewPasswordConfirmationFocused();
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
        final error = state.newPasswordConfirmation.isNotValid
            ? state.newPasswordConfirmation.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final textTheme = Theme.of(context).textTheme;
        // final theme = GrowthInTheme.of(context);
        final cubit = context.read<ResetPasswordCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'l10n.newPasswordConfirmationTextFieldLabel'' *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'l10n.newPasswordConfirmationTextFieldHint',
                errorText: error == PasswordConfirmationValidationError.empty
                    ? 'l10n.requiredFieldErrorMessage'
                    : error == PasswordConfirmationValidationError.doesNotMatch
                        ? 'l10n.passwordConfirmationTextFieldDoesNotMatchError'
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
