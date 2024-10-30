import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_versions/src/post_versions_cubit.dart';

class PostVersionDetailsScreen extends StatefulWidget {
  const PostVersionDetailsScreen({
    super.key,
    required this.cmsRepository,
    required this.onPostVersionTapped,
    required this.postId,
  });

  final CmsRepository cmsRepository;
  final VoidCallback onPostVersionTapped;
  final int postId;

  @override
  State<PostVersionDetailsScreen> createState() =>
      _PostVersionDetailsScreenState();
}

class _PostVersionDetailsScreenState extends State<PostVersionDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<PostVersionDetailsCubit>(
      create: (_) => PostVersionDetailsCubit(
        cmsRepository: widget.cmsRepository,
        onPostVersionTapped: widget.onPostVersionTapped,
        postId: widget.postId,
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
    return BlocBuilder<PostVersionDetailsCubit, PostVersionDetailsState>(
      builder: (context, state) {
        final loading = state.postVersionsFetchingStatus ==
            PostVersionDetailsFetchingStatus.inProgress;
        final error = state.postVersionsFetchingStatus ==
            PostVersionDetailsFetchingStatus.failure;
        final cubit = context.read<PostVersionDetailsCubit>();
        final textTheme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: const GrowthInAppBar(
            title: SizedBox(),
            logoVariation: false,
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: cubit.getPostVersions,
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        final postVersion = state.postVersions![index];
                        return PostVersionTile(
                          postVersion: postVersion,
                          onTapped: ()=>cubit.onPostVersionTap(postVersion),
                        );
                      },
                      itemCount: state.postVersions!.length,
                    ),
        );
      },
    );
  }
}
