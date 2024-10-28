import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class CmsApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;
  static const _postsJsonKey = 'posts';
  static const _campaignsJsonKey = 'campaigns';

  CmsApi(
    this._dio,
    this._urlBuilder,
  );

  Future<List<PostRM>> getPosts() async {
    final url = _urlBuilder.buildGetPostsUrl();
    try {
      final response = await _dio.get(
        url,
      );
      final posts = response.data[_postsJsonKey] as List;
      final postsList = posts.map((post) => PostRM.fromJson(post)).toList();
      return postsList;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CampaignRM>> getCampaigns({
    required int companyId,
  }) async {
    final url = _urlBuilder.buildGetCampaignsUrl(
      companyId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final campaigns = response.data[_campaignsJsonKey] as List;
      final campaignsList =
          campaigns.map((campaign) => CampaignRM.fromJson(campaign)).toList();
      return campaignsList;
    } catch (_) {
      rethrow;
    }

    // Future<List<CommentRM>> getPostComments({
    //   required int fileId,
    // }) async {
    //   final url = _urlBuilder.buildGetPostCommentsUrl(
    //     fileId,
    //   );
    //   try {
    //     final response = await _dio.get(
    //       url,
    //     );
    //     final comments = response.data[_commentsJsonKey] as List;
    //     final commentsList =
    //         comments.map((comment) => CommentRM.fromJson(comment)).toList();
    //     return commentsList;
    //   } catch (_) {
    //     rethrow;
    //   }
    // }
    //
    // void addComment({
    //   required int fileId,
    //   required String comment,
    // }) {
    //   final url = _urlBuilder.buildAddPostCommentUrl(
    //     fileId,
    //   );
    //   try {
    //     _dio.post(
    //       url,
    //       data: {
    //         'comment': comment,
    //       },
    //     );
    //   } catch (_) {
    //     rethrow;
    //   }
    // }
  }
}
