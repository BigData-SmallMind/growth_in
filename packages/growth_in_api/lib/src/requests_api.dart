import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:growth_in_api/growth_in_api.dart';

class RequestsApi {
  static const _messageJsonKey = 'message';
  static const _statusJsonKey = 'status';
  static const _projectsJsonKey = 'projects';
  static const _taskJsonKey = 'task';
  static const _commentsJsonKey = 'comments';
  final Dio _dio;
  final UrlBuilder _urlBuilder;

  RequestsApi(
    this._dio,
    this._urlBuilder,
  );

  Future<RequestListPageRM> getRequests({
    required int pageNumber,
    String? searchText,
    String? status,
    List<int>? projectIds,
  }) async {
    final url = _urlBuilder.buildGetRequestsUrl(
      page: pageNumber,
      searchText: searchText,
      status: status,
      projectIds: projectIds,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final requests = response.data;
      final requestsList = RequestListPageRM.fromJson(requests);
      return requestsList;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ProjectRM>> getProjects() async {
    final url = _urlBuilder.buildGetProjectsUrl();
    final response = await _dio.get(
      url,
    );
    try {
      final projectsJson = response.data[_projectsJsonKey] as List;
      final projects = projectsJson.map((project) {
        return ProjectRM.fromJson(project);
      }).toList();
      return projects;
    } catch (_) {
      rethrow;
    }
  }

  Future<RequestRM> getRequest(int requestId) async {
    final url = _urlBuilder.buildGetRequestUrl(requestId);
    final response = await _dio.get(
      url,
    );
    try {
      final jsonObject = response.data[_taskJsonKey];
      final request = RequestRM.fromJson(jsonObject);
      return request;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CommentRM>> getComments(
    int? requestId,
    int? actionId,
  ) async {
    final url = _urlBuilder.buildGetRequestCommentsUrl(
      requestId,
      actionId,
    );
    final response = await _dio.get(
      url,
    );
    try {
      final status404 = response.data[_statusJsonKey] == 404;
      final emptyComments = status404 &&
          response.data[_messageJsonKey].contains('لا توجد تعليقات حتي الان');
      if (emptyComments) return [];
      final comments = response.data[_commentsJsonKey] as List;
      final commentsList =
          comments.map((comment) => CommentRM.fromJson(comment)).toList();
      return commentsList;
    } catch (_) {
      rethrow;
    }
  }

  Future toggleRequestComplete(
    bool isComplete,
    int requestId,
  ) async {
    final url =
        _urlBuilder.buildToggleRequestCompleteUrl(isComplete, requestId);

    try {
      final response = await _dio.post(
        url,
      );
      debugPrint(response.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future toggleActionStepsComplete(
    bool isComplete,
    int actionId,
  ) async {
    final url = _urlBuilder.buildToggleActionStepsCompleteUrl(
      isComplete,
      actionId,
    );

    try {
      final response = await _dio.post(
        url,
      );
      debugPrint(response.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future toggleSingleActionStepComplete(
    bool isComplete,
    int actionId,
    int actionStepId,
  ) async {
    final url = _urlBuilder.buildToggleSingleActionStepCompleteUrl(
      isComplete,
      actionId,
      actionStepId,
    );

    try {
      final response = await _dio.post(
        url,
      );
      debugPrint(response.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future addComment({
    int? requestId,
    int? actionId,
    required String text,
  }) async {
    final url = _urlBuilder.buildAddCommentUrl(
      actionId,
    );
    try {
      final response = await _dio.post(
        url,
        data: {
          'comment': text,
          if (requestId != null) 'task_id': requestId,
        },
      );
      debugPrint(response.toString());
    } catch (_) {
      rethrow;
    }
  }
}
