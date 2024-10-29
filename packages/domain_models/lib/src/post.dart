class Post {
  const Post({
    required this.id,
    this.channels,
    this.contentGoal,
    this.contentType,
    this.text,
    this.images,
    required this.publicationDate,
    required this.status,
    required this.shouldShowRedDot,
    required this.hour
  });

  final int id;
  final List<SocialChannel>? channels;
  final String? contentGoal;
  final List<String>? contentType;
  final String? text;
  final List<String>? images;
  final DateTime publicationDate;
  final PostStatus status;
  final bool shouldShowRedDot;
  final String hour;
}

enum PostStatus {
  accepted,
  newPost,
  editing,
}

enum SocialChannel {
  facebook,
  x,
  instagram,
  linkedIn,
  snapchat,
  tikTok,
  youtube,
  pinterest,
  whatsapp,
  telegram,
  signal,
  email,
  sms,
  other,
}
