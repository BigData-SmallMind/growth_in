import 'file_localizations.dart';

/// The translations for English (`en`).
class FileLocalizationsEn extends FileLocalizations {
  FileLocalizationsEn([super.locale = 'en']);

  @override
  String get assetsSectionTitle => 'Assets';

  @override
  String get downloadAllTextButtonLabel => 'Download all';

  @override
  String get verifyFileButtonLabel => 'Approve';

  @override
  String get verifyFileMessageTitle =>
      'Are you sure you want to approve the file?';

  @override
  String get verifyFileMessageBody => 'Modifications will be halted.';

  @override
  String get rejectFileButtonLabel => 'Reject';

  @override
  String get rejectFileMessageTitle => 'Rejection Notice';

  @override
  String get rejectFileMessageBody =>
      'Your comments will be reviewed and modifications will begin.';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get fileApprovalSuccessSnackBarMessage => 'Approval was successful.';

  @override
  String get fileRejectionSuccessSnackBarMessage =>
      'The file has been rejected. The team will be notified.';
}
