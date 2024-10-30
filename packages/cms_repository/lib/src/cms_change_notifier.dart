import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CmsChangeNotifier with ChangeNotifier, EquatableMixin {
  CmsChangeNotifier();

  final ValueNotifier<Post?> _post = ValueNotifier(null);
  final ValueNotifier<PostVersion?> _postVersion = ValueNotifier(null);

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

  // This is a notifier of the post version
  PostVersion? get postVersion => _postVersion.value;

  void setPostVersion(PostVersion? postVersion) {
    _postVersion.value = postVersion;
    notifyListeners();
  }

  Future clearPostVersion() async {
    _postVersion.value = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        _post,
        _postVersion,
      ];
}
