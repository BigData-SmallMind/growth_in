import 'package:cms_repository/src/cms_change_notifier.dart';
import 'package:cms_repository/src/mappers/remote_to_domain.dart';
import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:request_repository/request_repository.dart';

class CmsRepository {
  CmsRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  }) : changeNotifier = CmsChangeNotifier();

  final GrowthInApi remoteApi;
  final CmsChangeNotifier changeNotifier;

  Future<List<Campaign>?> getCampaigns({
    required int companyId,
  }) async {
    try {
      final remoteCampaigns = await remoteApi.cmsApi.getCampaigns(
        companyId: companyId,
      );
      final domainCampaigns = remoteCampaigns.toDomainModel();
      return domainCampaigns;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Post>> getPosts() async {
    try {
      final remotePosts = await remoteApi.cmsApi.getPosts();
      final domainPosts = remotePosts.toDomainModel();
      return domainPosts;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<PostVersion>> getPostVersions({
    required int postId,
  }) async {
    try {
      final remotePostVersionDetails = await remoteApi.cmsApi.getPostVersions(
        postId: postId,
      );
      final domainPostVersionDetails = remotePostVersionDetails.toDomainModel();
      return domainPostVersionDetails;
    } catch (error) {
      rethrow;
    }
  }

  Future approvePost({
    required int postId,
  }) async {
    try {
      await remoteApi.cmsApi.approvePost(
        postId: postId,
      );
    } catch (error) {
      rethrow;
    }
  }
  Future approvePostVersion({
    required int versionId,
  }) async {
    try {
      await remoteApi.cmsApi.approvePostVersion(
        versionId: versionId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Comment>> getPostComments({
    required int postId,
  }) async {
    try {
      final comments = await remoteApi.cmsApi.getPostComments(
        postId: postId,
      );

      final domainComments = comments.map((e) => e.toDomainModel()).toList();
      return domainComments;
    } catch (error) {
      rethrow;
    }
  }

  Future addComment({
    required int postId,
    required String comment,
  }) async {
    try {
      await remoteApi.cmsApi.addComment(
        postId: postId,
        comment: comment,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<Post> getPostVersionDetails({
    required int versionId,
  }) async {
    try {
      final postVersion = await remoteApi.cmsApi.getPostVersionDetails(
        versionId: versionId,
      );
      return postVersion.toDomainModel();
    } catch (error) {
      rethrow;
    }
  }


}
