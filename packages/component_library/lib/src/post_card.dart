import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  final Post post;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final borderColor = post.status == PostStatus.newPost
        ? theme.newPostColor
        : post.status == PostStatus.accepted
            ? theme.acceptedPostColor
            : post.status == PostStatus.editing
                ? theme.editingPostColor
                : theme.borderColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: BorderDirectional(
            top: BorderSide(color: theme.borderColor),
            bottom: BorderSide(color: theme.borderColor),
            end: BorderSide(color: theme.borderColor),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.medium,
            horizontal: Spacing.medium,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(color: borderColor, width: 10),
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[1],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (post.channels?.isNotEmpty == true) ...[
                          Text(
                            post.channels!.first.name,
                            style: textTheme.titleMedium,
                          ),
                        ],
                        if (post.text != null) ...[
                          HorizontalGap.small(),
                          Expanded(
                            child: Text(
                              post.text!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium,
                            ),
                          )
                        ]
                      ],
                    ),
                    VerticalGap.small(),
                    Row(
                      children: [
                        const SvgAsset(AssetPathConstants.clockPath),
                        HorizontalGap.small(),
                        // hour and minute
                        Text(
                          post.hour,
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF464646),
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (post.images?.isNotEmpty == true) ...[
                // const Spacer(),
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(
                        5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        post.images!.first,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (post.shouldShowRedDot)
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: theme.errorColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
