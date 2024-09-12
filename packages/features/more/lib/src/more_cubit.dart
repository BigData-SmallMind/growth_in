import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit({
    required this.userRepository,
    required this.onCompanyTileTap,
  }) : super(const MoreState()) {
    userRepository.getUser().listen((user) {
      emit(state.copyWith(user: null));
      emit(state.copyWith(user: user));
    });
  }

  final UserRepository userRepository;
  final VoidCallback onCompanyTileTap;

// @override
// Future<void> close() {
//   return super.close();
// }
}
