class Post {
  const Post({
    required this.id,
    this.channel,
    this.contentGoal,
    this.contentType,
    this.text,
    this.images,
    required this.publicationDate,
    required this.status,
    required this.shouldShowRedDot,
  });

  final int id;
  final List<SocialChannel>? channel;
  final String? contentGoal;
  final String? contentType;
  final String? text;
  final List<String>? images;
  final DateTime publicationDate;
  final PostStatus status;
  final bool shouldShowRedDot;
}

enum PostStatus {
  accepted,
  newPost,
  editing,
}

enum SocialChannel {
  facebook,
  twitter,
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
