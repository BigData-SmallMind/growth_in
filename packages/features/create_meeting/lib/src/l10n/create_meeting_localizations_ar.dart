import 'create_meeting_localizations.dart';

/// The translations for Arabic (`ar`).
class CreateMeetingLocalizationsAr extends CreateMeetingLocalizations {
  CreateMeetingLocalizationsAr([super.locale = 'ar']);

  @override
  String get descriptionTextFieldLabel => 'تفاصيل خطة الاجتماع';

  @override
  String get descriptionTextFieldHint => 'خطة الإجتماع أو أهم النقاط';

  @override
  String get titleTextFieldLabel => 'عنوان الاجتماع';

  @override
  String get requiredFieldErrorMessage => 'مطلوب';

  @override
  String get titleTextFieldHint => 'أدخل العنوان هنا';

  @override
  String get nextStepButtonLabel => 'الخطوة التالية';

  @override
  String get lastStepButtonLabel => 'حجز';

  @override
  String get stepOneLabel => 'املي التفاصيل العامة';

  @override
  String get stepTwoLabel => 'التاريخ';

  @override
  String get stepThreeLabel => 'تفاصيل الجتماع';

  @override
  String get typeTextFieldLabel => 'نوع الاجتماع';

  @override
  String get selectedSlotLabel => 'الوقت';

  @override
  String get selectedDayLabel => 'اليوم';
}
