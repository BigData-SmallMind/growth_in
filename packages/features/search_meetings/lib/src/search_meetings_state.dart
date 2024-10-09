part of 'search_meetings_cubit.dart';

class SearchMeetingsState extends Equatable {
  const SearchMeetingsState({
    this.meetings,
    this.searchMeetingsStatus = SearchMeetingsStatus.initial,
    this.variation,
  });

  final Meetings? meetings;
  final SearchMeetingsStatus searchMeetingsStatus;
  final MeetingCardVariation? variation;

  Map<String, List<Meeting>> get awaitingActionMeetings {
    final groupedMeetings = <String, List<Meeting>>{};
    for (final meeting in meetings?.awaitingAction ?? []) {
      final month = meeting.createdAt.month;
      final year = meeting.createdAt.year;
      final key = '$month-$year';
      if (groupedMeetings.containsKey(key)) {
        groupedMeetings[key]!.add(meeting);
      } else {
        groupedMeetings[key] = [meeting];
      }
    }
    return groupedMeetings;
  }

  Map<String, List<Meeting>> get pastMeetings {
    final groupedMeetings = <String, List<Meeting>>{};
    for (final meeting in meetings?.past ?? []) {
      final month = meeting.startDate!.month;
      final year = meeting.startDate!.year;
      final key = '$month-$year';
      if (groupedMeetings.containsKey(key)) {
        groupedMeetings[key]!.add(meeting);
      } else {
        groupedMeetings[key] = [meeting];
      }
    }
    return groupedMeetings;
  }

  Map<String, List<Meeting>> get upcomingMeetings {
    final groupedMeetings = <String, List<Meeting>>{};
    for (final meeting in meetings?.upcoming ?? []) {
      final month = meeting.startDate!.month;
      final year = meeting.startDate!.year;
      final key = '$month-$year';
      if (groupedMeetings.containsKey(key)) {
        groupedMeetings[key]!.add(meeting);
      } else {
        groupedMeetings[key] = [meeting];
      }
    }
    return groupedMeetings;
  }

  SearchMeetingsState copyWith({
    Meetings? meetings,
    SearchMeetingsStatus? searchMeetingsStatus,
  }) {
    return SearchMeetingsState(
      meetings: meetings ?? this.meetings,
      searchMeetingsStatus: searchMeetingsStatus ?? this.searchMeetingsStatus,
      variation: variation,
    );
  }

  @override
  List<Object?> get props => [
        searchMeetingsStatus,
        meetings,
        variation,
      ];
}

enum SearchMeetingsStatus { initial, loading, success, failure }
