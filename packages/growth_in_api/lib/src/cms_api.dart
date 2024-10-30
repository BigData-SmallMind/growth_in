import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class CmsApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;
  static const _postsJsonKey = 'posts';
  static const _postVersionsJsonKey = 'postVersions';
  static const _campaignsJsonKey = 'campaigns';
  static const _commentsJsonKey = 'comments';

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
  }

  Future approvePost({
    required int postId,
  }) async {
    final url = _urlBuilder.buildApprovePostUrl(
      postId,
    );
    try {
      await _dio.post(
        url,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<PostVersionRM>> getPostVersions({
    required int postId,
  }) async {
    final url = _urlBuilder.buildGetPostVersionsUrl(
      postId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final postVersions = response.data[_postVersionsJsonKey] as List;
      final postVersionsList = postVersions
          .map((postVersion) => PostVersionRM.fromJson(postVersion))
          .toList();
      return postVersionsList;
    } catch (_) {
      rethrow;
    }
  }

  Future<PostRM> getPostVersionDetails({
    required int versionId,
  }) async {
    final url = _urlBuilder.buildGetPostVersionDetailsUrl(
      versionId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final postVersionJson = response.data[_postsJsonKey];
      final postVersion = PostRM.fromJson(postVersionJson);
      return postVersion;
    } catch (_) {
      rethrow;
    }
  }

  Future approvePostVersion({
    required int versionId,
  }) async {
    final url = _urlBuilder.buildApprovePostVersionUrl(
      versionId,
    );
    try {
      await _dio.post(
        url,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CommentRM>> getPostComments({
    required int postId,
  }) async {
    final url = _urlBuilder.buildGetPostCommentsUrl(
      postId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final comments = response.data[_commentsJsonKey] as List;
      final commentsList =
          comments.map((comment) => CommentRM.fromJson(comment)).toList();
      return commentsList;
    } catch (_) {
      rethrow;
    }
  }

  Future addComment({
    required int postId,
    required String comment,
  }) async {
    final url = _urlBuilder.buildAddPostCommentUrl();
    try {
      await _dio.post(
        url,
        data: {
          'post_id': postId,
          'comment_text': comment,
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}
