import 'package:component_library/component_library.dart';
import 'package:create_meeting/src/create_meeting_cubit.dart';
import 'package:create_meeting/src/l10n/create_meeting_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class TitleTextField extends StatefulWidget {
  const TitleTextField({
    super.key,
  });

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateMeetingCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onTitleUnfocused();
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
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final error = state.title.isNotValid ? state.title.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<CreateMeetingCubit>();
        final l10n = CreateMeetingLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.titleTextFieldLabel} *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              obscuringCharacter: '*',
              focusNode: _focusNode,
              decoration: InputDecoration(
                errorText: error == DynamicValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : null,
                hintText: l10n.titleTextFieldHint,
              ),
              onChanged: cubit.onTitleChanged,
              enabled: !isSubmissionInProgress,
            ),
          ],
        );
      },
    );
  }
}
