
class Comment {
  const Comment({
    required this.id,
    required this.author,
    required this.text,
    required this.dateCreated,
    this.authorImage,
  });

  final int id;
  final String author;
  final String text;
  final DateTime dateCreated;
  final String? authorImage;
}
