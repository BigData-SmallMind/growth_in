import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class FormsApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;

  FormsApi(
    this._dio,
    this._urlBuilder,
  );

  Future<FormsRM> getForms() async {
    final url = _urlBuilder.buildGetFormsUrl();
    try {
      final response = await _dio.get(
        url,
      );
      final forms = response.data;
      final formsRM = FormsRM.fromJson(forms);
      return formsRM;
    } catch (_) {
      rethrow;
    }
  }

  Future<FormsSectionsRM> getFormSections(
    int formId,
  ) async {
    final url = _urlBuilder.buildGetFormSectionsUrl(formId);
    try {
      final response = await _dio.get(
        url,
      );
      final formSections = response.data;
      final formSectionsRM = FormsSectionsRM.fromJson(formSections);
      return formSectionsRM;
    } catch (_) {
      rethrow;
    }
  }
}
