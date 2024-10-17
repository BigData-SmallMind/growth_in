import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:request_repository/src/mappers/remote_to_domain.dart';
import 'package:request_repository/src/request_change_notifier.dart';

class RequestRepository {
  RequestRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  }) : changeNotifier = RequestChangeNotifier();

  final GrowthInApi remoteApi;
  final RequestChangeNotifier changeNotifier;

  Future<List<Project>> getProjects() async {
    try {
      final projects = await remoteApi.requests.getProjects();
      final domainProjects = projects.toDomainModel();
      return domainProjects;
    } catch (error) {
      rethrow;
    }
  }

  Future<RequestListPage> getRequests({
    required int pageNumber,
    FilterBy? filterBy,
  }) async {
    try {
      final requests = await remoteApi.requests.getRequests(
        pageNumber: pageNumber,
        searchText: filterBy?.searchText,
        status: filterBy?.requestStatus?.nameAr,
        projectIds: filterBy?.projects?.map((project) => project.id).toList(),
      );

      final domainRequests = requests.toDomainModel();
      return domainRequests;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Comment>> getActionComments(int actionId) async {
    try {
      final comments = await remoteApi.requests.getComments(null, actionId);
      final domainComments = comments.toDomainModel();
      // update action comments inside the request
      final request = changeNotifier.request;
      if (request != null) {
        final updatedRequest = request.copyWith(
          actions: request.actions
              .map(
                (action) => action.id == actionId
                    ? action.copyWith(comments: domainComments)
                    : action,
              )
              .toList(),
        );
        changeNotifier.setRequest(updatedRequest);
      }

      return domainComments;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Comment>> getRequestComments(int requestId) async {
    try {
      final comments = await remoteApi.requests.getComments(requestId, null);
      final domainComments = comments.toDomainModel();
      // update action comments inside the request
      final request = changeNotifier.request;
      if (request != null) {
        final updatedRequest = request.copyWith(
          comments: domainComments,
        );
        changeNotifier.setRequest(updatedRequest);
      }

      return domainComments;
    } catch (error) {
      rethrow;
    }
  }

  Future<Request> getRequest(int id) async {
    try {
      final request = await remoteApi.requests.getRequest(id);
      final requestHasActions =
          request.actions != null && request.actions!.isNotEmpty;
      final comments = requestHasActions
          ? await remoteApi.requests.getComments(id, null)
          : null;
      final domainComments = comments?.toDomainModel() ?? [];
      final domainRequest = request.toDomainModel(domainComments);
      changeNotifier.setRequest(domainRequest);
      return domainRequest;
    } catch (error) {
      rethrow;
    }
  }

  Future toggleRequestComplete(
    bool isComplete,
    int requestId,
  ) async {
    try {
      await remoteApi.requests.toggleRequestComplete(
        isComplete,
        requestId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future toggleActionStepsComplete(
    bool isComplete,
    int actionId,
  ) async {
    try {
      await remoteApi.requests.toggleActionStepsComplete(
        isComplete,
        actionId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future toggleSingleActionStepComplete(
    bool isComplete,
    int actionId,
    int actionStepId,
  ) async {
    try {
      await remoteApi.requests.toggleSingleActionStepComplete(
        isComplete,
        actionId,
        actionStepId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future addComment({
    required int? actionId,
    required int? requestId,
    required String comment,
  }) async {
    try {
      await remoteApi.requests.addComment(
        actionId: actionId,
        requestId: requestId,
        text: comment,
      );
    } catch (error) {
      rethrow;
    }
  }
}
