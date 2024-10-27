// class FolderRM {
//   FolderRM({
//     required this.id,
//     required this.name,
//     required this.dueDate,
//     required this.status,
//     this.forms = const [],
//     required this.filesCount,
//     required this.commentsCount,
//     required this.milestone,
//   });
//
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'folder_name')
//   final String name;
//   @JsonKey(name: 'due_date')
//   final String dueDate;
//   @JsonKey(name: 'status')
//   final String status;
//   @JsonKey(name: 'forms')
//   final List<FormRM> forms;
//   @JsonKey(name: 'total_files')
//   final int filesCount;
//   @JsonKey(name: 'comments_count')
//   final int commentsCount;
//   @JsonKey(name: 'current_milestone')
//   final MileStoneRM milestone;
//
//   static const fromJson = _$CompanyRMFromJson;
// }
import 'dart:ui';

import 'package:domain_models/domain_models.dart';

class Folders {
  Folders({
    required this.active,
    required this.inactive,
  });

  final List<Folder> active;
  final List<Folder> inactive;
}

class Folder {
  Folder({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.status,
    this.forms = const [],
    required this.filesCount,
    required this.commentsCount,
    required this.milestone,
  });

  final int id;
  final String name;
  final DateTime dueDate;
  final String status;
  final List<FormDM> forms;
  final int filesCount;
  final int commentsCount;
  final MileStone milestone;
}

class MileStone {
  MileStone({
    this.title,
    this.order,
    this.color,
  });

  final String? title;
  final String? order;
  final Color? color;
}
