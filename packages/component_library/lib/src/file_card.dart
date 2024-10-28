import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';


class FileCard extends StatelessWidget {
  const FileCard({
    super.key,
    required this.file,
    required this.onFileTapped,
    required this.downloadFiles,
  });

  final FileV2DM file;
  final ValueSetter<FileV2DM> onFileTapped;
  final ValueSetter<List<String>> downloadFiles;
  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onFileTapped(file);
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
          mainAxisSize: MainAxisSize.min,
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
                  child: Text(file.status),
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
                                  file.name,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              l10n.folderDetailsBottomSheetTitle,
                                              style: textTheme.titleMedium,
                                            ),
                                            VerticalGap.large(),
                                            Text(
                                              file.name,
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
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
                              ListTile(
                                title: Text(l10n.downloadAllTileTitle),
                                onTap: () {
                                  final slugs = [
                                    file.name,
                                    if (file.assets.isNotEmpty)
                                      ...file.assets.map((asset) => asset.name),
                                  ];
                                  // debugPrint(slugs.toString());
                                  downloadFiles(slugs);
                                },
                                leading: const SvgAsset(
                                  AssetPathConstants.exportPath,
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            VerticalGap.small(),
            Row(
              children: [
                if (file.typeIcon == FileV2Type.file)
                  const SvgAsset(AssetPathConstants.fileV2Path),
                if (file.typeIcon == FileV2Type.folder)
                  const SvgAsset(AssetPathConstants.coloredFolderPath),
                if (file.typeIcon == FileV2Type.link)
                  const SvgAsset(AssetPathConstants.hyperlinkPath),
                HorizontalGap.small(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        file.name,
                        style: textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      '${l10n.assetCountText} : ${file.assets.length}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
