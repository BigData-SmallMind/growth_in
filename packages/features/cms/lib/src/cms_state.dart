part of 'cms_cubit.dart';

class CmsState extends Equatable {
  const CmsState({
    this.posts,
    this.campaigns,
    this.timelineTabDate,
    this.calendarTabDate,
    this.calendarTabViewType = CalendarTabViewType.month,
    this.campaignsFetchingStatus = CampaignsFetchingStatus.initial,
    this.postsFetchingStatus = PostsFetchingStatus.initial,
  });

  final List<Post>? posts;
  final List<Campaign>? campaigns;
  final DateTime? timelineTabDate;
  final DateTime? calendarTabDate;
  final CalendarTabViewType calendarTabViewType;
  final PostsFetchingStatus postsFetchingStatus;
  final CampaignsFetchingStatus campaignsFetchingStatus;

  List<List<Post>> get postsByWeek =>
      splitPostsByWeek(timelineTabDate, posts ?? []);

// Extract publication dates from posts
  List<DateTime> get postDates =>
      posts?.map((post) => post.publicationDate).toList() ?? [];

  List<Post> get dayFilteredPosts =>
      posts?.where((post) {
        return post.publicationDate.year == calendarTabDate?.year &&
            post.publicationDate.month == calendarTabDate?.month &&
            post.publicationDate.day == calendarTabDate?.day;
      }).toList() ??
      [];

  CmsState copyWith({
    List<Post>? posts,
    List<Campaign>? campaigns,
    DateTime? timelineTabDate,
    DateTime? calendarTabDate,
    CalendarTabViewType? calendarTabViewType,
    PostsFetchingStatus? postsFetchingStatus,
    CampaignsFetchingStatus? campaignsFetchingStatus,
  }) {
    return CmsState(
      posts: posts ?? this.posts,
      campaigns: campaigns ?? this.campaigns,
      timelineTabDate: timelineTabDate ?? this.timelineTabDate,
      calendarTabDate: calendarTabDate ?? this.calendarTabDate,
      calendarTabViewType: calendarTabViewType ?? this.calendarTabViewType,
      postsFetchingStatus: postsFetchingStatus ?? this.postsFetchingStatus,
      campaignsFetchingStatus:
          campaignsFetchingStatus ?? this.campaignsFetchingStatus,
    );
  }

  List<List<Post>> splitPostsByWeek(DateTime? date, List<Post> posts) {
    // Ensure we have a valid month
    final monthlyPosts = posts.where((post) {
      return post.publicationDate.year == date?.year &&
          post.publicationDate.month == date?.month;
    }).toList();

    if (monthlyPosts.isEmpty) return List.generate(4, (_) => []);

    // Find the month and year from the first publication date
    final firstDate = monthlyPosts.first.publicationDate;
    final month = firstDate.month;
    final year = firstDate.year;

    // Create a list of four lists for each week
    List<List<Post>> weeks = List.generate(4, (_) => []);

    // Loop through each publication and categorize them by week
    for (var publication in monthlyPosts) {
      if (publication.publicationDate.year == year &&
          publication.publicationDate.month == month) {
        // Determine the week of the month (0-based index)
        int weekIndex = ((publication.publicationDate.day - 1) / 7).floor();
        if (weekIndex < 4) {
          weeks[weekIndex].add(publication);
        }
      }
    }

    return weeks;
  }

  @override
  List<Object?> get props => [
        posts,
        campaigns,
        timelineTabDate,
        calendarTabDate,
        calendarTabViewType,
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

enum CalendarTabViewType {
  month,
  week,
}
