import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:submit_ticket/src/l10n/submit_ticket_localizations.dart';
import 'package:submit_ticket/src/submit_ticket_cubit.dart';

class DescriptionTextField extends StatefulWidget {
  const DescriptionTextField({
    super.key,
  });

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpEmailFieldFocusListener();
  }

  void _setUpEmailFieldFocusListener() {
    final cubit = context.read<SubmitTicketCubit>();
    _descriptionFocusNode.addListener(() {
      if (!_descriptionFocusNode.hasFocus) {
        cubit.onDescriptionUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitTicketCubit, SubmitTicketState>(
        builder: (context, state) {
      final cubit = context.read<SubmitTicketCubit>();
      final descriptionError =
          state.description.isNotValid ? state.description.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final textTheme = Theme.of(context).textTheme;
      final l10n = SubmitTicketLocalizations.of(context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.descriptionTextFieldLabel} *',
            style: textTheme.titleSmall,
          ),
          VerticalGap.medium(),
          TextFormField(
            maxLength: 250,
            maxLines: 5,
            enabled: !isSubmissionInProgress,
            focusNode: _descriptionFocusNode,
            onChanged: cubit.onDescriptionChanged,
            decoration: InputDecoration(
              isDense: true,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 0,
              ),
              hintText: l10n.descriptionTextFieldLabel,
              errorText: descriptionError == DynamicValidationError.empty
                  ? l10n.requiredFieldErrorMessage
                  : null,
            ),
          ),
        ],
      );
    });
  }
}
