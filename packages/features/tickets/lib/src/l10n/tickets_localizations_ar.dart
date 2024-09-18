import 'tickets_localizations.dart';

/// The translations for Arabic (`ar`).
class TicketsLocalizationsAr extends TicketsLocalizations {
  TicketsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الدعم و المساعده';

  @override
  String get activeTicketsTabLabel => 'النشط';

  @override
  String get inActiveTicketsTabLabel => 'المنتهي';

  @override
  String get noTicketsMessageTitle => 'لا يوجد رسائل!';

  @override
  String get noTicketsMessageSubtitle => 'نحن هنا دائمًا لمساعدتك! ابدأ محادثة جديدة واخبرنا كيف يمكننا مساعدتك.';

  @override
  String get noTicketsButtonLabel => 'تواصل الان';

  @override
  String get emptyListIndicatorText => 'لا يوجد رسائل';
}
