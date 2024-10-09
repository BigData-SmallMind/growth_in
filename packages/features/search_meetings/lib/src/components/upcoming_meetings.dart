import 'package:domain_models/domain_models.dart';
import 'package:search_meetings/src/l10n/search_meetings_localizations.dart';
import 'package:search_meetings/src/search_meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class UpcomingMeeting extends StatelessWidget {
//   const UpcomingMeeting({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SearchMeetingsCubit, SearchMeetingsState>(
//       builder: (context, state) {
//         final meeting = state.meetings?.latestUpcoming;
//         final l10n = SearchMeetingsLocalizations.of(context);
//
//         return meeting != null
//             ? Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   DayNameWidget(
//                     dateTime: meeting.startDate!,
//                   ),
//                   HorizontalGap.medium(),
//                   Expanded(
//                     child: MeetingCard(
//                       meeting: meeting,
//                       type: MeetingCardVariation.upcoming,
//                     ),
//                   ),
//                 ],
//               )
//             : Container(
//                 height: 150,
//                 child: Center(
//                   child: Text(l10n.listIsEmptyText),
//                 ),
//               );
//       },
//     );
//   }
// }

class UpcomingMeetings extends StatelessWidget {
  const UpcomingMeetings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMeetingsCubit, SearchMeetingsState>(
      builder: (context, state) {
        final emptyList = state.meetings?.upcoming.isEmpty == true;
        final upcomingMeetings = state.upcomingMeetings;
        final l10n = SearchMeetingsLocalizations.of(context);
        final theme = GrowthInTheme.of(context);
        final cubit = context.read<SearchMeetingsCubit>();
        return emptyList
            ? Center(
                child: Text(l10n.listIsEmptyText),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                itemBuilder: (context, index) {
                  final month = upcomingMeetings.keys.toList()[index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(month),
                          HorizontalGap.small(),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      VerticalGap.mediumLarge(),
                      ColumnBuilder(
                        itemBuilder: (context, index) {
                          final meeting = upcomingMeetings[month]![index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DayNameWidget(
                                dateTime: meeting.startDate!,
                              ),
                              HorizontalGap.medium(),
                              Expanded(
                                child: MeetingCard(
                                  meeting: meeting,
                                  type: MeetingCardVariation.upcoming,
                                  onTap: () =>
                                      cubit.onMeetingDetailsTapped(meeting),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: upcomingMeetings[month]!.length,
                      ),
                      VerticalGap.mediumLarge(),
                    ],
                  );
                },
                itemCount: upcomingMeetings.keys.length,
              );
      },
    );
  }
}
