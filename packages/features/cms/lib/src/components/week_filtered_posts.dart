import 'package:component_library/component_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';

class WeekFilteredPosts extends StatelessWidget {
  const WeekFilteredPosts({
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
        final theme = GrowthInTheme.of(context);
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
                                  TextButton(
                                    onPressed: () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          height: 250,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                color: theme.secondaryColor,
                                                child: Row(
                                                  children: [
                                                    const Spacer(),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: CupertinoDatePicker(
                                                  showDayOfWeek: false,
                                                  dateOrder:
                                                      DatePickerDateOrder.ymd,
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  maximumYear:
                                                      DateTime.now().year + 1,
                                                  minimumYear:
                                                      DateTime.now().year - 1,
                                                  initialDateTime:
                                                      state.timelineTabDate,
                                                  onDateTimeChanged:
                                                      (dateTime) {
                                                    cubit.setTimelineTabMonth(
                                                        dateTime);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          state.timelineTabDate!
                                              .toIso8601String()
                                              .toString()
                                              .substring(0, 7),
                                        ),
                                        const Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                  VerticalGap.medium(),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: state.postsByWeek.length,
                                      itemBuilder: (context, index) {
                                        final weekPosts =
                                            state.postsByWeek[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${l10n.weekNumber} ${index + 1}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: const Color(
                                                          0xFF323232)),
                                            ),
                                            VerticalGap.large(),
                                            ColumnBuilder(
                                              itemCount: weekPosts.length,
                                              itemBuilder: (context, index) {
                                                final post = weekPosts[index];
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        DayNameWidget(
                                                          dateTime: post
                                                              .publicationDate,
                                                        ),
                                                        HorizontalGap.small(),
                                                        Expanded(
                                                          flex: 6,
                                                          child: PostCard(
                                                            post: post,
                                                            onTap: () => cubit
                                                                .onPostTapped(
                                                                    post),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    VerticalGap.medium(),
                                                  ],
                                                );
                                              },
                                            ),
                                            const Divider(),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                      );
      },
    );
  }
}
