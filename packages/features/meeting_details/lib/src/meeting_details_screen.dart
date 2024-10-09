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
    required this.downloadUrl,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final String downloadUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeetingDetailsCubit>(
      create: (_) => MeetingDetailsCubit(
        meetingRepository: meetingRepository,
        downloadUrl: downloadUrl,
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
        final cubit = context.read<MeetingDetailsCubit>();
        final l10n = MeetingDetailsLocalizations.of(context);
        return Scaffold(
          appBar: GrowthInAppBar(
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
                    if (meeting.files != null) ...[
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final file = meeting.files![index];
                            return InkWell(
                              onTap: () => cubit.download(file),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 50,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: theme.borderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text(file.extension)),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    child: Center(
                                      child: Text(
                                        file.name,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: meeting.files!.length,
                        ),
                      )
                    ],
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
              Row(
                children: [
                  Expanded(
                    child: GrowthInElevatedButton(
                      // bgColor: Colors.white,
                      labelColor: Color(0xFFB22F2F),
                      bgColor:  Colors.white,
                      borderColor: theme.borderColor,
                      icon: SvgAsset(AssetPathConstants.closeCirclePath),
                      label: 'l10n.cancle',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: GrowthInElevatedButton(
                      // bgColor: Colors.white,
                      labelColor: Color(0xFFB22F2F),
                      bgColor:  Colors.white,
                      borderColor: theme.borderColor,
                      icon: SvgAsset(AssetPathConstants.closeCirclePath),
                      label: 'l10n.cancle',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
