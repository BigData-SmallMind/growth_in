import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CmsChangeNotifier with ChangeNotifier, EquatableMixin {
  CmsChangeNotifier();

  final ValueNotifier<FileV2DM?> _file = ValueNotifier(null);

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


  @override
  List<Object?> get props => [
        _file,
      ];
}
