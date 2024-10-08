part of 'search_meetings_cubit.dart';

class SearchMeetingsState extends Equatable {
  const SearchMeetingsState({
    this.search_meetings,
    this.search_meetingsStatus = SearchMeetingsStatus.initial,
  });

  final SearchMeetings? search_meetings;
  final SearchMeetingsStatus search_meetingsStatus;

  SearchMeetingsState copyWith({
    SearchMeetings? search_meetings,
    SearchMeetingsStatus? search_meetingsStatus,
  }) {
    return SearchMeetingsState(
      search_meetings: search_meetings ?? this.search_meetings,
      search_meetingsStatus: search_meetingsStatus ?? this.search_meetingsStatus,
    );
  }

  @override
  List<Object?> get props => [
        search_meetingsStatus,
        search_meetings,
      ];
}

enum SearchMeetingsStatus { initial, loading, success, failure }
