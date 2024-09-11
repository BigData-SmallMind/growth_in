import 'reset_password_localizations.dart';

/// The translations for Arabic (`ar`).
class ResetPasswordLocalizationsAr extends ResetPasswordLocalizations {
  ResetPasswordLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get resetPasswordSuccessMessage => 'تم إعادة تعيين كلمة المرور بنجاح';

  @override
  String get resetPasswordScreenTitle => 'إعادة ضبط كلمة المرور';

  @override
  String get resetPasswordScreenSubtitle => 'ادخل كلمة المرور الجديدة';

  @override
  String get submissionInProgressButtonLabel => 'جارٍ التقديم';

  @override
  String get submitButtonLabel => 'إرسال';

  @override
  String get newPasswordTextFieldLabel => 'كلمة المرور الجديدة';

  @override
  String get requiredFieldErrorMessage => 'هذا الحقل مطلوب';

  @override
  String get passwordTextFieldWeakPasswordError => 'كلمة المرور ضعيفة جدًا';

  @override
  String get passwordTextFieldHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get newPasswordConfirmationTextFieldLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get newPasswordConfirmationTextFieldHint => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get passwordConfirmationTextFieldDoesNotMatchError => 'كلمات المرور غير متطابقة';
}
