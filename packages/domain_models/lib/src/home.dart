import 'package:domain_models/domain_models.dart';

class Home {
  const Home({
    this.meeting,
    this.posts = const [],
    this.requests = const [],
    this.dashboardLink,
    this.filesCount,
  });

  final Meeting? meeting;
  final List<Post> posts;
  final List<Request> requests;
  final String? dashboardLink;
  final int? filesCount;

  Home copyWith({
    Meeting? meeting,
    List<Post>? posts,
    List<Request>? requests,
    String? dashboardLink,
    int? filesCount,
  }) {
    return Home(
      meeting: meeting ?? this.meeting,
      posts: posts ?? this.posts,
      requests: requests ?? this.requests,
      dashboardLink: dashboardLink ?? this.dashboardLink,
      filesCount: filesCount ?? this.filesCount,
    );
  }
}
