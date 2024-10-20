import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

// If the number of properties get too big, we can start grouping them in
// classes like Flutter does with TextTheme, ButtonTheme, etc, inside ThemeData.
abstract class GrowthInThemeData {
  ThemeData get materialThemeData;

  final iconColor = const Color(0xFF191F6D);
  final primaryColor = const Color(0xFF004746);
  final secondaryColor = const Color(0xFF1A877E);
  final tertiaryColor = const Color(0xFF08B295);

  final successContainerColor = const Color(0xFFE3FFEC);
  final successOnContainerColor = const Color(0xFF19B100);
  final successTextColor = const Color(0xFF19B100);

  final errorColor = const Color(0xFFF56342);
  final errorContainerColor = const Color(0xFFFFF0ED);

  final secondaryContainerBgColor = const Color(0xFFDCE3F6);
  final tertiaryContainerBgColor = const Color.fromRGBO(228, 240, 232, 0.44);
  final borderColor = const Color(0xFFD9D9D9);
  final dimmedTextColor = const Color(0xFF5A5D66);
  final secondaryIconColor = const Color(0xFF8B8B8B);
  final  questionDescriptionColor = const Color(0xFF797979);

  final screenMargin = Spacing.mediumLarge;
  final listViewVerticalSpacing = Spacing.medium;
  final textFieldBorderRadius = 10.0;
  final searchTextFieldBorderRadius = 25.0;
  final double elevatedButtonBorderRadius = 10;

  final profileDescriptionTextShadow = Shadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: Colors.black.withOpacity(0.25),
  );

  final boxShadow = const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15), // Shadow color with opacity
      offset: Offset(0, 3), // Horizontal and vertical offsets
      blurRadius: 3, // Blur radius
    ),
  ];

  final hintStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF1F1F1F).withOpacity(0.5),
  );

}

class LightGrowthInThemeData extends GrowthInThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.medium,
          ), // Rem
          minimumSize: const Size(50, 25),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )),
        bottomSheetTheme: BottomSheetThemeData(
          dragHandleSize: const Size(200, 6),
          dragHandleColor: borderColor,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
        dividerTheme: DividerThemeData(
          color: borderColor,
          thickness: 1,
          indent: 0,
          space: 0,
        ),
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: tertiaryColor,
          primaryContainer: const Color(0xFFF0EFF5),
          tertiaryContainer: const Color(0xFFF0EFF5),
          error: errorColor,
          errorContainer: const Color(0xFFFFF0ED),
        ),
        tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color(0xFFC3C5C8),
          labelColor: Colors.white,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: hintStyle,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Spacing.medium,
            vertical: 15,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          suffixIconColor: secondaryIconColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
      );
}

class DarkGrowthInThemeData extends GrowthInThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
            primary: Colors.indigo, secondary: Colors.deepPurpleAccent),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.white.withOpacity(0.8),
          labelColor: Colors.white,
          dividerColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
      );
}
