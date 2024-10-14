import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:meeting_repository/src/mappers/domain_to_remote.dart';
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

  Future<List<MeetingType>> getMeetingTypes() async {
    try {
      final meetingTypes = await remoteApi.meetings.getMeetingTypes();
      final domainMeetingTypes = meetingTypes.toDomainModel();
      return domainMeetingTypes;
    } catch (error) {
      rethrow;
    }
  }

  Future deleteMeeting({
    required int id,
    required String reason,
  }) async {
    try {
      await remoteApi.meetings.deleteMeeting(
        id: id,
        reason: reason,
      );
      changeNotifier.setShouldReFetchMeetings(true);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<MeetingSlot>> getAvailableSlots({
    required DateTime date,
  }) async {
    try {
      final availableSlotsDM = await remoteApi.meetings.getAvailableSlots(
        date: date.millisecondsSinceEpoch,
      );
      final availableSlots = availableSlotsDM.toDomainModel();

      return availableSlots;
    } catch (error) {
      rethrow;
    }
  }

  Future updateMeetingDate({
    required int id,
    required MeetingSlot meetingSlot,
    required DateTime selectedDay,
  }) async {
    try {
      await remoteApi.meetings.updateMeetingDate(
        id: id,
        date: meetingSlot.toRemoteModel(selectedDay),
      );
      final updatedMeeting = changeNotifier.meeting?.copyWith(
        startDate: meetingSlot.start.copyWith(
          year: selectedDay.year,
          month: selectedDay.month,
          day: selectedDay.day,
        ),
      );
      changeNotifier.setMeeting(updatedMeeting);
      changeNotifier.setShouldReFetchMeetings(true);
    } catch (error) {
      rethrow;
    }
  }
}
