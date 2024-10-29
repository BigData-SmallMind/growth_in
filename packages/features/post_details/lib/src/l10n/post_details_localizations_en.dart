import 'post_details_localizations.dart';

/// The translations for English (`en`).
class PostDetailsLocalizationsEn extends PostDetailsLocalizations {
  PostDetailsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Post Preview';

  @override
  String get detailsExpansionTileTitle => 'Publication Details';

  @override
  String get postPublicationDateRowTitle => 'Publication Dates';

  @override
  String get postSocialChannelsRowTitle => 'Publication Channels';

  @override
  String get postContentTypeRowTitle => 'Content Type';

  @override
  String get approvePostButtonLabel => 'Approve';
}
