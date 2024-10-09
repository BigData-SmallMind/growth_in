import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';
import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:meetings/src/meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PastMeeting extends StatelessWidget {
  const PastMeeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsCubit, MeetingsState>(builder: (context, state) {
      final textTheme = Theme.of(context).textTheme;
      final l10n = MeetingsLocalizations.of(context);
      final cubit = context.read<MeetingsCubit>();
      final meeting = state.meetings?.past?.first;
      return state.meetings?.past?.isNotEmpty == true
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      DateFormat('EEEE').format(meeting!.startDate!),
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      meeting.startDate!.day.toString(),
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
                HorizontalGap.medium(),
                Expanded(
                  child: MeetingCard(
                    meeting: meeting,
                    type: MeetingCardVariation.past,
                    onTap: () => cubit.onMeetingDetailsTapped(meeting),
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
