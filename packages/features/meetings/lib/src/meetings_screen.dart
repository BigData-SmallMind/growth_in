import 'package:domain_models/domain_models.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:meetings/src/meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/components.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({
    required this.meetingRepository,
    required this.onViewAllTapped,
    required this.onCreateMeetingTapped,
    required this.onMeetingTapped,
    required this.onCancelMeetingTapped,
    required this.onScheduleMeetingTapped,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final VoidCallback onViewAllTapped;
  final VoidCallback onCreateMeetingTapped;
  final ValueSetter<int> onMeetingTapped;
  final ValueSetter<Meeting> onCancelMeetingTapped;
  final ValueSetter<Meeting> onScheduleMeetingTapped;

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeetingsCubit>(
      create: (_) => MeetingsCubit(
        meetingRepository: widget.meetingRepository,
        onViewAllTapped: widget.onViewAllTapped,
        onMeetingTapped: widget.onMeetingTapped,
        onCreateMeetingTapped: widget.onCreateMeetingTapped,
        onCancelMeetingTapped: widget.onCancelMeetingTapped,
        onScheduleMeetingTapped: widget.onScheduleMeetingTapped,
      ),
      child: const MeetingsView(),
    );
  }
}

class MeetingsView extends StatelessWidget {
  const MeetingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      builder: (context, state) {
        final loading = state.meetingsStatus == MeetingsStatus.loading;
        final l10n = MeetingsLocalizations.of(context);
        final cubit = context.read<MeetingsCubit>();
        return Scaffold(
          appBar: const GrowthInAppBar(
            logoVariation: false,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.secondaryColor,
            shape: const CircleBorder(),
            onPressed: cubit.onCreateMeetingTapped,
            child: const Icon(Icons.add),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () async {
                    cubit.getMeetings();
                  },
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.screenMargin,
                    ),
                    children: [
                      MeetingSectionHeader(
                        title: l10n.meetingRequestsSectionTitle,
                        onViewAll: () {
                          cubit.onViewAllTapped();
                          cubit.setMeetingsCardsType(
                              MeetingCardVariation.awaitingAction);
                        },
                      ),
                      VerticalGap.medium(),
                      const PendingMeetingRequest(),
                      VerticalGap.medium(),
                      const Divider(),
                      VerticalGap.medium(),
                      MeetingSectionHeader(
                        title: l10n.upcomingMeetingsSectionTitle,
                        onViewAll: () {
                          cubit.onViewAllTapped();
                          cubit.setMeetingsCardsType(
                              MeetingCardVariation.upcoming);
                        },
                      ),
                      VerticalGap.medium(),
                      const UpcomingMeeting(),
                      VerticalGap.medium(),
                      const Divider(),
                      VerticalGap.medium(),
                      MeetingSectionHeader(
                        title: l10n.pastMeetingsSectionTitle,
                        onViewAll: () {
                          cubit.onViewAllTapped();
                          cubit.setMeetingsCardsType(MeetingCardVariation.past);
                        },
                      ),
                      VerticalGap.medium(),
                      const PastMeeting(),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
