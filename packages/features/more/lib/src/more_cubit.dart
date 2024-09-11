import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit({
    required this.userRepository,
  }) : super(const MoreState()) {
    userRepository.getUser().first.then((user) {
      emit(state.copyWith(user: user));
    });
  }

  final UserRepository userRepository;

// @override
// Future<void> close() {
//   return super.close();
// }
}
