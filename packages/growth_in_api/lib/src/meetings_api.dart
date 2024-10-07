import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class MeetingsApi {

  final Dio _dio;
  final UrlBuilder _urlBuilder;

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
}
