import 'package:cms/src/components/day_filtered_posts/src/calendar_view_dropdown.dart';
import 'package:cms/src/components/day_filtered_posts/src/monthly_view_date_picker.dart';
import 'package:cms/src/components/day_filtered_posts/src/weekly_view_date_picker.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';

class DayFilteredPosts extends StatelessWidget {
  const DayFilteredPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CmsCubit, CmsState>(
      builder: (context, state) {
        final l10n = CmsLocalizations.of(context);
        final loading =
            state.postsFetchingStatus == PostsFetchingStatus.inProgress;
        final error = state.postsFetchingStatus == PostsFetchingStatus.failure;
        final isEmptyList = state.posts?.isEmpty == true;
        final cubit = context.read<CmsCubit>();
        final shouldShowMonthlyView =
            state.calendarTabViewType == CalendarTabViewType.month;
        final shouldShowWeeklyView =
            state.calendarTabViewType == CalendarTabViewType.week;
        return loading
            ? const CenteredCircularProgressIndicator()
            : error
                ? ExceptionIndicator(
                    onTryAgain: cubit.getPosts,
                  )
                : isEmptyList
                    ? EmptyListIndicator(
                        onRefresh: cubit.getPosts,
                      )
                    : RefreshIndicator(
                        onRefresh: cubit.getPosts,
                        child: state.posts!.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.emptyListIndicatorText,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerticalGap.medium(),
                                  const CalendarViewTypeDropdown(),
                                  VerticalGap.medium(),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        if (shouldShowMonthlyView)
                                          const MonthlyViewDatePicker(),
                                        if (shouldShowWeeklyView)
                                          const WeeklyViewDatePicker(),
                                        VerticalGap.medium(),
                                        ColumnBuilder(
                                          itemCount:
                                              state.dayFilteredPosts.length,
                                          itemBuilder: (context, index) {
                                            final post =
                                                state.dayFilteredPosts[index];
                                            return Column(
                                              children: [
                                                PostCard(
                                                  post: post,
                                                  onTap: () =>
                                                      cubit.onPostTapped(post),
                                                ),
                                                VerticalGap.medium(),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      );
      },
    );
  }
}
