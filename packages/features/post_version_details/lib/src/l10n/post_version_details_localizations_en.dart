import 'post_version_details_localizations.dart';

/// The translations for English (`en`).
class PostVersionDetailsLocalizationsEn extends PostVersionDetailsLocalizations {
  PostVersionDetailsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get approvePostButtonLabel => 'Approve';

  @override
  String get approvePostBottomSheetTitle => 'Are you sure you want to approve this version?';

  @override
  String get approvePostBottomSheetBody => 'This version will be finalized and edits will be closed.';

  @override
  String get approvePostBottomSheetButtonLabel => 'Approve';

  @override
  String get cancelPostBottomSheetButtonLabel => 'There are still edits';

  @override
  String get postApprovalSuccessSnackBarMessage => 'Post approved successfully';
}
