class PostVersion {
  const PostVersion({
    required this.id,
    required this.postId,
    required this.username,
    required this.dateSubmitted,
    required this.isSelected,
  });

  final int id;
  final int postId;
  final String username;
  final DateTime dateSubmitted;
  final bool isSelected;
}
