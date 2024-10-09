import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MeetingChangeNotifier with ChangeNotifier, EquatableMixin {
  MeetingChangeNotifier();

  final ValueNotifier<MeetingCardVariation?> _meetingCardVariation =
      ValueNotifier(null);
  final ValueNotifier<Meeting?> _meeting = ValueNotifier(null);

  // This is a notifier of the meetingCardVariation
  MeetingCardVariation? get meetingCardVariation => _meetingCardVariation.value;
  void setMeetingsVariation(MeetingCardVariation? meetingCardVariation) {
    _meetingCardVariation.value = meetingCardVariation;
    notifyListeners();
  }
  Future clearMeeting() async {
    _meetingCardVariation.value = null;
    notifyListeners();
  }

  // This is a notifier of the meeting
  Meeting? get meeting => _meeting.value;
  void setMeeting(Meeting? meeting) {
    _meeting.value = meeting;
    notifyListeners();
  }
  Future clearMeetings() async {
    _meeting.value = null;
    notifyListeners();
  }
  @override
  List<Object?> get props => [
        _meetingCardVariation,
        _meeting,
      ];
}
