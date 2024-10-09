import 'package:domain_models/domain_models.dart';
import 'package:search_meetings/src/l10n/search_meetings_localizations.dart';
import 'package:search_meetings/src/search_meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PastMeetings extends StatelessWidget {
  const PastMeetings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMeetingsCubit, SearchMeetingsState>(
      builder: (context, state) {
        final emptyList = state.meetings?.past == null ||
            state.meetings?.past?.isEmpty == true;
        final pastMeetings = state.pastMeetings;
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
                  final month = pastMeetings.keys.toList()[index];
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
                          final meeting = pastMeetings[month]![index];
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
                                  type: MeetingCardVariation.past,
                                  onTap: () =>
                                      cubit.onMeetingDetailsTapped(meeting),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: pastMeetings[month]!.length,
                      ),
                      VerticalGap.mediumLarge(),
                    ],
                  );
                },
                itemCount: pastMeetings.keys.length,
              );
      },
    );
  }
}
