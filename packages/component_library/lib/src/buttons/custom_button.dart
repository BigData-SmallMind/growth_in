import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.labelColor = Colors.black,
    this.decoration,
    this.height,
    this.constraints,
    super.key,
  });

  CustomButton.inProgress({
    required String label,
    BoxDecoration? decoration,
    double? height,
    BoxConstraints? constraints,
    Key? key,
  }) : this(
          label: label,
          onTap: null,
          labelColor: Colors.black,
          icon: Transform.scale(
            scale: 0.4,
            child: const CircularProgressIndicator(),
          ),
          decoration: decoration?.copyWith(
            color: Colors.grey[300],
          ),
          height: height ?? elevatedButtonHeight,
          constraints: constraints,
          key: key,
        );

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;
  final Color labelColor;
  final BoxDecoration? decoration;
  final double? height;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {},
      child: Container(
        height: height ?? elevatedButtonHeight,
        constraints: constraints,
        decoration: decoration,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.medium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              HorizontalGap.medium(),
            ],
            Text(
              label,
              maxLines: 1,
              style: textTheme.labelLarge?.copyWith(
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
