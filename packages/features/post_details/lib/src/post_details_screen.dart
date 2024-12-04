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
    required this.onPostVersionDetailsTapped,
  });

  final CmsRepository cmsRepository;
  final VoidCallback onCommentsTapped;
  final VoidCallback onPostVersionDetailsTapped;

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
        onPostVersionDetailsTapped: widget.onPostVersionDetailsTapped,
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
    final cubit = context.read<PostDetailsCubit>();
    return BlocConsumer<PostDetailsCubit, PostDetailsState>(
      listenWhen: (previous, current) =>
          previous.approvalStatus != current.approvalStatus,
      listener: (context, state) {
        if (state.approvalStatus == ApprovalStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SuccessSnackBar(
              context: context,
              message: l10n.postApprovalSuccessSnackBarMessage,
            ),
          );
          Navigator.pop(context);
        } else if (state.approvalStatus == ApprovalStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(context: context),
          );
          Navigator.pop(context);
        }
      },
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
                  onPressed: cubit.onCommentsTapped,
                  // onPressed: () {},
                  icon: const SvgAsset(
                    AssetPathConstants.commentsButtonPath,
                  ),
                ),
                IconButton(
                  onPressed: cubit.onPostVersionDetailsTapped,
                  icon: const SvgAsset(
                    AssetPathConstants.clockButtonPath,
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
                                (channel) => Row(
                                  children: [
                                    Text(
                                      channel.name.length > 4
                                          ? channel.name.substring(0, 4)
                                          : channel.name,
                                    ),
                                    HorizontalGap.small(),
                                  ],
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
                              if (state.post?.contentType is List)
                                ...state.post!.contentType!.map(
                                  (contentTypeName) => Text(
                                    contentTypeName,
                                  ),
                                ),
                              if(state.post?.contentType is String)
                                Text(state.post!.contentType as String),
                            ],
                          ),
                        ],
                      ],
                    ),
                    if (state.post!.images?.isNotEmpty == true) ...[
                      PostImages(post: state.post!)
                    ],
                    if (state.post!.text != null) ...[
                      PostSummary(post: state.post!),
                    ],
                  ],
                ),
              ),
              if (!state.post!.isApproved)
                Padding(
                  padding: EdgeInsets.all(theme.screenMargin),
                  child: GrowthInElevatedButton(
                    label: l10n.approvePostButtonLabel,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      builder: (context) => VerificationBottomSheet(
                        onTap: () => cubit.approvePost(),
                        asset:
                            const SvgAsset(AssetPathConstants.verifyFilePath),
                        title: l10n.approvePostBottomSheetTitle,
                        body: l10n.approvePostBottomSheetBody,
                        buttonColor: theme.secondaryColor,
                        buttonLabel: l10n.approvePostBottomSheetButtonLabel,
                        cancelButtonLabel:
                            l10n.cancelPostBottomSheetButtonLabel,
                      ),
                    ),
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
