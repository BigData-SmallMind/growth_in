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
    required this.createdAt,
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
  final DateTime createdAt;

  int? get hoursTillStart => startDate?.difference(DateTime.now()).inHours;

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday = startDate != null && startDate!.isAtSameMomentAs(today);
    return isToday;
  }

  bool get hasStarted =>
      startDate != null && startDate!.isBefore(DateTime.now());

}

class Meetings {
  Meetings({
    this.latestUpcoming,
    required this.awaitingAction,
    required this.upcoming,
    this.past,
  });

  final Meeting? latestUpcoming;
  final List<Meeting> awaitingAction;
  final List<Meeting> upcoming;
  final List<Meeting>? past;
}

enum MeetingCardVariation {
  upcoming,
  awaitingAction,
  past,
}

class MeetingType {
  const MeetingType({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

enum MeetingCancellationReason {
  noSuitableTime,
  personalProblem,
  unTimelyResponse,
  other;

  String get nameAr {
    switch (this) {
      case MeetingCancellationReason.noSuitableTime:
        return 'لا يوجد مواعيد مناسبة';
      case MeetingCancellationReason.personalProblem:
        return 'مشكلة مع أشخاص';
      case MeetingCancellationReason.unTimelyResponse:
        return 'عدم السرعة في الرد';
      case MeetingCancellationReason.other:
        return 'سبب آخر';
    }
  }

  String get nameEn {
    switch (this) {
      case MeetingCancellationReason.noSuitableTime:
        return 'No suitable time';
      case MeetingCancellationReason.personalProblem:
        return 'Personal problem';
      case MeetingCancellationReason.unTimelyResponse:
        return 'Untimely response';
      case MeetingCancellationReason.other:
        return 'Other';
    }
  }
}

class MeetingSlot {
  const MeetingSlot({
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;
}