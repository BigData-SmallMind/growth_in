import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FolderChangeNotifier with ChangeNotifier, EquatableMixin {
  FolderChangeNotifier();

  final ValueNotifier<FileV2DM?> _file = ValueNotifier(null);
  final ValueNotifier<Folder?> _folder = ValueNotifier(null);

  // This is a notifier of the file
  FileV2DM? get file => _file.value;
  void setFile(FileV2DM? file) {
    _file.value = file;
    notifyListeners();
  }
  Future clearFile() async {
    _file.value = null;
    notifyListeners();
  }

  // This is a notifier of the folder
  Folder? get folder => _folder.value;
  void setFolder(Folder? folder) {
    _folder.value = folder;
    notifyListeners();
  }
  Future clearFolder() async {
    _folder.value = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        _file,
        _folder,
      ];
}
