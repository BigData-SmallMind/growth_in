import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/src/l10n/sign_in_localizations.dart';
import 'package:sign_in/src/sign_in_cubit.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpEmailFieldFocusListener();
  }

  void _setUpEmailFieldFocusListener() {
    final cubit = context.read<SignInCubit>();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        cubit.onEmailUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
      final cubit = context.read<SignInCubit>();
      final emailError = state.email.isNotValid ? state.email.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final theme = GrowthInTheme.of(context);
      final textTheme = Theme.of(context).textTheme;
      final l10n = SignInLocalizations.of(context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.emailTextFieldLabel} *',
            style: textTheme.titleSmall,
          ),
          VerticalGap.medium(),
          TextFormField(
            initialValue: state.rememberMe.email,
            enabled: !isSubmissionInProgress,
            focusNode: _emailFocusNode,
            onChanged: cubit.onEmailChanged,
            decoration: InputDecoration(
              isDense: true,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 0,
              ),
              hintText: l10n.emailTextFieldLabel,
              errorText: emailError == EmailValidationError.empty
                  ? l10n.requiredFieldErrorMessage
                  : emailError == EmailValidationError.invalidCredentials
                      ? l10n.invalidCredentialsErrorMessage
                      : emailError == EmailValidationError.invalidFormat
                          ? l10n.invalidEmailFormatErrorMessage
                          : null,
            ),
          ),
        ],
      );
    });
  }
}
