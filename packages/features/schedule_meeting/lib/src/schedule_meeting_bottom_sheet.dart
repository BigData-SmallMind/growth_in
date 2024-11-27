import 'package:domain_models/domain_models.dart';
import 'package:form_fields/form_fields.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:schedule_meeting/src/l10n/schedule_meeting_localizations.dart';
import 'package:schedule_meeting/src/schedule_meeting_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleMeetingBottomSheet extends StatelessWidget {
  const ScheduleMeetingBottomSheet({
    required this.meetingRepository,
    required this.meeting,
    required this.onSchedulingSuccess,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final Meeting meeting;
  final VoidCallback onSchedulingSuccess;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BlocProvider<ScheduleMeetingCubit>(
      create: (_) => ScheduleMeetingCubit(
        meetingRepository: meetingRepository,
        meeting: meeting,
        locale: locale,
        onSchedulingSuccess: onSchedulingSuccess,
      ),
      child: const ScheduleMeetingView(),
    );
  }
}

class ScheduleMeetingView extends StatelessWidget {
  const ScheduleMeetingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = GrowthInTheme.of(context).materialThemeData.colorScheme;
    final theme = GrowthInTheme.of(context);
    final l10n = ScheduleMeetingLocalizations.of(context);
    return BlocConsumer<ScheduleMeetingCubit, ScheduleMeetingState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<ScheduleMeetingCubit>();
        final isLoadingSlots = state.availableSlotsFetchStatus ==
            AvailableSlotsFetchStatus.loading;
        final schedulingInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.screenMargin,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MeetingSlotPicker(
                  expandCalendar: true,
                  isLoadingSlots: isLoadingSlots,
                  getAvailableSlots: cubit.getAvailableSlots,
                  availableSlots: state.availableSlots,
                  selectedMeetingSlot: state.selectedSlot,
                  selectMeetingSlot: cubit.selectMeetingSlot,
                  //TODO: implement getAvailableSlotsInMonth
                  // getAvailableSlotsInMonth: (){},
                  // availableSlotsInMonth: state.availableSlotsInMonth,
                ),
              ),
              schedulingInProgress
                  ? GrowthInElevatedButton.inProgress(
                      label: l10n.schedulingInProgressButtonLabel,
                    )
                  : GrowthInElevatedButton(
                      labelColor: state.selectedSlot == null
                          ? colorScheme.surface
                          : theme.errorColor,
                      borderColor: state.selectedSlot == null
                          ? theme.borderColor
                          : theme.errorColor,
                      bgColor: state.selectedSlot == null
                          ? theme.borderColor
                          : colorScheme.surface,
                      label: l10n.confirmMeetingScheduleButtonLabel,
                      onTap: state.selectedSlot == null
                          ? null
                          : cubit.scheduleMeeting,
                    ),
              VerticalGap.medium(),
            ],
          ),
        );
      },
    );
  }
}
