import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class GrowthInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GrowthInAppBar({
    super.key,
    this.title,
    required this.logoVariation,
    this.onBackTapped,
    this.toolbarHeight,
  });

  final Widget? title;
  final bool logoVariation;
  final VoidCallback? onBackTapped;
  final double? toolbarHeight;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return logoVariation
        ? AppBar(
            toolbarHeight: toolbarHeight,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: Container(
              margin: const EdgeInsetsDirectional.only(start: Spacing.large),
              child: const SvgAsset(AssetPathConstants.logoPath),
            ),
            actions: [
              GestureDetector(
                onTap: onBackTapped ?? () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(Spacing.xSmall * 2),
                  margin: EdgeInsetsDirectional.only(end: theme.screenMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.borderColor),
                  ),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
            title: title != null ? (title!) : null,
          )
        : AppBar(
            toolbarHeight: toolbarHeight,
            backgroundColor: Colors.transparent,
            title: title != null ? (title!) : null,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: onBackTapped ?? Navigator.of(context).pop,
            ),
          );
  }
}
