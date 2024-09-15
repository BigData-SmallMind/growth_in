import 'change_password_localizations.dart';

/// The translations for Arabic (`ar`).
class ChangePasswordLocalizationsAr extends ChangePasswordLocalizations {
  ChangePasswordLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get changePasswordSuccessMessage => 'تم إعادة تعيين كلمة المرور بنجاح';

  @override
  String get changePasswordScreenTitle => 'تغيير كلمة المرور';

  @override
  String get changePasswordScreenSubtitle => 'ادخل كلمة المرور الجديدة';

  @override
  String get submissionInProgressButtonLabel => 'جارٍ التقديم';

  @override
  String get submitButtonLabel => 'إرسال';

  @override
  String get newPasswordTextFieldLabel => 'كلمة المرور الجديدة';

  @override
  String get requiredFieldErrorMessage => 'هذا الحقل مطلوب';

  @override
  String get currentPasswordTextFieldLabel => 'كلمة المرور الحالية';

  @override
  String get currentPasswordTextFieldHint => 'أدخل كلمة المرور الحالية';

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

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ. يرجى المحاولة مرة أخرى';

  @override
  String get wrongPasswordErrorMessage => 'كلمة المرور غير صحيحة';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'يجب أن تستوفي كلمة المرور المعايير التالية: - لا يقل طوله عن 6 أحرف - تحتوي على حرف كبير واحد على الأقل - تحتوي على حرف صغير واحد على الأقل - تحتوي على رقم واحد على الأقل - تحتوي على رمز واحد على الأقل (على سبيل المثال، @، \$، !، إلخ.)';
}
