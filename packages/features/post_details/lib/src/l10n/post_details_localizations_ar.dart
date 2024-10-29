import 'post_details_localizations.dart';

/// The translations for Arabic (`ar`).
class PostDetailsLocalizationsAr extends PostDetailsLocalizations {
  PostDetailsLocalizationsAr([String locale = 'ar']) : super(locale);

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
}
