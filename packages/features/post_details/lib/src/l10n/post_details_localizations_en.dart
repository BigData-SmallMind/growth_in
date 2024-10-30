import 'post_details_localizations.dart';

/// The translations for English (`en`).
class PostDetailsLocalizationsEn extends PostDetailsLocalizations {
  PostDetailsLocalizationsEn([super.locale = 'en']);

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

  @override
  String get approvePostBottomSheetTitle => 'By approving the post, the achievement will be determined';

  @override
  String get approvePostBottomSheetBody => 'And the modifications will be finalized';

  @override
  String get approvePostBottomSheetButtonLabel => 'Approve';

  @override
  String get cancelPostBottomSheetButtonLabel => 'There are still comments';

  @override
  String get postApprovalSuccessSnackBarMessage => 'Post approved successfully';
}
