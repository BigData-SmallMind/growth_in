import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class GrowthInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GrowthInAppBar({
    super.key,
    this.title,
    required this.logoVariation,
  });

  final String? title;
  final bool logoVariation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return logoVariation
        ? AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: Container(
              margin: const EdgeInsetsDirectional.only(start: Spacing.large),
              child: const SvgAsset(AssetPathConstants.logoPath),
            ),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
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
            title: title != null ? Text(title!) : null,
          )
        : AppBar(
            backgroundColor: Colors.transparent,
            title: title != null
                ? Text(title!,
                    style: textTheme.titleMedium?.copyWith(fontSize: 18))
                : null,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: Navigator.of(context).pop,
            ),
          );
  }
}
