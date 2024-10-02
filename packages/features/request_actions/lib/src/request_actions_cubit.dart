import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'request_actions_state.dart';

class RequestActionsCubit extends Cubit<RequestActionsState> {
  RequestActionsCubit({
    required this.requestRepository,
    required this.onViewActionStepsTapped,
  }) : super(
          RequestActionsState(
            request: requestRepository.changeNotifier.request,
          ),
        );

  final RequestRepository requestRepository;
  final ValueSetter<int> onViewActionStepsTapped;

// @override
// Future<void> close() {
//   return super.close();
// }
}
