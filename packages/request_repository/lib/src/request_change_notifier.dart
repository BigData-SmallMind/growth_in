import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RequestChangeNotifier with ChangeNotifier, EquatableMixin {
  RequestChangeNotifier();

  final ValueNotifier<Request?> _request = ValueNotifier(null);


  // This is a notifier of the request
  Request? get request => _request.value;
  void setRequest(Request? request) {
    _request.value = request;
    notifyListeners();
  }
  Future clearRequest() async {
    _request.value = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        _request,
      ];
}
