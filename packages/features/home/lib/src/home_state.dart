part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user,
    this.home,
    this.fetchingStatus = HomeFetchingStatus.initial,
  });

  final User? user;
  final Home? home;
  final HomeFetchingStatus fetchingStatus;

  HomeState copyWith({
    User? user,
    Home? home,
    HomeFetchingStatus? fetchingStatus,
  }) {
    return HomeState(
      user: user ?? this.user,
      home: home ?? this.home,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        user,
        home,
        fetchingStatus,
      ];
}

enum HomeFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
