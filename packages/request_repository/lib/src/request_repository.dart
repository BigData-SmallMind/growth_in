import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:request_repository/src/mappers/remote_to_domain.dart';
import 'package:request_repository/src/request_change_notifier.dart';
import 'package:request_repository/src/request_local_storage.dart';

class RequestRepository {
  RequestRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  })  : changeNotifier = RequestChangeNotifier(),
        _localStorage = RequestLocalStorage(noSqlStorage: noSqlStorage);

  final GrowthInApi remoteApi;
  final RequestLocalStorage _localStorage;
  final RequestChangeNotifier changeNotifier;

  Future<List<Request>> getRequests() async {
    try {
      final requests = await remoteApi.getRequests();

      final domainRequests = requests.toDomainModel();
      return domainRequests;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Comment>> getActionComments(int actionId) async {
    try {
      final comments = await remoteApi.getComments(null, actionId);
      final domainComments = comments.toDomainModel();
      return domainComments;
    } catch (error) {
      rethrow;
    }
  }

  Future<Request> getRequest(int id) async {
    try {
      final request = await remoteApi.getRequest(id);
      final requestHasActions =
          request.actions != null && request.actions!.isNotEmpty;
      final comments =
          requestHasActions ? await remoteApi.getComments(id, null) : null;
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
      await remoteApi.toggleRequestComplete(
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
      await remoteApi.toggleActionStepsComplete(
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
      await remoteApi.toggleSingleActionStepComplete(
        isComplete,
        actionId,
        actionStepId,
      );

    } catch (error) {
      rethrow;
    }
  }
}
