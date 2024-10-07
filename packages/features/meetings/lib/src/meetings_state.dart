part of 'meetings_cubit.dart';

class MeetingsState extends Equatable {
  const MeetingsState({
    this.meetings,
    this.meetingsStatus = MeetingsStatus.initial,
  });

  final Meetings? meetings;
  final MeetingsStatus meetingsStatus;

  MeetingsState copyWith({
    Meetings? meetings,
    MeetingsStatus? meetingsStatus,
  }) {
    return MeetingsState(
      meetings: meetings ?? this.meetings,
      meetingsStatus: meetingsStatus ?? this.meetingsStatus,
    );
  }

  @override
  List<Object?> get props => [
        meetingsStatus,
        meetings,
      ];
}

enum MeetingsStatus { initial, loading, success, failure }
