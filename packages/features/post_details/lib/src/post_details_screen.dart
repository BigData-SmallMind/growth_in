import 'package:carousel_slider/carousel_slider.dart';
import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_details/src/l10n/post_details_localizations.dart';
import 'package:post_details/src/post_details_cubit.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({
    super.key,
    required this.cmsRepository,
    required this.onCommentsTapped,
  });

  final CmsRepository cmsRepository;
  final VoidCallback onCommentsTapped;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<PostDetailsCubit>(
      create: (_) => PostDetailsCubit(
        cmsRepository: widget.cmsRepository,
        onCommentsTapped: widget.onCommentsTapped,
      ),
      child: const PostDetailsView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({
    super.key,
  });

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  int currentIndicatorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = PostDetailsLocalizations.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(l10n.appBarTitle),
                ),
                const Spacer(),
                IconButton(
                  // onPressed: cubit.onCommentsTapped,
                  onPressed: () {},
                  icon: const SvgAsset(
                    AssetPathConstants.commentsButtonPath,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ExpansionTile(
                      leading: const SvgAsset(
                        AssetPathConstants.documentTextPath,
                        height: 20,
                        color: Color(0xFF595959),
                      ),
                      title: Text(
                        l10n.detailsExpansionTileTitle,
                        maxLines: 1,
                      ),
                      shape: const RoundedRectangleBorder(),
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                l10n.postPublicationDateRowTitle,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: const Color(0xFF797979)),
                                maxLines: 1,
                              ),
                            ),
                            HorizontalGap.medium(),
                            Text(state.post!.publicationDate
                                .toIso8601String()
                                .split('T')
                                .first),
                          ],
                        ),
                        if (state.post!.channels?.isNotEmpty == true) ...[
                          VerticalGap.medium(),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  l10n.postSocialChannelsRowTitle,
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFF797979)),
                                  maxLines: 1,
                                ),
                              ),
                              HorizontalGap.medium(),
                              ...state.post!.channels!.map(
                                (channel) => Text(
                                  channel.name.length > 4
                                      ? channel.name.substring(0, 4)
                                      : channel.name,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (state.post!.contentType?.isNotEmpty == true) ...[
                          VerticalGap.medium(),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  l10n.postContentTypeRowTitle,
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFF797979)),
                                  maxLines: 1,
                                ),
                              ),
                              HorizontalGap.medium(),
                              ...state.post!.contentType!.map(
                                (contentTypeName) => Text(
                                  contentTypeName,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    if (state.post!.images?.isNotEmpty == true) ...[
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
                            items: state.post!.images!.map(
                              (image) {
                                return GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      child: InteractiveViewer(
                                        child: Image.network(
                                          image,
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                '${currentIndicatorIndex + 1}/${state.post!.images!.length}',
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
                                    width:
                                        currentIndicatorIndex == index ? 25 : 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      shape: BoxShape.rectangle,
                                      color: index == currentIndicatorIndex
                                          ? colorScheme.primary
                                          : const Color(0xFFD8D8D8),
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: Spacing.xSmall,
                                  ),
                              itemCount: state.post!.images!.length),
                        ),
                      )
                    ],
                    if (state.post!.text != null) ...[
                      VerticalGap.large(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.screenMargin,
                        ),
                        child: Text(
                          state.post!.text!,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(theme.screenMargin),
                child: GrowthInElevatedButton(
                  label: l10n.approvePostButtonLabel,
                  onTap: () {},
                  bgColor: theme.secondaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
