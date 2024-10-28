part of 'cms_cubit.dart';

class CmsState extends Equatable {
  const CmsState({
    this.posts,
    this.campaigns,
    this.campaignsFetchingStatus = CampaignsFetchingStatus.initial,
    this.postsFetchingStatus = PostsFetchingStatus.initial,
  });

  final List<Post>? posts;
  final List<Campaign>? campaigns;
  final PostsFetchingStatus postsFetchingStatus;
  final CampaignsFetchingStatus campaignsFetchingStatus;

  CmsState copyWith({
    List<Post>? posts,
    List<Campaign>? campaigns,
    PostsFetchingStatus? postsFetchingStatus,
    CampaignsFetchingStatus? campaignsFetchingStatus,
  }) {
    return CmsState(
      posts: posts ?? this.posts,
      campaigns: campaigns ?? this.campaigns,
      postsFetchingStatus: postsFetchingStatus ?? this.postsFetchingStatus,
      campaignsFetchingStatus:
          campaignsFetchingStatus ?? this.campaignsFetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        posts,
        campaigns,
        postsFetchingStatus,
        campaignsFetchingStatus,
      ];
}

enum PostsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum CampaignsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
