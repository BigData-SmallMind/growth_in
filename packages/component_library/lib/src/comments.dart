import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';


class Comments extends StatelessWidget {
  const Comments({
    super.key,
    required this.comments,
  });

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final comment = comments.first;
    final l10n = ComponentLibraryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        VerticalGap.medium(),
        const Divider(),
        VerticalGap.medium(),
        Row(
          children: [
            HorizontalGap.custom(theme.screenMargin),
            Text(l10n.commentsSectionTitle, style: textTheme.titleMedium),
            const Spacer(),
            TextButton(
              child: Text(
                l10n.viewAllCommentsButtonLabel,
                style: textTheme.bodySmall?.copyWith(
                  color: theme.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {},
            ),
            HorizontalGap.custom(theme.screenMargin),
          ],
        ),
        VerticalGap.medium(),
        Row(
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
                        Text(comment.author, style: textTheme.titleSmall,),
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
        ),
      ],
    );
  }
}
