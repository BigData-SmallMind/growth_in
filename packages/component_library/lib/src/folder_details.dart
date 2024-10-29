import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class FolderDetails extends StatelessWidget {
  const FolderDetails({
    super.key,
    required this.folder,
  });

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          folder.name,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        VerticalGap.small(),
        Text(
          folder.project?.description ?? '',
          style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF797979)),
        ),
        VerticalGap.small(),
        if (folder.milestone?.title != null)
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  l10n.mileStoneSectionTitle,
                  style: textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.circle,
                color: folder.milestone?.color,
              ),
              HorizontalGap.small(),
              Text(
                folder.milestone!.title!,
              ),
            ],
          ),
        VerticalGap.small(),
        Row(
          children: [
            SizedBox(width: 100, child: Text(l10n.dueDateSectionTitle)),
            Text(
              folder.dueDate.toIso8601String().split('T').first,
            ),
          ],
        ),
      ],
    );
  }
}
