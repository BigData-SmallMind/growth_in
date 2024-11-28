import 'post_version_details_localizations.dart';

/// The translations for Arabic (`ar`).
class PostVersionDetailsLocalizationsAr extends PostVersionDetailsLocalizations {
  PostVersionDetailsLocalizationsAr([super.locale = 'ar']);

  @override
  String get approvePostButtonLabel => 'موافقة';

  @override
  String get approvePostBottomSheetTitle => 'متأكد من الموافقة على هذة النسخة؟';

  @override
  String get approvePostBottomSheetBody => 'يتم إعتماد هذة النسخة وإغلاق التعديلات ';

  @override
  String get approvePostBottomSheetButtonLabel => 'موافقة';

  @override
  String get cancelPostBottomSheetButtonLabel => 'لازال هناك تعديلات';

  @override
  String get postApprovalSuccessSnackBarMessage => 'تمت الموافقة على المنشور بنجاح';
}
