part of 'folders_cubit.dart';

class FoldersState extends Equatable {
  const FoldersState({
    this.folders,
    this.fetchingStatus = FoldersFetchingStatus.initial,
  });

  final Folders? folders;
  final FoldersFetchingStatus fetchingStatus;

  List<Folder> get activeFolders => folders?.active ?? [];

  List<Folder> get inActiveFolders => folders?.inactive ?? [];

  FoldersState copyWith({
    Folders? folders,
    FoldersFetchingStatus? fetchingStatus,
  }) {
    return FoldersState(
      folders: folders ?? this.folders,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        folders,
        fetchingStatus,
      ];
}

enum FoldersFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
