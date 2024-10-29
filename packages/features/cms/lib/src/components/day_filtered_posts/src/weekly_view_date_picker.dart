import 'package:component_library/component_library.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/cms_cubit.dart';

class WeeklyViewDatePicker extends StatefulWidget {
  const WeeklyViewDatePicker({
    super.key,
  });

  @override
  State<WeeklyViewDatePicker> createState() => _WeeklyViewDatePickerState();
}

class _WeeklyViewDatePickerState extends State<WeeklyViewDatePicker> {
  final datePickerController = DatePickerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      datePickerController.jumpToSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final cubit = context.read<CmsCubit>();
    return BlocBuilder<CmsCubit, CmsState>(
      builder: (context, state) {
        return DatePicker(
          DateTime.now().subtract(
            const Duration(days: 365),
          ),
          height: 100,
          initialSelectedDate: state.calendarTabDate,
          selectionColor: theme.secondaryColor,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            cubit.setCalendarTabDate(date);
          },
          controller: datePickerController,
          calendarType: CalendarType.gregorianDate,
        );
      },
    );
  }
}
