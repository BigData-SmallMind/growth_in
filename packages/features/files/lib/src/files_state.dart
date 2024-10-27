part of 'files_cubit.dart';

class FilesState extends Equatable {
  const FilesState({
    this.files,
    this.fetchingStatus = FilesFetchingStatus.initial,
  });

  final List<FileV2DM>? files;
  final FilesFetchingStatus fetchingStatus;

  FilesState copyWith({
    List<FileV2DM>? files,
    FilesFetchingStatus? fetchingStatus,
  }) {
    return FilesState(
      files: files ?? this.files,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        files,
        fetchingStatus,
      ];
}

enum FilesFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
