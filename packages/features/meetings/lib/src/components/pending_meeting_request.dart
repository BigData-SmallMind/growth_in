import 'package:domain_models/domain_models.dart';
import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:meetings/src/meetings_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingMeetingRequest extends StatelessWidget {
  const PendingMeetingRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = MeetingsLocalizations.of(context);

    return BlocBuilder<MeetingsCubit, MeetingsState>(builder: (context, state) {
      final meeting = state.meetings?.awaitingAction.isNotEmpty == true
          ? state.meetings?.awaitingAction.first
          : null;
      final cubit = context.read<MeetingsCubit>();
      return meeting != null
          ? MeetingCard(
              meeting: meeting,
              type: MeetingCardVariation.awaitingAction,
              onTap: () => cubit.onMeetingDetailsTapped(
                meeting,
                MeetingCardVariation.awaitingAction,
              ),
              onCancelMeetingTapped: () => cubit.onCancelMeetingTapped(meeting),
              onScheduleMeetingTapped: () =>
                  cubit.onScheduleMeetingTapped(meeting),
            )
          : SizedBox(
              height: 150,
              child: Center(
                child: Text(l10n.noMeetingsPendingActionMessage),
              ),
            );
    });
  }
}
