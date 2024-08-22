import 'package:component_library/src/theme/growth_in_theme_data.dart';
import 'package:flutter/material.dart';

class GrowthInTheme extends InheritedWidget {
  const GrowthInTheme({
    required super.child,
    required BuildContext context,
    required this.lightTheme,
    required this.darkTheme,
    super.key,
  });

  final GrowthInThemeData lightTheme;
  final GrowthInThemeData darkTheme;

  @override
  bool updateShouldNotify(
    GrowthInTheme oldWidget,
  ) =>
      oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  static GrowthInThemeData of(BuildContext context) {
    final GrowthInTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<GrowthInTheme>();
    assert(inheritedTheme != null, 'No GrowthInTheme found in context');
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
