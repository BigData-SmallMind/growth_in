import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';




class PostVersionTile extends StatelessWidget {
  const PostVersionTile({
    super.key,
    required this.postVersion,
    this.onTapped,
  });

  final PostVersion postVersion;
  final VoidCallback? onTapped;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        postVersion.dateSubmitted.toIso8601String().split('T').first,
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Color(0xFF4FA0FF),
            size: 15,
          ),
          HorizontalGap.medium(),
          Text(postVersion.username),
        ],
      ),
      onTap: onTapped,
    );
  }
}
