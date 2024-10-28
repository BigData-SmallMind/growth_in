class Campaign {
  const Campaign({
    required this.id,
    required this.name,
    required this.contentGoal,
    this.summary,
    required this.postCount,
  });

  final int id;
  final String name;
  final String contentGoal;
  final String? summary;
  final int postCount;
}
