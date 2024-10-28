import 'package:cms_repository/src/cms_change_notifier.dart';
import 'package:cms_repository/src/mappers/remote_to_domain.dart';
import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

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
      return null;
      // final domainCampaigns = remoteCampaigns.toDomainModel();
      // return domainCampaigns;
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

// Future<List<Comment>> getPostComments({
//   required int fileId,
// }) async {
//   try {
//     final comments = await remoteApi.cmsApi.getFileComments(
//       fileId: fileId,
//     );
//
//     final domainComments = comments.map((e) => e.toDomainModel()).toList();
//     return domainComments;
//   } catch (error) {
//     rethrow;
//   }
// }
//
// Future addComment({
//   required int fileId,
//   required String comment,
// }) async {
//   try {
//     remoteApi.cmsApi.addComment(
//       fileId: fileId,
//       comment: comment,
//     );
//   } catch (error) {
//     rethrow;
//   }
// }
}
