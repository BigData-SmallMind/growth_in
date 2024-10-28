import 'file_localizations.dart';

/// The translations for Arabic (`ar`).
class FileLocalizationsAr extends FileLocalizations {
  FileLocalizationsAr([super.locale = 'ar']);

  @override
  String get assetsSectionTitle => 'ملحقات';

  @override
  String get downloadAllTextButtonLabel => 'تحميل الكل';

  @override
  String get verifyFileButtonLabel => 'الموافقة';

  @override
  String get verifyFileMessageTitle => 'متأكد من الموافقة على الملف؟';

  @override
  String get verifyFileMessageBody => 'سيتم ايقاف التعديلات';

  @override
  String get rejectFileButtonLabel => 'رفض';

  @override
  String get rejectFileMessageTitle => 'إشعار الرفض';

  @override
  String get rejectFileMessageBody => 'سيتم مراجعة تعليقاتك و البدء في التعديلات';

  @override
  String get cancelButtonLabel => 'إلغاء';

  @override
  String get fileApprovalSuccessSnackBarMessage => 'تمت الموافقة بنجاح';

  @override
  String get fileRejectionSuccessSnackBarMessage => 'تم رفض الملف سيتم اشعار الفريق ';
}
