import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit({
    required this.userRepository,
  }) : super(const ProfileInfoState()) {
    userRepository.getUser().listen((user) {
     if(!isClosed) {
        emit(state.copyWith(user: null));
        emit(state.copyWith(user: user));
      }
    });
  }

  final UserRepository userRepository;

// @override
// Future<void> close() {
//   return super.close();
// }
}
