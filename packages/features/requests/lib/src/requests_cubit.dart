import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({
    required this.onRequestTapped,
  }) : super(RequestsState(requests: dummyRequests));

  final VoidCallback onRequestTapped;

// @override
// Future<void> close() {
//   return super.close();
// }
}
