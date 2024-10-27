// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoldersRM _$FoldersRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FoldersRM',
      json,
      ($checkedConvert) {
        final val = FoldersRM(
          active: $checkedConvert(
              'folders',
              (v) => (v as List<dynamic>)
                  .map((e) => FolderRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          inactive: $checkedConvert(
              'previous_folders',
              (v) => (v as List<dynamic>)
                  .map((e) => FolderRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'active': 'folders', 'inactive': 'previous_folders'},
    );

FolderRM _$FolderRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FolderRM',
      json,
      ($checkedConvert) {
        final val = FolderRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('folder_name', (v) => v as String),
          dueDate: $checkedConvert('due_date', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          forms: $checkedConvert(
              'forms',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => FormRM.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          filesCount: $checkedConvert('total_files', (v) => (v as num).toInt()),
          commentsCount:
              $checkedConvert('comments_count', (v) => (v as num).toInt()),
          milestone: $checkedConvert('current_milestone',
              (v) => MileStoneRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'name': 'folder_name',
        'dueDate': 'due_date',
        'filesCount': 'total_files',
        'commentsCount': 'comments_count',
        'milestone': 'current_milestone'
      },
    );

MileStoneRM _$MileStoneRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MileStoneRM',
      json,
      ($checkedConvert) {
        final val = MileStoneRM(
          title: $checkedConvert('title', (v) => v as String?),
          order: $checkedConvert('order', (v) => v as String?),
          color: $checkedConvert('color', (v) => v as String?),
        );
        return val;
      },
    );
