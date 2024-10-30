import 'package:carousel_slider/carousel_slider.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class PostImages extends StatefulWidget {
  const PostImages({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostImages> createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  int currentIndicatorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalGap.large(),
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (currentImageIndex, reason) {
                    currentIndicatorIndex = currentImageIndex;
                    setState(() {});
                  }),
              items: widget.post.images!.map(
                (image) {
                  return GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: InteractiveViewer(
                          child: Image.network(
                            image,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    child: Image.network(
                      image,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ).toList(),
            ),
            Positioned(
              top: Spacing.large,
              left: Spacing.large,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.small,
                  vertical: Spacing.xSmall,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${currentIndicatorIndex + 1}/${widget.post.images!.length}',
                ),
              ),
            )
          ],
        ),
        VerticalGap.medium(),
        Center(
          child: SizedBox(
            height: 5,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                      width: currentIndicatorIndex == index ? 25 : 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        color: index == currentIndicatorIndex
                            ? colorScheme.primary
                            : const Color(0xFFD8D8D8),
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: Spacing.xSmall,
                    ),
                itemCount: widget.post.images!.length),
          ),
        ),
      ],
    );
  }
}
