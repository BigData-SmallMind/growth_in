
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';


class PostSummary extends StatelessWidget {
  const PostSummary({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        VerticalGap.large(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.screenMargin,
          ),
          child: Text(
            post.text!,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

