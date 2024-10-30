import 'post_details_localizations.dart';

/// The translations for Arabic (`ar`).
class PostDetailsLocalizationsAr extends PostDetailsLocalizations {
  PostDetailsLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarTitle => 'معاينة المنشور';

  @override
  String get detailsExpansionTileTitle => 'تفاصيل النشر';

  @override
  String get postPublicationDateRowTitle => 'مواعيد النشر';

  @override
  String get postSocialChannelsRowTitle => 'قنوات النشر';

  @override
  String get postContentTypeRowTitle => 'نوع المحتوى';

  @override
  String get approvePostButtonLabel => 'موافقة';

  @override
  String get approvePostBottomSheetTitle => 'بمواقتك علي المنشور سيتم التحديد الإنجاز';

  @override
  String get approvePostBottomSheetBody => 'ويتم إنهاء التعديلات';

  @override
  String get approvePostBottomSheetButtonLabel => 'موافقة';

  @override
  String get cancelPostBottomSheetButtonLabel => 'لازال هناك تعليقات';

  @override
  String get postApprovalSuccessSnackBarMessage => 'تمت الموافقة علي المنشور بنجاح';
}
