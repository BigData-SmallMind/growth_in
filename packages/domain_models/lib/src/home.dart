import 'package:domain_models/domain_models.dart';

class Home {
  const Home({
    this.meeting,
    this.post,
    this.dashboardLink,
  });

  final Meeting? meeting;
  final Post? post;
  final String? dashboardLink;
}
