import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class GrowthInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GrowthInAppBar({
    super.key,
    this.title,
  });

  final Widget? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: Container(
        margin: const EdgeInsetsDirectional.only(start:Spacing.large),
        child: const SvgAsset(AssetPathConstants.logoPath),
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(Spacing.xSmall *2),
            margin: EdgeInsetsDirectional.only(end: theme.screenMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.borderColor),
            ),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
      title: title,
    );
  }
}
