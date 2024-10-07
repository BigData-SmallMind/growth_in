import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:meeting_repository/src/mappers/mappers.dart';
import 'package:meeting_repository/src/meeting_change_notifier.dart';
import 'package:meeting_repository/src/meeting_local_storage.dart';

class MeetingRepository {
  MeetingRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  })  : changeNotifier = MeetingChangeNotifier(),
        _localStorage = MeetingLocalStorage(noSqlStorage: noSqlStorage);

  final GrowthInApi remoteApi;
  final MeetingLocalStorage _localStorage;
  final MeetingChangeNotifier changeNotifier;

  Future<Meetings> getMeetings() async {
    try {
      final meetingsRM = await remoteApi.meetings.getMeetings();

      final domainMeetings = meetingsRM.toDomainModel();
      return domainMeetings;
    } catch (error) {
      rethrow;
    }
  }
}
