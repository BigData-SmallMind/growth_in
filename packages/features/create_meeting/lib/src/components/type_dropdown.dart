import 'package:component_library/component_library.dart';
import 'package:create_meeting/src/create_meeting_cubit.dart';
import 'package:create_meeting/src/l10n/create_meeting_localizations.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class TypeDropdown extends StatelessWidget {
  const TypeDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final error =
            state.selectedType.isNotValid ? state.selectedType.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<CreateMeetingCubit>();
        final l10n = CreateMeetingLocalizations.of(context);
        final theme = GrowthInTheme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'l10n.typeTextFieldLabel'} *',
              style: textTheme.titleSmall,
            ),
            VerticalGap.medium(),
            DropdownButton<MeetingType>(
              isExpanded: true,

              value: state.selectedType.value,
              items: state.meetingTypes
                  .map(
                    (meetingType) => DropdownMenuItem(
                      value: meetingType,
                      child: Text(meetingType.name),
                    ),
                  )
                  .toList(),
              onChanged: isSubmissionInProgress
                  ? null
                  : (meetingType) => cubit.onMeetingTypeChanged(meetingType!),
            ),
            if (error != null) ...[
              VerticalGap.small(),
              Text(
                l10n.requiredFieldErrorMessage,
                style: textTheme.bodySmall?.copyWith(color: theme.errorColor),
              ),
            ],
          ],
        );
      },
    );
  }
}
