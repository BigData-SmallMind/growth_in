import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_version_details/post_version_details.dart';
import 'package:post_version_details/src/post_version_details_cubit.dart';

class PostVersionDetailsBottomSheet extends StatefulWidget {
  const PostVersionDetailsBottomSheet({
    super.key,
    required this.cmsRepository,
  });

  final CmsRepository cmsRepository;

  @override
  State<PostVersionDetailsBottomSheet> createState() =>
      _PostVersionDetailsBottomSheetState();
}

class _PostVersionDetailsBottomSheetState
    extends State<PostVersionDetailsBottomSheet>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<PostVersionDetailsCubit>(
      create: (_) => PostVersionDetailsCubit(
        cmsRepository: widget.cmsRepository,
      ),
      child: const PostVersionDetailsView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostVersionDetailsView extends StatelessWidget {
  const PostVersionDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostVersionDetailsCubit, PostVersionDetailsState>(
      listenWhen: (previous, current) =>
          previous.approvalStatus != current.approvalStatus,
      listener: (context, state) {
        final l10n = PostVersionDetailsLocalizations.of(context);
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
        final loading = state.postVersionFetchingStatus ==
            PostVersionDetailsFetchingStatus.inProgress;
        final error = state.postVersionFetchingStatus ==
            PostVersionDetailsFetchingStatus.failure;
        final cubit = context.read<PostVersionDetailsCubit>();
        final theme = GrowthInTheme.of(context);
        final l10n = PostVersionDetailsLocalizations.of(context);
        return BottomSheet(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          onClosing: () {},
          builder: (context) {
            return loading
                ? const CenteredCircularProgressIndicator()
                : error
                    ? ExceptionIndicator(
                        onTryAgain: cubit.getPostVersionDetails,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          PostVersionTile(
                            postVersion: state.postVersion!,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                if (state.post!.images?.isNotEmpty == true) ...[
                                  PostImages(post: state.post!)
                                ],
                                if (state.post!.text != null) ...[
                                  PostSummary(post: state.post!),
                                ],
                                VerticalGap.medium(),
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
                                    onTap: cubit.approvePostVersion,
                                    asset: const SvgAsset(
                                      AssetPathConstants.verifyFilePath,
                                    ),
                                    title: l10n.approvePostBottomSheetTitle,
                                    body: l10n.approvePostBottomSheetBody,
                                    buttonColor: theme.secondaryColor,
                                    buttonLabel:
                                        l10n.approvePostBottomSheetButtonLabel,
                                    cancelButtonLabel:
                                        l10n.cancelPostBottomSheetButtonLabel,
                                  ),
                                ),
                                bgColor: theme.secondaryColor,
                              ),
                            ),
                        ],
                      );
          },
        );
      },
    );
  }
}
