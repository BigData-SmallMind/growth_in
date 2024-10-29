import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CmsChangeNotifier with ChangeNotifier, EquatableMixin {
  CmsChangeNotifier();

  final ValueNotifier<Post?> _post = ValueNotifier(null);

  // This is a notifier of the post
  Post? get post => _post.value;
  void setPost(Post? post) {
    _post.value = post;
    notifyListeners();
  }
  Future clearPost() async {
    _post.value = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        _post,
      ];
}
