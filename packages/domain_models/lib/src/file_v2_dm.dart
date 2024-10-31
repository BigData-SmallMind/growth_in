class FileV2DM {
  FileV2DM({
    required this.id,
     this.name,
    required this.fileSize,
    required this.typeIcon,
    this.linkName,
    this.link,
    required this.status,
    required this.assets,
  });

  final int id;
  final String? name;
  final int fileSize;
  final FileV2Type typeIcon;
  final String? linkName;
  final String? link;
  final String status;
  final List<AssetDM> assets;
}

class AssetDM {
  AssetDM({
    required this.name,
    required this.size,
  });

  final String name;
  final int size;
}

enum FileV2Type {
  file,
  folder,
  link,
}
