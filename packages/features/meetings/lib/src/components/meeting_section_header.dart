import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:meetings/src/meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/components.dart';

class MeetingsScreen extends StatelessWidget {
  const MeetingsScreen({
    required this.meetingRepository,
    super.key,
  });

  final MeetingRepository meetingRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeetingsCubit>(
      create: (_) => MeetingsCubit(
        meetingRepository: meetingRepository,
      ),
      child: MeetingsView(),
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
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.secondaryColor,
            shape: const CircleBorder(),
            onPressed: () {
              context.read<MeetingsCubit>().getMeetings();
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
                      title: l10n.upcomingMeetingsSectionTitle,
                      onViewAll: () {},
                    ),
                    VerticalGap.medium(),
                    UpcomingMeeting(),
                    VerticalGap.medium(),
                    Divider(),
                    VerticalGap.medium(),
                    MeetingSectionHeader(
                      title: l10n.pastMeetingsSectionTitle,
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

class MeetingSectionHeader extends StatelessWidget {
  const MeetingSectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final l10n = MeetingsLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        TextButton(
          onPressed: onViewAll,
          child: Text(l10n.viewAllTextButtonLabel),
        ),
      ],
    );
  }
}

