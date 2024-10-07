import 'package:domain_models/domain_models.dart';

class Meeting {
  const Meeting({
    required this.id,
    required this.type,
    required this.title,
    this.startDate,
    this.endDate,
    this.plan,
    this.files,
    this.link,
    this.summary,
    this.cancellationReason,
  });

  final int id;
  final String type;
  final String title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? plan;
  final List<FileDM>? files;
  final String? link;
  final String? summary;
  final String? cancellationReason;

  int? get hoursTillStart => startDate?.difference(DateTime.now()).inHours;
}

class Meetings {
  Meetings({
    this.latestUpcoming,
    required this.pendingAction,
    required this.upcoming,
    this.past,
  });

  final Meeting? latestUpcoming;
  final List<Meeting> pendingAction;
  final List<Meeting> upcoming;
  final List<Meeting>? past;
}

enum MeetingCardType {
  upcoming,
  pendingAction,
  past,
}
