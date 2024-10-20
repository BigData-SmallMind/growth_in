import 'tickets_localizations.dart';

/// The translations for English (`en`).
class TicketsLocalizationsEn extends TicketsLocalizations {
  TicketsLocalizationsEn([super.locale = 'en']);

  @override
  String get appBarTitle => 'Help & Support';

  @override
  String get activeTicketsTabLabel => 'Active';

  @override
  String get inActiveTicketsTabLabel => 'InActive';

  @override
  String get noTicketsMessageTitle => 'No messages!';

  @override
  String get noTicketsMessageSubtitle => 'We are always here to help! Start a new conversation and let us know how we can assist you';

  @override
  String get noTicketsButtonLabel => 'Contact Us Now';

  @override
  String get emptyListIndicatorText => 'List is empty';
}
