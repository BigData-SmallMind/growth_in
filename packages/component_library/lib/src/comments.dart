import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  const Comments({
    super.key,
    required this.comments,
    this.shouldShowAll = false,
    required this.onViewAllTapped,
  });

  final List<Comment> comments;
  final bool shouldShowAll;
  final VoidCallback onViewAllTapped;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        if (!shouldShowAll) ...[
          VerticalGap.medium(),
          const Divider(),
          VerticalGap.medium(),
        ],
        Row(
          children: [
            HorizontalGap.custom(theme.screenMargin),
            Text(l10n.commentsSectionTitle, style: textTheme.titleMedium),
            if (!shouldShowAll) ...[
              const Spacer(),
              TextButton(
                onPressed: comments.isNotEmpty ? onViewAllTapped : null,
                child: Text(
                  l10n.viewAllCommentsButtonLabel,
                  style: textTheme.bodySmall?.copyWith(
                    color:
                        comments.isNotEmpty ? theme.primaryColor : Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              HorizontalGap.custom(theme.screenMargin),
            ]
          ],
        ),
        VerticalGap.medium(),
        if (comments.isEmpty) const NoCommentsIndicator(),
        if (shouldShowAll && comments.isNotEmpty)
          for (final comment in comments)
            CommentWidget(
              comment: comment,
            ),
        if (!shouldShowAll && comments.isNotEmpty)
          CommentWidget(
            comment: comments.first,
          ),
      ],
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        HorizontalGap.custom(theme.screenMargin),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: comment.authorImage != null
                      ? NetworkImage(comment.authorImage!)
                      : null,
                  child: comment.authorImage == null
                      ? Text(
                          comment.author[0].toUpperCase(),
                          style: const TextStyle(color: Colors.black),
                        )
                      : null,
                ),
                HorizontalGap.small(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author,
                      style: textTheme.titleSmall,
                    ),
                    VerticalGap.small(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          (5 * theme.screenMargin),
                      child: Text(
                        comment.text,
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF272727),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            VerticalGap.medium(),
          ],
        ),
      ],
    );
  }
}
