import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class MeetingsApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;
  static const _meetingTypeJsonKey = 'meeting_types';

  MeetingsApi(
    this._dio,
    this._urlBuilder,
  );

  Future<MeetingsRM> getMeetings() async {
    final url = _urlBuilder.buildGetMeetingsUrl();
    try {
      final response = await _dio.get(
        url,
      );
      final meetings = response.data;
      final meetingsRM = MeetingsRM.fromJson(meetings);
      return meetingsRM;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<MeetingTypeRM>> getMeetingTypes() async {
    final url = _urlBuilder.buildGetMeetingTypesUrl();
    try {
      final response = await _dio.get(
        url,
      );
      final meetingTypes = response.data[_meetingTypeJsonKey] as List;
      final meetingTypesRM = meetingTypes
          .map((meetingType) => MeetingTypeRM.fromJson(meetingType))
          .toList();
      return meetingTypesRM;
    } catch (_) {
      rethrow;
    }
  }

  Future deleteMeeting({
    required int id,
    required String reason,
  }) async {
    final url = _urlBuilder.buildDeleteMeetingUrl(
      id: id,
      reason: reason,
    );
    try {
      await _dio.delete(
        url,
        data: {'reason': reason},
      );
    } catch (_) {
      rethrow;
    }
  }
}
