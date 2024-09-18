import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.url,
    required this.initials,
  });

  final String? url;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        shape: BoxShape.circle,
      ),
      child: url != null
          ? Image.network(url!)
          : Center(
              child: Text(
                initials,
                style: textTheme.headlineMedium?.copyWith(
                  color: theme.materialThemeData.colorScheme.surface,
                ),
              ),
            ),
    );
  }
}
