import 'package:meeting_repository/meeting_repository.dart';
import 'package:search_meetings/src/l10n/search_meetings_localizations.dart';
import 'package:search_meetings/src/search_meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/components.dart';

class SearchMeetingsScreen extends StatelessWidget {
  const SearchMeetingsScreen({
    required this.meetingRepository,
    super.key,
  });

  final MeetingRepository meetingRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchMeetingsCubit>(
      create: (_) => SearchMeetingsCubit(
        meetingRepository: meetingRepository,
      ),
      child: SearchMeetingsView(),
    );
  }
}

class SearchMeetingsView extends StatelessWidget {
  const SearchMeetingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return BlocBuilder<SearchMeetingsCubit, SearchMeetingsState>(
      builder: (context, state) {
        final loading = state.search_meetingsStatus == SearchMeetingsStatus.loading;
        final l10n = SearchMeetingsLocalizations.of(context);
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.secondaryColor,
            shape: const CircleBorder(),
            onPressed: () {
              context.read<SearchMeetingsCubit>().getSearchMeetings();
            },
            child: const Icon(Icons.add),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.screenMargin,
                  ),
                  children: [
                    MeetingSectionHeader(
                      title: l10n.meetingRequestsSectionTitle,
                      onViewAll: () {},
                    ),
                    VerticalGap.medium(),
                    PendingMeetingRequest(),
                    VerticalGap.medium(),
                    Divider(),
                    VerticalGap.medium(),
                    MeetingSectionHeader(
                      title: l10n.upcomingSearchMeetingsSectionTitle,
                      onViewAll: () {},
                    ),
                    VerticalGap.medium(),
                    UpcomingMeeting(),
                    VerticalGap.medium(),
                    Divider(),
                    VerticalGap.medium(),
                    MeetingSectionHeader(
                      title: l10n.pastSearchMeetingsSectionTitle,
                      onViewAll: () {},
                    ),
                    VerticalGap.medium(),
                    PastMeeting(),
                  ],
                ),
        );
      },
    );
  }
}
