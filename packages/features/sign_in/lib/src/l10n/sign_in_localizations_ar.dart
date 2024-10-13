import 'sign_in_localizations.dart';

/// The translations for Arabic (`ar`).
class SignInLocalizationsAr extends SignInLocalizations {
  SignInLocalizationsAr([super.locale = 'ar']);

  @override
  String get signInSuccessSnackBarMessage => 'تم تسجيل الدخول بنجاح';

  @override
  String get chooseCompanyTitle => 'اختر الحساب لتسجيل الدخول';

  @override
  String get chooseCompanyHintText => 'يمكنك التحويل من الداخل ايضا بسهولة والتبديل بين الحسابات';

  @override
  String get signInGreetingTitle => 'مرحباً بك في قروث-إن';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما، يرجى المحاولة مرة أخرى';

  @override
  String get invalidCredentialsErrorMessage => 'بريد الكترونى او كلمة مرور خطأ';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get emailTextFieldLabel => 'البريد الإلكتروني';

  @override
  String get invalidEmailFormatErrorMessage => 'صيغة البريد الإلكتروني غير صحيح';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور';

  @override
  String get rememberMeCheckBoxLabel => 'تذكرنى';

  @override
  String get forgotMyPasswordButtonLabel => 'فقدت كلمة المرور؟';

  @override
  String get signInButtonLabel => 'تسجيل دخول';

  @override
  String get signInInProgressButtonLabel => 'جارى تسجيل الدخول';
}
