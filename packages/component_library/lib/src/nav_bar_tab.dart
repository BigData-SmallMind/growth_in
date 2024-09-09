import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NavBarTab extends StatelessWidget {
  const NavBarTab({
    super.key,
    required this.title,
    required this.svgPath,
  });

  final String title;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context).materialThemeData;
    // final appLocale = Localizations.localeOf(context);
    // final isArabic = appLocale == const Locale('ar');
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Tab(
        iconMargin: const EdgeInsets.only(bottom: 8),

        text: title,
        icon: SvgPicture.asset(
          svgPath,
          // colorFilter: ColorFilter.mode(
          //   isSelected
          //       ? theme.colorScheme.surface
          //       : theme.tabBarTheme.unselectedLabelColor!,
          //   BlendMode.srcIn,
          // ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
