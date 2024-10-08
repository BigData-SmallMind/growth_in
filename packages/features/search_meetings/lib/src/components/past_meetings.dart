// import 'package:search_meetings/src/l10n/search_meetings_localizations.dart';
// import 'package:search_meetings/src/search_meetings_cubit.dart';
// import 'package:component_library/component_library.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class PastMeeting extends StatelessWidget {
//   const PastMeeting({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SearchMeetingsCubit, SearchMeetingsState>(
//       builder: (context, state) {
//         final l10n = SearchMeetingsLocalizations.of(context);
//         final meeting = state.meetings!.past!.first;
//         return state.meetings?.past?.isNotEmpty == true
//             ? DayNameWidget(
//                 dateTime: meeting.startDate!,
//               )
//             : Container(
//                 height: 150,
//                 child: Center(
//                   child: Text(l10n.noPastSearchMeetingsMessage),
//                 ),
//               );
//       },
//     );
//   }
// }
