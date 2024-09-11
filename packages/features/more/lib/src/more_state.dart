part of 'more_cubit.dart';

class MoreState extends Equatable {
  const MoreState({
    this.user,
  });

  final User? user;

  MoreState copyWith({User? user}) {
    return MoreState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}

enum MoreFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
