import 'package:domain_models/domain_models.dart';

class Home {
  const Home({
    this.meeting,
    this.post,
  });

  final Meeting? meeting;
  final Post? post;
}
