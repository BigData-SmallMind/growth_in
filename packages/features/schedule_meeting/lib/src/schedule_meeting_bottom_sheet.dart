import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart' as intl;
import 'package:meeting_repository/meeting_repository.dart';
import 'package:schedule_meeting/src/l10n/schedule_meeting_localizations.dart';
import 'package:schedule_meeting/src/schedule_meeting_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleMeetingBottomSheet extends StatelessWidget {
  const ScheduleMeetingBottomSheet({
    required this.meetingRepository,
    required this.meeting,
    required this.onCancellationSuccess,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final Meeting meeting;
  final VoidCallback onCancellationSuccess;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BlocProvider<ScheduleMeetingCubit>(
      create: (_) => ScheduleMeetingCubit(
        meetingRepository: meetingRepository,
        meeting: meeting,
        locale: locale,
        onSchedulingSuccess: onCancellationSuccess,
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
    final textTheme = Theme.of(context).textTheme;
    final l10n = ScheduleMeetingLocalizations.of(context);
    return BlocConsumer<ScheduleMeetingCubit, ScheduleMeetingState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<ScheduleMeetingCubit>();
        final isLoadingSlots = state.availableSlotsFetchStatus ==
            AvailableSlotsFetchStatus.loading;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.screenMargin,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SfDateRangePicker(
                backgroundColor: colorScheme.surface,
                showNavigationArrow: true,
                allowViewNavigation: true,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  backgroundColor: Colors.transparent,
                  textStyle: textTheme.titleMedium
                      ?.copyWith(color: theme.primaryColor),
                ),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  cubit.getAvailableSlots(args.value as DateTime);
                },
                // showActionButtons: true,
                // toggleDaySelection: true,
                enablePastDates: false,
                selectionMode: DateRangePickerSelectionMode.single,
              ),
              VerticalGap.medium(),
              Text(l10n.timeSlotsSectionTitle),
              VerticalGap.medium(),
              Expanded(
                child: isLoadingSlots
                    ? const CenteredCircularProgressIndicator()
                    : state.availableSlots?.isNotEmpty == true
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: Spacing.medium,
                              mainAxisSpacing: Spacing.medium,
                              mainAxisExtent: 50,
                            ),
                            itemCount: state.availableSlots!.length,
                            itemBuilder: (context, index) {
                              final meetingSlot = state.availableSlots![index];
                              return MeetingSlotWidget(
                                  meetingSlot: meetingSlot);
                            },
                          )
                        : Center(
                            child: Text(
                              l10n.noSlotsAvailableIndicatorText,
                              style: textTheme.titleLarge?.copyWith(),
                            ),
                          ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MeetingSlotWidget extends StatelessWidget {
  const MeetingSlotWidget({
    super.key,
    required this.meetingSlot,
  });

  final MeetingSlot meetingSlot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = GrowthInTheme.of(context).materialThemeData.colorScheme;
    final theme = GrowthInTheme.of(context);
    final outputFormat = intl.DateFormat("hh:mm a");

    final startTime = outputFormat.format(meetingSlot.start);
    final endTime = outputFormat.format(meetingSlot.end);
    return BlocBuilder<ScheduleMeetingCubit, ScheduleMeetingState>(
      builder: (context, state) {
        final cubit = context.read<ScheduleMeetingCubit>();
        final isSelected = state.selectedSlot == meetingSlot;
        return InkWell(
          onTap: () => cubit.selectMeetingSlot(meetingSlot),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? theme.primaryColor : theme.borderColor,
              ),
            ),
            child: Center(
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text('$startTime - $endTime')),
            ),
          ),
        );
      },
    );
  }
}
