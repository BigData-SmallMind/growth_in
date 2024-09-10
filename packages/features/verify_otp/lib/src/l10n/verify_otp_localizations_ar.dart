import 'verify_otp_localizations.dart';

/// The translations for Arabic (`ar`).
class VerifyOtpLocalizationsAr extends VerifyOtpLocalizations {
  VerifyOtpLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get verifyOtpTitle => 'تأكيد الرمز';

  @override
  String get otpResentSuccessfullySnackBarMessage => 'تم إرسال الرمز بنجاح.';

  @override
  String get otpResentErrorSnackBarMessage => 'حدث خطأ أثناء إرسال الرمز.';

  @override
  String get otpVerifiedSuccessfullySnackBarMessage => 'تم تأكيد الرمز بنجاح.';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما.';

  @override
  String get verifyOtpSubtitle => 'أدخل الرمز المرسل إلى رقم هاتفك.';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get incorrectOtpCodeErrorMessage => 'الرمز الذي أدخلته غير صحيح، حاول مرة أخرى.';

  @override
  String get verifyingOtpButtonLabel => 'جارٍ التأكيد...';

  @override
  String get verifyOtpButtonLabel => 'تأكيد الرمز';

  @override
  String get emailNotRegisteredErrorMessage => 'البريد الإلكتروني الذي أدخلته غير مسجل';
}
