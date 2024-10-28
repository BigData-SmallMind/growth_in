part of 'cms_cubit.dart';

class CmsState extends Equatable {
  const CmsState({
    this.cms,
    this.fetchingStatus = CmsFetchingStatus.initial,
  });

  final Cms? cms;
  final CmsFetchingStatus fetchingStatus;

  List<Folder> get activeCms => cms?.active ?? [];

  List<Folder> get inActiveCms => cms?.inactive ?? [];

  CmsState copyWith({
    Cms? cms,
    CmsFetchingStatus? fetchingStatus,
  }) {
    return CmsState(
      cms: cms ?? this.cms,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        cms,
        fetchingStatus,
      ];
}

enum CmsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
