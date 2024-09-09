import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAsset extends StatelessWidget {
  const SvgAsset(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.scaleDown,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    // final theme = GrowthInkTheme.of(context);

    return SvgPicture.asset(
      width: width,
      height: height,
      assetPath,
      fit: fit ?? BoxFit.scaleDown,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
    );
  }
}

class AssetPathConstants {
  const AssetPathConstants._();

  static const String assetsPath = 'assets';
  static const String iconsPath = '$assetsPath/icons';
  static const String tabContainerIconsPath = '$iconsPath/tab_container';
  static const String logoPath = '$iconsPath/logo.svg';
  static const String homeSelectedPath =
      '$tabContainerIconsPath/home_selected.svg';
  static const String homeUnselectedPath =
      '$tabContainerIconsPath/home_unselected.svg';
  static const String filesSelectedPath =
      '$tabContainerIconsPath/files_selected.svg';
  static const String filesUnselectedPath =
      '$tabContainerIconsPath/files_unselected.svg';
  static const String messagesSelectedPath =
      '$tabContainerIconsPath/messages_selected.svg';
  static const String messagesUnselectedPath =
      '$tabContainerIconsPath/messages_unselected.svg';
  static const String cmsSelectedPath =
      '$tabContainerIconsPath/cms_selected.svg';
  static const String cmsUnselectedPath =
      '$tabContainerIconsPath/cms_unselected.svg';
  static const String menuSelectedPath =
      '$tabContainerIconsPath/menu_selected.svg';
  static const String menuUnselectedPath =
      '$tabContainerIconsPath/menu_unselected.svg';
}
