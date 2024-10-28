import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class FolderCard extends StatelessWidget {
  const FolderCard({
    super.key,
    required this.folder,
    required this.onFolderTapped,
  });

  final Folder folder;
  final ValueSetter<Folder>? onFolderTapped;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        onFolderTapped!(folder);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.medium,
          horizontal: Spacing.small,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                    vertical: Spacing.xSmall,
                  ),
                  decoration: BoxDecoration(
                    color: theme.borderColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(folder.status),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: theme.screenMargin),
                                child: Text(
                                  folder.name,
                                  style: textTheme.titleMedium,
                                ),
                              ),
                              VerticalGap.large(),
                              ListTile(
                                title: Text(l10n.detailsTileTitle),
                                onTap: () {
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                    context: context,
                                    showDragHandle: true,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: theme.screenMargin),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              l10n.folderDetailsBottomSheetTitle,
                                              style: textTheme.titleMedium,
                                            ),
                                            VerticalGap.large(),
                                            FolderDetails(folder: folder),
                                            VerticalGap.small(),
                                            Row(
                                              children: [
                                                const SvgAsset(
                                                  AssetPathConstants.filePath,
                                                  color: Color(0xFF787486),
                                                ),
                                                HorizontalGap.small(),
                                                Text(
                                                  '${folder.filesCount}',
                                                  style: textTheme.bodyMedium?.copyWith(
                                                    color: const Color(0xFF787486),
                                                  ),
                                                ),
                                                HorizontalGap.small(),
                                                const SvgAsset(
                                                  AssetPathConstants.messagePath,
                                                ),
                                                HorizontalGap.small(),
                                                Text(
                                                  '${folder.commentsCount}',
                                                  style: textTheme.bodyMedium?.copyWith(
                                                    color: const Color(0xFF787486),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            VerticalGap.small(),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                leading: const SvgAsset(
                                  AssetPathConstants.filePath,
                                ),
                              ),
                              if (folder.forms.isNotEmpty)
                                ListTile(
                                  title: const Text('l10n.strategiesTileTitle'),
                                  onTap: () {},
                                ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            Text(
              folder.name,
            ),
            Row(
              children: [
                const SvgAsset(
                  AssetPathConstants.clockPath,
                  color: Color(0xFF787486),
                ),
                HorizontalGap.small(),
                Text(
                  folder.dueDate.toIso8601String().split('T').first,
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF787486),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SvgAsset(
                  AssetPathConstants.filePath,
                  color: Color(0xFF787486),
                ),
                HorizontalGap.small(),
                Text(
                  '${folder.filesCount}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF787486),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SvgAsset(
                  AssetPathConstants.messagePath,
                ),
                HorizontalGap.small(),
                Text(
                  '${folder.commentsCount}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF787486),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
