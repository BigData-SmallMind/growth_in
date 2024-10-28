part of 'file_cubit.dart';

class FileState extends Equatable {
  const FileState({
    this.file,
    this.folder,
    this.rejectionStatus = RejectionStatus.initial,
    this.approvalStatus = ApprovalStatus.initial,
  });

  final FileV2DM? file;
  final Folder? folder;
  final RejectionStatus rejectionStatus;
  final ApprovalStatus approvalStatus;

  FileState copyWith({
    FileV2DM? file,
    Folder? folder,
    RejectionStatus? rejectionStatus,
    ApprovalStatus? approvalStatus,
  }) {
    return FileState(
      file: file ?? this.file,
      folder: folder ?? this.folder,
      rejectionStatus: rejectionStatus ?? this.rejectionStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  @override
  List<Object?> get props => [
        file,
        folder,
        rejectionStatus,
        approvalStatus,
      ];
}

enum RejectionStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum ApprovalStatus {
  initial,
  inProgress,
  success,
  failure,
}
