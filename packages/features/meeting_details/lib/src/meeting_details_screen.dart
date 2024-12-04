import 'package:domain_models/domain_models.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:meeting_details/src/l10n/meeting_details_localizations.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:meeting_details/src/meeting_details_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingDetailsScreen extends StatelessWidget {
  const MeetingDetailsScreen({
    required this.meetingRepository,
    required this.folderRepository,
    required this.onCancelMeetingTapped,
    required this.onScheduleMeetingTapped,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final FolderRepository folderRepository;
  final ValueSetter<Meeting> onCancelMeetingTapped;
  final ValueSetter<Meeting> onScheduleMeetingTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeetingDetailsCubit>(
      create: (_) => MeetingDetailsCubit(
        meetingRepository: meetingRepository,
        folderRepository: folderRepository,
        onCancelMeetingTapped: onCancelMeetingTapped,
        onScheduleMeetingTapped: onScheduleMeetingTapped,
      ),
      child: const MeetingDetailsView(),
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
        // final loading =
        //     state.searchMeetingsStatus == MeetingDetailsStatus.loading;
        final textTheme = Theme.of(context).textTheme;
        final theme = GrowthInTheme.of(context);
        final meeting = state.meeting!;
        final isPastMeeting = state.variation == MeetingCardVariation.past;
        final isUpcomingMeeting =
            state.variation == MeetingCardVariation.upcoming;

        final cubit = context.read<MeetingDetailsCubit>();
        final l10n = MeetingDetailsLocalizations.of(context);
        return Scaffold(
          appBar: const GrowthInAppBar(
            logoVariation: false,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: ListView(
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
                                l10n.dayRowTitle,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: const Color(
                                    0xFF797979,
                                  ),
                                ),
                              ),
                              VerticalGap.medium(),
                              Text(
                                l10n.timeRowTitle,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: const Color(
                                    0xFF797979,
                                  ),
                                ),
                              ),
                              VerticalGap.medium(),
                              Text(
                                l10n.serviceRowTitle,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: const Color(
                                    0xFF797979,
                                  ),
                                ),
                              ),
                              VerticalGap.medium(),
                              Text(
                                l10n.typeRowTitle,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: const Color(
                                    0xFF797979,
                                  ),
                                ),
                              ),
                              VerticalGap.medium(),
                              Text(
                                l10n.linkRowTitle,
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
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meeting.startDate?.extractDate() ?? '--',
                                maxLines: 1,
                                textDirection: TextDirection.ltr,
                              ),
                              VerticalGap.medium(),
                              Text(
                                meeting.startDate?.formatDateTimeTo12Hour() ??
                                    '--',
                                maxLines: 1,
                                textDirection: TextDirection.ltr,
                              ),
                              VerticalGap.medium(),
                              const Text('--'),
                              if (meeting.type != null) ...[
                                VerticalGap.medium(),
                                Text(
                                  meeting.type!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
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
                        l10n.meetingPlanSectionTitle,
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
                    if (meeting.files != null)
                      Files(
                        files: meeting.files,
                        // onFileTapped: cubit.downloadFile,
                      ),
                    if (meeting.summary != null) ...[
                      Text(
                        l10n.meetingSummarySectionTitle,
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
              ),
              if (!isPastMeeting) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      labelColor: const Color(0xFFB22F2F),
                      icon: const SvgAsset(AssetPathConstants.closeCirclePath),
                      label: l10n.cancelMeetingButtonLabel,
                      onTap: () => cubit.onCancelMeetingTapped(meeting),
                      decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(
                            color: theme.borderColor,
                          ),
                          top: BorderSide(
                            color: theme.borderColor,
                          ),
                          start: BorderSide(
                            color: theme.borderColor,
                          ),
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          bottomStart: Radius.circular(10),
                        ),
                      ),
                    ),
                    CustomButton(
                      labelColor: const Color(0xFF4B88CF),
                      icon: const SvgAsset(AssetPathConstants.editPath),
                      label: isUpcomingMeeting
                          ? l10n.rescheduleMeetingButtonLabel
                          : l10n.setMeetingTimeButtonLabel,
                      onTap: () => cubit.onScheduleMeetingTapped(meeting),
                      decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(
                            color: theme.borderColor,
                          ),
                          top: BorderSide(
                            color: theme.borderColor,
                          ),
                          end: BorderSide(
                            color: theme.borderColor,
                          ),
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                          bottomEnd: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalGap.large(),
              ]
            ],
          ),
        );
      },
    );
  }
}
