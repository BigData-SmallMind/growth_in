import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_details/src/post_details_cubit.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({
    super.key,
    required this.cmsRepository,
    required this.onLogout,
  });

  final CmsRepository cmsRepository;
  final VoidCallback onLogout;

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
        onLogout: widget.onLogout,
      ),
      child: const PostDetailsView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        final cubit = context.read<PostDetailsCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PngAsset(
                  'post_details.png',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
