import 'package:meeting_repository/meeting_repository.dart';
import 'package:meeting_details/src/meeting_details_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingDetailsScreen extends StatelessWidget {
  const MeetingDetailsScreen({
    required this.meetingRepository,
    super.key,
  });

  final MeetingRepository meetingRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeetingDetailsCubit>(
      create: (_) => MeetingDetailsCubit(
        meetingRepository: meetingRepository,
      ),
      child: MeetingDetailsView(),
    );
  }
}

class MeetingDetailsView extends StatelessWidget {
  const MeetingDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingDetailsCubit, MeetingDetailsState>(
      builder: (context, state) {
        final loading =
            state.searchMeetingsStatus == MeetingDetailsStatus.loading;
        final textTheme = Theme.of(context).textTheme;
        final theme = GrowthInTheme.of(context);
        final meeting = state.meeting!;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: theme.screenMargin,
            ),
            children: [
              Text(
                meeting.title,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              VerticalGap.medium(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'l10n.dayRowTitle',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(
                              0xFF797979,
                            ),
                          ),
                        ),
                        VerticalGap.medium(),
                        Text(
                          'l10n.timeRowTitle',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(
                              0xFF797979,
                            ),
                          ),
                        ),
                        VerticalGap.medium(),
                        Text(
                          'l10n.serviceRowTitle',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(
                              0xFF797979,
                            ),
                          ),
                        ),
                        VerticalGap.medium(),
                        Text(
                          'l10n.typeRowTitle',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(
                              0xFF797979,
                            ),
                          ),
                        ),
                        VerticalGap.medium(),
                        Text(
                          'l10n.linkRowTitle',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(
                              0xFF797979,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting.startDate
                                  ?.toIso8601String()
                                  .padLeft(10, '0') ??
                              '--',
                          maxLines: 1,
                        ),
                        VerticalGap.medium(),
                        Text(
                          meeting.startDate?.hour.toString() ?? '--',
                          maxLines: 1,
                        ),
                        VerticalGap.medium(),
                        Text('--'),
                        VerticalGap.medium(),
                        Text(
                          meeting.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VerticalGap.medium(),
                        Text(
                          meeting.link ?? '--',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              VerticalGap.xLarge(),
              if (meeting.plan != null) ...[
                Text(
                  'l10n.meetingPlanSectionTitle',
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(
                      0xFF797979,
                    ),
                  ),
                ),
                VerticalGap.medium(),
                Text(
                  meeting.plan!,
                  style: textTheme.bodyMedium,
                ),
              ],
              if (meeting.files != null) ...[],
              if (meeting.summary != null) ...[
                Text(
                  'l10n.meetingSummarySectionTitle',
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(
                      0xFF797979,
                    ),
                  ),
                ),
                VerticalGap.medium(),
                Text(
                  meeting.summary!,
                  style: textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
