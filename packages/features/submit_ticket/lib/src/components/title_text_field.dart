import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:submit_ticket/src/l10n/submit_ticket_localizations.dart';
import 'package:submit_ticket/src/submit_ticket_cubit.dart';

class TitleTextField extends StatefulWidget {
  const TitleTextField({
    super.key,
  });

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  final _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpTitleFieldFocusListener();
  }

  void _setUpTitleFieldFocusListener() {
    final cubit = context.read<SubmitTicketCubit>();
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        cubit.onTitleUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitTicketCubit, SubmitTicketState>(
        builder: (context, state) {
      final cubit = context.read<SubmitTicketCubit>();
      final titleError = state.title.isNotValid ? state.title.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final textTheme = Theme.of(context).textTheme;
      final l10n = SubmitTicketLocalizations.of(context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.titleTextFieldLabel} *',
            style: textTheme.titleSmall,
          ),
          VerticalGap.medium(),
          TextFormField(
            enabled: !isSubmissionInProgress,
            focusNode: _titleFocusNode,
            onChanged: cubit.onTitleChanged,
            maxLength: 50,
            decoration: InputDecoration(
              isDense: true,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 0,
              ),
              hintText: l10n.titleTextFieldLabel,
              errorText: titleError == DynamicValidationError.empty
                  ? l10n.requiredFieldErrorMessage
                  : null,
            ),
          ),
        ],
      );
    });
  }
}
