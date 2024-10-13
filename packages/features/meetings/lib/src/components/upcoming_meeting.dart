import 'package:domain_models/domain_models.dart';
import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:meetings/src/meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingMeeting extends StatelessWidget {
  const UpcomingMeeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsCubit, MeetingsState>(
      builder: (context, state) {
        final meeting = state.meetings?.latestUpcoming;
        final l10n = MeetingsLocalizations.of(context);
        final cubit = context.read<MeetingsCubit>();
        return meeting != null
            ? Row(
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
                      onTap: () => cubit.onMeetingDetailsTapped(
                        meeting,
                        MeetingCardVariation.upcoming,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: 150,
                child: Center(
                  child: Text(l10n.noUpcomingMeetingMessage),
                ),
              );
      },
    );
  }
}
