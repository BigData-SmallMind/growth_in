import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/cms_cubit.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class MonthlyViewDatePicker extends StatelessWidget {
  const MonthlyViewDatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CmsCubit>();
    final theme = GrowthInTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CmsCubit, CmsState>(
      builder: (context, state) {
        return SfDateRangePicker(
          backgroundColor: colorScheme.surface,
          selectionColor: Colors.transparent,
          showNavigationArrow: true,
          allowViewNavigation: false,
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Colors.transparent,
            textStyle:
                textTheme.titleMedium?.copyWith(color: theme.primaryColor),
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          cellBuilder: (context, cellDetails) {
            final isPostDay = cubit.hasPost(cellDetails.date);
            final hasAcceptedPost = cubit.hasAcceptedPost(cellDetails.date);
            final hasNewPost = cubit.hasNewPost(cellDetails.date);
            final hasEditingPost = cubit.hasEditingPost(cellDetails.date);

            final isSelected =
                state.calendarTabDate?.year == cellDetails.date.year &&
                    state.calendarTabDate?.month == cellDetails.date.month &&
                    state.calendarTabDate?.day == cellDetails.date.day;

            return Stack(
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
                      color: isSelected
                          ? colorScheme.surface
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
                if (isPostDay)
                  Positioned.fill(
                    bottom: 5,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (hasAcceptedPost)
                            Icon(
                              Icons.circle,
                              size: 5,
                              color: isSelected
                                  ? colorScheme.surface
                                  : theme.acceptedPostColor,
                            ),
                          if (hasNewPost)
                            Icon(
                              Icons.circle,
                              size: 5,
                              color: isSelected
                                  ? colorScheme.surface
                                  : theme.newPostColor,
                            ),
                          if (hasEditingPost)
                            Icon(
                              Icons.circle,
                              size: 5,
                              color: isSelected
                                  ? colorScheme.surface
                                  : theme.editingPostColor,
                            ),
                        ],
                      ),
                    ),
                  )
              ],
            );
          },
          onSelectionChanged: (args) {
            cubit.setCalendarTabDate(args.value as DateTime);
          },
        );
      },
    );
  }
}
