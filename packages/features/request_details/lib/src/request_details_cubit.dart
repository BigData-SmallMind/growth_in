import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit({
    required this.onProfileInfoTapped,
    required this.onChangePasswordTapped,
    required this.onChangeEmailTapped,
  }) : super(RequestDetailsState(request: dummyRequests.first));
  final VoidCallback onProfileInfoTapped;
  final VoidCallback onChangePasswordTapped;
  final VoidCallback onChangeEmailTapped;
// @override
// Future<void> close() {
//   return super.close();
// }
}
