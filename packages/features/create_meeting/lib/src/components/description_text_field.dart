import 'package:component_library/component_library.dart';
import 'package:create_meeting/src/create_meeting_cubit.dart';
import 'package:create_meeting/src/l10n/create_meeting_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<CreateMeetingCubit>();
        final l10n = CreateMeetingLocalizations.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.descriptionTextFieldLabel,
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            TextField(
              onChanged: cubit.onDescriptionChanged,
              enabled: !isSubmissionInProgress,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: l10n.descriptionTextFieldHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
