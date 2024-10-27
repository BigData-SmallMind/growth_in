import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FolderChangeNotifier with ChangeNotifier, EquatableMixin {
  FolderChangeNotifier();

  final ValueNotifier<Folder?> _folder = ValueNotifier(null);

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
        _folder,
      ];
}
