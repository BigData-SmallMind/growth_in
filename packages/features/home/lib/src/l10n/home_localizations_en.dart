import 'home_localizations.dart';

/// The translations for English (`en`).
class HomeLocalizationsEn extends HomeLocalizations {
  HomeLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarGreetingMessage => 'Good morning';

  @override
  String get recentPostsSectionTitle => 'Recent Posts';

  @override
  String get viewAllButtonLabel => 'View All';

  @override
  String get upcomingMeetingSectionTitle => 'Your Upcoming Meeting';

  @override
  String get unpublishedPostsContainerTitle => 'Unpublished Content';

  @override
  String get continuePublishingButtonLabel => 'Continue';

  @override
  String get unapprovedFilesContainerTitle => 'Files Pending Approval';

  @override
  String get dashboardContainerTitle => 'Dashboard';
}
