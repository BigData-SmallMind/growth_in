import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class BottomSheetButtons extends StatelessWidget {
  const BottomSheetButtons({
    super.key,
    required this.onApply,
    required this.onCancel,
  });

  final VoidCallback onApply;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GrowthInElevatedButton(
            bgColor: theme.materialThemeData.colorScheme.surface,
            labelColor: theme.primaryColor,
            borderColor: theme.primaryColor,
            width: 100,
            height: 30,
            label: l10n.cancelButtonLabel,
            onTap: onCancel,
          ),
          HorizontalGap.medium(),
          GrowthInElevatedButton(
            width: 100,
            height: 30,
            label: l10n.applyButtonLabel,
            onTap: onApply,
          ),
          SizedBox(
            width: theme.screenMargin,
          ),
        ],
      ),
    );
  }
}
