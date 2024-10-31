import 'package:json_annotation/json_annotation.dart';

part 'file_rm.g.dart';

@JsonSerializable(createToJson: false)
class FileV2RM {
  FileV2RM({
    required this.id,
    required this.name,
    required this.fileSize,
    required this.typeIcon,
    this.linkName,
    this.link,
    required this.status,
    required this.asserts,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'file_name')
  final String? name;
  @JsonKey(name: 'file_size')
  final int fileSize;
  @JsonKey(name: 'file_type_icon')
  final String typeIcon;
  @JsonKey(name: 'link_name')
  final String? linkName;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'assets')
  final List<AssetRM> asserts;

  static const fromJson = _$FileV2RMFromJson;
}

@JsonSerializable(createToJson: false)
class AssetRM {
  AssetRM({
    required this.name,
    required this.size,
  });

  @JsonKey(name: 'asset_name')
  final String name;
  @JsonKey(name: 'asset_size')
  final int size;

  static const fromJson = _$AssetRMFromJson;
}
