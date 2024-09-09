import 'send_otp_localizations.dart';

/// The translations for Arabic (`ar`).
class SendOtpLocalizationsAr extends SendOtpLocalizations {
  SendOtpLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get sendOtpTitle => 'نسيت كلمة المرور؟';

  @override
  String get sendOtpSubtitle => 'لا تقلق! من فضلك ادخل البريد الإلكتروني الخاص بالحساب';

  @override
  String get otpSentSuccessfullySnackBarMessage => 'تم إرسال الرمز بنجاح';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما';

  @override
  String get invalidCredentialsErrorMessage => 'بريد الكترونى او كلمة مرور خطأ';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get emailTextFieldLabel => 'البريد الإلكتروني';

  @override
  String get invalidEmailFormatErrorMessage => 'صيغة البريد الإلكتروني غير صحيح';
}
