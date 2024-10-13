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

  bool get shouldShowButtons => variation == MeetingCardVariation.past;


  MeetingDetailsState copyWith({
    Meeting? meeting,
    MeetingDetailsStatus? searchMeetingsStatus,
    MeetingCardVariation? variation,
  }) {
    return MeetingDetailsState(
      meeting: meeting ?? this.meeting,
      searchMeetingsStatus: searchMeetingsStatus ?? this.searchMeetingsStatus,
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
