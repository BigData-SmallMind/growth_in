part of 'meeting_details_cubit.dart';

class MeetingDetailsState extends Equatable {
  const MeetingDetailsState({
    this.meeting,
    this.searchMeetingsStatus = MeetingDetailsStatus.initial,
    this.variation,
  });

  final Meeting? meeting;
  final MeetingDetailsStatus searchMeetingsStatus;
  final MeetingCardVariation? variation;

  MeetingDetailsState copyWith({
    Meeting? meeting,
    MeetingDetailsStatus? searchMeetingsStatus,
  }) {
    return MeetingDetailsState(
      meeting: meeting ?? this.meeting,
      searchMeetingsStatus: searchMeetingsStatus ?? this.searchMeetingsStatus,
      variation: variation,
    );
  }

  @override
  List<Object?> get props => [
        searchMeetingsStatus,
        meeting,
        variation,
      ];
}

enum MeetingDetailsStatus { initial, loading, success, failure }
