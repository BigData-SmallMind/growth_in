import 'package:cms_repository/cms_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit({
    required this.cmsRepository,
    required this.onCommentsTapped,
  }) : super(
          PostDetailsState(
            post: cmsRepository.changeNotifier.post,
          ),
        );

  final CmsRepository cmsRepository;
  final VoidCallback onCommentsTapped;

// @override
// Future<void> close() {
//   return super.close();
// }
}
