import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

const double elevatedButtonHeight = 55;

class GrowthInElevatedButton extends StatelessWidget {
  const GrowthInElevatedButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.height,
    this.width,
    this.borderRadius,
    this.labelColor = Colors.white,
    this.bgColor,
    this.borderColor = Colors.transparent,
    this.iconAlignment = IconAlignment.start,
    this.buttonStyle,
    super.key,
  });

  GrowthInElevatedButton.inProgress({
    required String label,
    double? width,
    double? height,
    double? borderRadius,
    IconAlignment iconAlignment = IconAlignment.start,
    ButtonStyle? buttonStyle,
    Key? key,
  }) : this(
          iconAlignment: iconAlignment,
          label: label,
          width: width,
          onTap: null,
          height: height,
          labelColor: Colors.black,
          borderRadius: borderRadius,
          icon: Transform.scale(
            scale: 0.4,
            child: const CircularProgressIndicator(),
          ),
          buttonStyle: buttonStyle,
          key: key,
        );

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;
  final Color? labelColor;
  final Color? bgColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final IconAlignment iconAlignment;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = GrowthInTheme.of(context).materialThemeData.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;

    final buttonStyle = this.buttonStyle ??
        ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? theme.elevatedButtonBorderRadius,
            ),
            side: BorderSide(color: borderColor),
          ),
        );
    return SizedBox(
      height: height ?? elevatedButtonHeight,
      width: width ?? screenWidth,
      child: icon != null
          ? ElevatedButton.icon(
              style: buttonStyle,
              onPressed: onTap,
              iconAlignment: iconAlignment,
              label: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              icon: icon!,
            )
          : ElevatedButton(
              style: buttonStyle,
              onPressed: onTap,
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
