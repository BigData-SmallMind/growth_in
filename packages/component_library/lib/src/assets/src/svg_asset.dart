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

  // Tab container icons
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

  static const String backPath = '$iconsPath/back.svg';
  static const String gearPath = '$iconsPath/gear.svg';
  static const String headphonePath = '$iconsPath/headphone.svg';
  static const String logoutPath = '$iconsPath/logout.svg';
  static const String stickyNotePath = '$iconsPath/stickynote.svg';
  static const String taskSquarePath = '$iconsPath/task-square.svg';
  static const String videoPath = '$iconsPath/video.svg';
  static const String walletPath = '$iconsPath/wallet.svg';
  static const String noTicketsPath = '$iconsPath/no-tickets.svg';
  static const String receiptPath = '$iconsPath/receipt.svg';
  static const String clockPath = '$iconsPath/clock.svg';
  static const String sendPath = '$iconsPath/send.svg';
  static const String addPath = '$iconsPath/add.svg';
  static const String imagePath = '$iconsPath/image.svg';
  static const String cameraPath = '$iconsPath/camera.svg';
  static const String documentTextPath = '$iconsPath/document-text.svg';

  //social media
  static const String facebookPath = '$iconsPath/facebook.svg';
  static const String tiktokPath = '$iconsPath/tiktok.svg';
  static const String instaPath = '$iconsPath/instagram.svg';

  //mark as complete
  static const String markAsCompletePath = '$iconsPath/mark-as-complete.svg';
  static const String markAsCompleteActivePath =
      '$iconsPath/mark-as-complete-active.svg';
  static const String taskPath = '$iconsPath/task.svg';

  static const String tickCirclePath = '$iconsPath/tick_circle.svg';
  static const String closeCirclePath = '$iconsPath/close_circle.svg';

  static const String editPath = '$iconsPath/edit-2.svg';
  static const String pickFilesPath = '$iconsPath/pick-files.svg';
}
