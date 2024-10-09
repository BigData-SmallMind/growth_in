import 'package:domain_models/domain_models.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:search_meetings/src/components/components.dart';
import 'package:search_meetings/src/search_meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMeetingsScreen extends StatelessWidget {
  const SearchMeetingsScreen({
    required this.meetingRepository,
    required this.oMeetingTapped,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final ValueSetter<int> oMeetingTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchMeetingsCubit>(
      create: (_) => SearchMeetingsCubit(
        meetingRepository: meetingRepository,
        oMeetingTapped: oMeetingTapped,
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
    return BlocBuilder<SearchMeetingsCubit, SearchMeetingsState>(
      builder: (context, state) {
        final loading =
            state.searchMeetingsStatus == SearchMeetingsStatus.loading;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : state.variation == MeetingCardVariation.awaitingAction
                  ? PendingMeetingRequests()
                  : state.variation == MeetingCardVariation.upcoming
                      ? UpcomingMeetings()
                      : PastMeetings(),
        );
      },
    );
  }
}
