import 'change_email_localizations.dart';

/// The translations for Arabic (`ar`).
class ChangeEmailLocalizationsAr extends ChangeEmailLocalizations {
  ChangeEmailLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get changeEmailSuccessMessage => 'تم تغيير البريد الإلكتروني بنجاح';

  @override
  String get changeEmailScreenTitle => 'تغيير البريد الإلكتروني';

  @override
  String get changeEmailScreenSubtitle => 'ادخل البريد الإلكتروني الجديد';

  @override
  String get submissionInProgressButtonLabel => 'جارٍ التقديم';

  @override
  String get submitButtonLabel => 'إرسال';

  @override
  String get newEmailTextFieldLabel => 'البريد الإلكتروني الجديد';

  @override
  String get requiredFieldErrorMessage => 'هذا الحقل مطلوب';

  @override
  String get emailTextFieldHint => 'أدخل البريد الإلكتروني الجديد';

  @override
  String get newEmailConfirmationTextFieldLabel => 'تأكيد البريد الإلكتروني الجديد';

  @override
  String get newEmailConfirmationTextFieldHint => 'أعد إدخال البريد الإلكتروني الجديد';

  @override
  String get emailConfirmationTextFieldDoesNotMatchError => 'البريد الإلكتروني غير متطابق';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ. يرجى المحاولة مرة أخرى';

  @override
  String get invalidEmailFormatErrorMessage => 'البريد الإلكتروني غير صحيح';

  @override
  String get emailTextFieldAlreadyRegisteredError => 'تم تسجيل هذا البريد الإلكتروني بالفعل';
}
