import 'cms_localizations.dart';

/// The translations for English (`en`).
class CmsLocalizationsEn extends CmsLocalizations {
  CmsLocalizationsEn([super.locale = 'en']);

  @override
  String get appBarTitle => 'Files';

  @override
  String get calendarTabLabel => 'Calendar';

  @override
  String get timelineTabLabel => 'Timeline';

  @override
  String get campaignsTabLabel => 'Campaigns';

  @override
  String get noCmsMessageTitle => 'No Cms!';

  @override
  String get noCmsMessageSubtitle => 'No Cms';

  @override
  String get noCmsButtonLabel => 'Try Again';

  @override
  String get emptyListIndicatorText => 'List is empty';

  @override
  String get folderDetailsBottomSheetTitle => 'Details';

  @override
  String get mileStoneSectionTitle => 'Milestone';

  @override
  String get weekNumber => 'Week';

  @override
  String get weekDropdownItemLabel => 'Week';

  @override
  String get monthDropdownItemLabel => 'Month';
}
