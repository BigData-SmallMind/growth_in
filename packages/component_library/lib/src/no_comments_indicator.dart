import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class NoCommentsIndicator extends StatelessWidget {
  const NoCommentsIndicator({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: SizedBox(
        width: 100,
        child: Text(
          l10n.noCommentsIndicatorText,
          style: textTheme.titleLarge,
        ),
      ),
    );
  }
}
