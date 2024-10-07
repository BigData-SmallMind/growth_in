import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MeetingChangeNotifier with ChangeNotifier, EquatableMixin {
  MeetingChangeNotifier();

  final ValueNotifier<Meeting?> _meeting = ValueNotifier(null);


  // This is a notifier of the meeting
  Meeting? get meeting => _meeting.value;
  void setMeeting(Meeting? meeting) {
    _meeting.value = meeting;
    notifyListeners();
  }
  Future clearMeeting() async {
    _meeting.value = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        _meeting,
      ];
}
