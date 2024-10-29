import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';


class CalendarViewTypeDropdown extends StatelessWidget {
  const CalendarViewTypeDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CmsCubit>();
    final l10n = CmsLocalizations.of(context);
    return BlocBuilder<CmsCubit, CmsState>(
      builder: (context, state) {
        return DropdownButton(
          items: CalendarTabViewType.values
              .map(
                (calendarTabViewType) => DropdownMenuItem<CalendarTabViewType>(
                  value: calendarTabViewType,
                  child: Text(
                    calendarViewTypeToString(
                      calendarTabViewType,
                      l10n,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            cubit.setCalendarTabViewType(value);
          },
          value: state.calendarTabViewType,
        );
      },
    );
  }
}

String calendarViewTypeToString(
  CalendarTabViewType calendarTabViewType,
  CmsLocalizations l10n,
) {
  switch (calendarTabViewType) {
    case CalendarTabViewType.month:
      return l10n.monthDropdownItemLabel;
    case CalendarTabViewType.week:
      return l10n.weekDropdownItemLabel;
  }
}

