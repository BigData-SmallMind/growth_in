import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:growth_in_api/growth_in_api.dart';

class MeetingsApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;
  static const _meetingTypeJsonKey = 'meeting_type';
  static const _slotsJsonKey = 'slots';
  static const _daysJsonKey = 'days';
  static const _latestUpcomingMeetingJsonKey = 'latestUpcomingMeeting';

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
      final latestUpcomingMeetingJson =
          response.data[_latestUpcomingMeetingJsonKey];
      final latestUpcomingMeeting = latestUpcomingMeetingJson == null ||
              (latestUpcomingMeetingJson is List &&
                  latestUpcomingMeetingJson.isEmpty)
          ? null
          : MeetingRM.fromJson(latestUpcomingMeetingJson);
      final meetingsRM = MeetingsRM.fromJson(meetings).copyWith(
        latest: latestUpcomingMeeting,
      );
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

  Future<List<String>> getAvailableSlotsInADay({required int date}) async {
    final url = _urlBuilder.buildGetAvailableSlotsUrl();
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'day': date},
      );
      final availableSlots = response.data[_slotsJsonKey] as List;
      return availableSlots.map((slot) => slot.toString()).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future updateMeetingDate({
    required int id,
    required String date,
  }) async {
    final url = _urlBuilder.buildUpdateMeetingDateUrl(
      id: id,
    );
    try {
      await _dio.post(
        url,
        data: {'meeting_date': date},
      );
    } catch (_) {
      rethrow;
    }
  }

  Future createMeeting({
    required String title,
    required MeetingTypeRM type,
    String? description,
    required String startDate,
    List<File>? files,
  }) async {
    final url = _urlBuilder.buildCreateMeetingUrl(
      title: title,
      startDate: startDate,
      description: description,
    );
    final now = DateTime.now().toIso8601String();
    List<MultipartFile> multipartFiles = [];
    if (files != null) {
      for (var file in files) {
        final fileExtension = file.path.split('.').last;
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: 'MEETING_FILES_$now.$fileExtension',
        );
        multipartFiles.add(multipartFile);
      }
    }
    final requestJsonBody = {
      if (files != null) 'files[]': multipartFiles,
      'meeting_type[name]': type.name,
      'meeting_type[color]': type.color,
    };
    final formData = FormData.fromMap(requestJsonBody);

    try {
      final response = await _dio.post(
        url,
        data: formData,
      );
      debugPrint('response: $response');
    } catch (_) {
      rethrow;
    }
  }

  Future<List<MeetingSlotRM>> getAvailableSlotsInAMonth({
    required int timestamp,
  }) async {
    final url = _urlBuilder.buildGetGetAvailableMeetingSlotsUrl();
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'timestamp': timestamp},
      );
      final slots = response.data[_daysJsonKey] as List;
      final slotsRM =
          slots.map((slot) => MeetingSlotRM.fromJson(slot)).toList();
      return slotsRM;
    } catch (_) {
      rethrow;
    }
  }
}
