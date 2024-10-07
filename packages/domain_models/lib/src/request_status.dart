
enum RequestStatus {
  aboutToExpire,
  expired,
  notStarted,
  inProgress;

  String get nameAr {
    switch (this) {
      case RequestStatus.aboutToExpire:
        return 'قرب التجاوز';
      case RequestStatus.expired:
        return 'لم يتم البدء';
      case RequestStatus.notStarted:
        return 'تجاوز الموعد';
      case RequestStatus.inProgress:
        return 'قيد العمل';
    }
  }

  String get nameEn {
    switch (this) {
      case RequestStatus.aboutToExpire:
        return 'About to Expire';
      case RequestStatus.expired:
        return 'Expired';
      case RequestStatus.notStarted:
        return 'Not Started';
      case RequestStatus.inProgress:
        return 'In Progress';
    }
  }
}
