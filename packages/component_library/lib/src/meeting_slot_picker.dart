import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart' as intl;

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MeetingSlotPicker extends StatelessWidget {
  const MeetingSlotPicker({
    super.key,
    required this.isLoadingSlots,
    this.availableSlots,
    required this.getAvailableSlots,
    required this.selectedMeetingSlot,
    required this.selectMeetingSlot,
    required this.expandCalendar
  });

  final bool isLoadingSlots;
  final List<MeetingSlot>? availableSlots;
  final void Function(DateTime) getAvailableSlots;
  final MeetingSlot? selectedMeetingSlot;
  final void Function(MeetingSlot) selectMeetingSlot;
  final bool expandCalendar;
  @override
  Widget build(BuildContext context) {
    final colorScheme = GrowthInTheme.of(context).materialThemeData.colorScheme;
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SfDateRangePicker(
          backgroundColor: colorScheme.surface,
          showNavigationArrow: true,
          allowViewNavigation: true,
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Colors.transparent,
            textStyle:
                textTheme.titleMedium?.copyWith(color: theme.primaryColor),
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            getAvailableSlots(args.value as DateTime);
          },
          enablePastDates: false,
          selectionMode: DateRangePickerSelectionMode.single,
        ),
        VerticalGap.medium(),
        Text(l10n.timeSlotsSectionTitle),
        VerticalGap.medium(),
        if(expandCalendar)
        Expanded(
          child: isLoadingSlots
              ? const CenteredCircularProgressIndicator()
              : availableSlots?.isNotEmpty == true
                  ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Spacing.medium,
                        mainAxisSpacing: Spacing.medium,
                        mainAxisExtent: 50,
                      ),
                      itemCount: availableSlots!.length,
                      itemBuilder: (context, index) {
                        final meetingSlot = availableSlots![index];
                        return MeetingSlotWidget(
                          meetingSlot: meetingSlot,
                          selectedMeetingSlot: selectedMeetingSlot,
                          selectMeetingSlot: selectMeetingSlot,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        l10n.noSlotsAvailableIndicatorText,
                        style: textTheme.titleLarge,
                      ),
                    ),
        ),
        if(!expandCalendar)
        isLoadingSlots
            ? const CenteredCircularProgressIndicator()
            : availableSlots?.isNotEmpty == true
            ? GridView.builder(
          shrinkWrap: true,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Spacing.medium,
            mainAxisSpacing: Spacing.medium,
            mainAxisExtent: 50,
          ),
          itemCount: availableSlots!.length,
          itemBuilder: (context, index) {
            final meetingSlot = availableSlots![index];
            return MeetingSlotWidget(
              meetingSlot: meetingSlot,
              selectedMeetingSlot: selectedMeetingSlot,
              selectMeetingSlot: selectMeetingSlot,
            );
          },
        )
            : Center(
          child: Text(
            l10n.noSlotsAvailableIndicatorText,
            style: textTheme.titleLarge,
          ),
        ),

        VerticalGap.medium(),
      ],
    );
  }
}

class MeetingSlotWidget extends StatelessWidget {
  const MeetingSlotWidget({
    super.key,
    required this.meetingSlot,
    required this.selectedMeetingSlot,
    required this.selectMeetingSlot,
  });

  final MeetingSlot meetingSlot;
  final MeetingSlot? selectedMeetingSlot;
  final void Function(MeetingSlot) selectMeetingSlot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = GrowthInTheme.of(context).materialThemeData.colorScheme;
    final theme = GrowthInTheme.of(context);
    final outputFormat = intl.DateFormat("hh:mm a");
    final startTime = outputFormat.format(meetingSlot.start);
    final endTime = outputFormat.format(meetingSlot.end);
    final isSelected = selectedMeetingSlot == meetingSlot;
    return InkWell(
      onTap: () => selectMeetingSlot(meetingSlot),
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
  }
}
