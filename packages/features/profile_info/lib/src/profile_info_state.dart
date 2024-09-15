part of 'profile_info_cubit.dart';

class ProfileInfoState extends Equatable {
  const ProfileInfoState({
    this.user,
  });

  final User? user;

  ProfileInfoState copyWith({User? user}) {
    return ProfileInfoState(
      user: user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}

enum ProfileInfoFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
