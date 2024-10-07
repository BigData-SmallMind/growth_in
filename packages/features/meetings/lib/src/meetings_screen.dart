import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:meetings/src/meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class PendingMeetingRequest extends StatelessWidget {
  const PendingMeetingRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = MeetingsLocalizations.of(context);

    return BlocBuilder<MeetingsCubit, MeetingsState>(builder: (context, state) {
      return state.meetings?.pendingAction.isNotEmpty == true
          ? MeetingCard(
              meeting: state.meetings!.pendingAction.first,
              type: MeetingCardType.pendingAction,
            )
          : Container(
              height: 150,
              child: Center(
                child: Text(l10n.noMeetingsPendingActionMessage),
              ),
            );
    });
  }
}

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    super.key,
    required this.meeting,
    required this.type,
  });

  final Meeting meeting;
  final MeetingCardType type;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = MeetingsLocalizations.of(context);

    return Container(
      height: type == MeetingCardType.past ? null :130,
      padding: EdgeInsets.only(
        top: Spacing.medium,
        bottom:type == MeetingCardType.past? Spacing.medium: 0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.borderColor,
        ),
        color: type == MeetingCardType.upcoming || type == MeetingCardType.past
            ? const Color(0xFFEFFFEF)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
            child: Text(
              meeting.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelMedium?.copyWith(
                color: const Color(0xFF797979),
              ),
            ),
          ),
          VerticalGap.small(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
            child: Text(
              meeting.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (type == MeetingCardType.pendingAction) ...[
            VerticalGap.xLarge(),
            Divider(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.medium,
                        ),
                        child: Center(
                          child: Text(
                            l10n.cancelMeetingButtonLabel,
                            maxLines: 1,
                            style: textTheme.labelMedium?.copyWith(
                              color: const Color(0xFFEB3E3E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.medium,
                        ),
                        child: Center(
                          child: Text(l10n.cancelMeetingButtonLabel,
                              maxLines: 1,
                              style: textTheme.labelMedium?.copyWith(
                                color: theme.primaryColor,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: const Color(0xFF26BFBF)),
              height: 5,
            )
          ],
          if (type == MeetingCardType.upcoming ||
              type == MeetingCardType.past) ...[
            VerticalGap.medium(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
              child: Text(DateFormat('EEEE, yyyy-MM-dd – hh:mm a')
                  .format(meeting.startDate!)),
            ),
          ],
          if (type == MeetingCardType.upcoming) ...[
            VerticalGap.medium(),
            Expanded(
              child: Container(
                color: theme.tertiaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: theme.materialThemeData.colorScheme.surface,
                    ),
                    HorizontalGap.small(),
                    Text(
                      'hr',
                      style: textTheme.labelMedium?.copyWith(
                        color: theme.materialThemeData.colorScheme.surface,
                      ),
                    ),
                    HorizontalGap.small(),
                    Text(
                      meeting.hoursTillStart.toString(),
                      style: textTheme.labelMedium?.copyWith(
                        color: theme.materialThemeData.colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}

class UpcomingMeeting extends StatelessWidget {
  const UpcomingMeeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final meeting = state.meetings?.latestUpcoming;
        final l10n = MeetingsLocalizations.of(context);

        return meeting != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        DateFormat('EEEE').format(meeting.startDate!),
                        style: textTheme.titleMedium,
                      ),
                      Text(meeting.startDate!.day.toString(),
                          style: textTheme.titleMedium),
                    ],
                  ),
                  HorizontalGap.medium(),
                  Expanded(
                    child: MeetingCard(
                      meeting: meeting,
                      type: MeetingCardType.upcoming,
                    ),
                  ),
                ],
              )
            : Container(
                height: 150,
                child: Center(
                  child: Text(l10n.noUpcomingMeetingMessage),
                ),
              );
      },
    );
  }
}

class PastMeeting extends StatelessWidget {
  const PastMeeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsCubit, MeetingsState>(builder: (context, state) {
      final textTheme = Theme.of(context).textTheme;
      final l10n = MeetingsLocalizations.of(context);

      return state.meetings?.past?.isNotEmpty == true
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      DateFormat('EEEE')
                          .format(state.meetings!.past!.first.startDate!),
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      state.meetings!.past!.first.startDate!.day.toString(),
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
                HorizontalGap.medium(),
                Expanded(
                  child: MeetingCard(
                    meeting: state.meetings!.past!.first,
                    type: MeetingCardType.past,
                  ),
                ),
              ],
            )
          : Container(
              height: 150,
              child: Center(
                child: Text(l10n.noPastMeetingsMessage),
              ),
            );
    });
  }
}
