import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart' as intl;

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MeetingSlotPicker extends StatefulWidget {
  const MeetingSlotPicker({
    super.key,
    required this.isLoadingSlots,
    this.availableSlots,
    required this.getAvailableSlots,
    required this.selectedMeetingSlot,
    required this.selectMeetingSlot,
    required this.expandCalendar,
    required this.fetchAvailableSlotsInMonth,
    required this.availableSlotsInMonth ,
    required this.isLoadingAvailableSlotsInAMonth,
    required this.selectedDate,
  });

  final bool isLoadingSlots;
  final List<MeetingSlot>? availableSlots;
  final void Function(DateTime) getAvailableSlots;
  final MeetingSlot? selectedMeetingSlot;
  final void Function(MeetingSlot) selectMeetingSlot;
  final bool expandCalendar;
  final ValueSetter<DateTime>? fetchAvailableSlotsInMonth;
  final List<MeetingSlotAvailable>? availableSlotsInMonth;
  final bool isLoadingAvailableSlotsInAMonth;
  final DateTime? selectedDate;

  @override
  State<MeetingSlotPicker> createState() => _MeetingSlotPickerState();
}

class _MeetingSlotPickerState extends State<MeetingSlotPicker> {
  DateTime? currentDate;

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
          selectionColor: Colors.transparent,
          showNavigationArrow: true,
          allowViewNavigation: true,
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Colors.transparent,
            textStyle:
                textTheme.titleMedium?.copyWith(color: theme.primaryColor),
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            widget.getAvailableSlots(args.value as DateTime);
          },
          onViewChanged: (DateRangePickerViewChangedArgs args) {
            if (widget.fetchAvailableSlotsInMonth == null) return;
            widget.fetchAvailableSlotsInMonth!(
              args.visibleDateRange.startDate!,
            );
          },
          cellBuilder: (context, cellDetails) {
            final hasFreeSlots = widget.availableSlotsInMonth?.any(
              (meetingSlotAvailable) =>
                  meetingSlotAvailable.date.year == cellDetails.date.year &&
                  meetingSlotAvailable.date.month == cellDetails.date.month &&
                  meetingSlotAvailable.date.day == cellDetails.date.day &&
                  meetingSlotAvailable.hasFreeSlots,
            );
            final isSelected =
                widget.selectedDate?.year == cellDetails.date.year &&
                    widget.selectedDate?.month == cellDetails.date.month &&
                    widget.selectedDate?.day == cellDetails.date.day;
            final isPastDate = cellDetails.date
                .isBefore(DateTime.now().subtract(const Duration(days: 1)));
            return widget.isLoadingAvailableSlotsInAMonth
                ? const SizedBox()
                : Stack(
                    children: [
                      Container(
                        width: cellDetails.bounds.width,
                        height: cellDetails.bounds.height,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? theme.primaryColor : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cellDetails.date.day.toString(),
                          style: textTheme.bodyMedium?.copyWith(
                            color: isPastDate
                                ? Colors.grey
                                : isSelected
                                    ? colorScheme.surface
                                    : colorScheme.onSurface,
                          ),
                        ),
                      ),
                      hasFreeSlots == true
                          ? Positioned.fill(
                              bottom: 5,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  Icons.circle,
                                  size: 5,
                                  color: isSelected
                                      ? colorScheme.surface
                                      : Colors.green,
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  );
          },
          enablePastDates: false,
          selectionMode: DateRangePickerSelectionMode.single,
        ),
        VerticalGap.medium(),
        Text(l10n.timeSlotsSectionTitle),
        VerticalGap.medium(),
        if (widget.expandCalendar)
          Expanded(
            child: widget.isLoadingSlots
                ? const CenteredCircularProgressIndicator()
                : widget.availableSlots?.isNotEmpty == true
                    ? GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Spacing.medium,
                          mainAxisSpacing: Spacing.medium,
                          mainAxisExtent: 50,
                        ),
                        itemCount: widget.availableSlots!.length,
                        itemBuilder: (context, index) {
                          final meetingSlot = widget.availableSlots![index];
                          return MeetingSlotWidget(
                            meetingSlot: meetingSlot,
                            selectedMeetingSlot: widget.selectedMeetingSlot,
                            selectMeetingSlot: widget.selectMeetingSlot,
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
        if (!widget.expandCalendar)
          widget.isLoadingSlots
              ? const CenteredCircularProgressIndicator()
              : widget.availableSlots?.isNotEmpty == true
                  ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Spacing.medium,
                        mainAxisSpacing: Spacing.medium,
                        mainAxisExtent: 50,
                      ),
                      itemCount: widget.availableSlots!.length,
                      itemBuilder: (context, index) {
                        final meetingSlot = widget.availableSlots![index];
                        return MeetingSlotWidget(
                          meetingSlot: meetingSlot,
                          selectedMeetingSlot: widget.selectedMeetingSlot,
                          selectMeetingSlot: widget.selectMeetingSlot,
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
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => selectMeetingSlot(meetingSlot),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.secondary : colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? theme.primaryColor : theme.borderColor,
          ),
        ),
        child: Center(
          child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                '$startTime - $endTime',
                style: textTheme.bodyMedium?.copyWith(
                  color: isSelected ? colorScheme.surface : null,
                ),
              )),
        ),
      ),
    );
  }
}
