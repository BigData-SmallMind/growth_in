import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class AddComment extends StatelessWidget {
  const AddComment({
    super.key,
    required this.enabled,
    required this.onCommentChanged,
    required this.onSubmit,
    required this.isLoading,
    required this.controller,
  });

  final bool enabled;
  final ValueChanged<String> onCommentChanged;
  final VoidCallback onSubmit;
  final bool isLoading;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: theme.screenMargin,
            ),
            child: TextFormField(
              controller: controller,
              onChanged: onCommentChanged,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Spacing.large,
                  vertical: Spacing.xSmall,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: theme.borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: isLoading
                ? Transform.scale(
                    scale: 0.5,
                    child: const CenteredCircularProgressIndicator(),
                  )
                : Icon(
                    Icons.send,
                    color: !enabled ? Colors.grey : theme.primaryColor,
                  ),
            onPressed: enabled ? onSubmit : null,
          ),
        ),
        HorizontalGap.custom(theme.screenMargin),
      ],
    );
  }
}
