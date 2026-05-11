import 'dart:convert';
import 'package:di360_flutter/configuration/app_config.dart';
import 'package:dio/dio.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HttpService {
  static String _url = AppConfig.hasuraBaseUrl;
  static String dioUrl = AppConfig.serverBaseUrl;
  static String frontendUrl = AppConfig.frontendPath;
  //https://qa-api.dentalinterface360.com/api/v1/file-upload/upload-s3
  HasuraConnect _hasuraConnect = HasuraConnect(_url, headers: {});
  static BaseOptions _options = new BaseOptions(
    baseUrl: dioUrl,
    responseType: ResponseType.json,
    connectTimeout: Duration(seconds: 20),
    receiveTimeout: Duration(seconds: 30),
  );
  Dio _dio = new Dio(_options);
  setToken(token) {
    _hasuraConnect.headers?["Authorization"] = "Bearer $token";
  }

  Future query(document, {variables, showLoading = true}) async {
    var response;
    try {
      response = (await _hasuraConnect.query(document,
          variables: variables ?? {}))['data'];
      print(response);
    } catch (e, s) {
      print("$e , $s");
      print("hasura error $e");
      final err = showHasuraError(e);
      return {"_error": err};
    }
    return response;
  }

  String _getContentType(String filePath) {
    final ext = filePath.toLowerCase().split('.').last;
    final mimeTypes = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'mp4': 'video/mp4',
      'mov': 'video/quicktime',
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'txt': 'text/plain',
    };
    return mimeTypes[ext] ?? 'application/octet-stream';
  }

  Future<dynamic> uploadImage(String? filePath) async {
    if (filePath == null || filePath.isEmpty) {
      print("Upload failed: File path is null or empty");
      return null;
    }

    try {
      MultipartFile _uploadImage = await MultipartFile.fromFile(
        filePath,
        contentType: DioMediaType.parse(_getContentType(filePath)),
      );
      var _data = {"file": _uploadImage, "directory": 'project'};
      return await post(
          '/api/v1/file-upload/upload-s3', FormData.fromMap(_data));
    } catch (e) {
      print("Upload image error: $e");
      return null;
    }
  }

  Future post(url, _data, {showLoading = true}) async {
    try {
      final result = await _dio.post(
        url,
        data: _data,
      );
      if (result.statusCode == 201 || result.statusCode == 200) {
        return Map<String, dynamic>.from(result.data);
      }
      print("Upload failed with status code: ${result.statusCode}");
      return null;
    } catch (e, s) {
      print("Post request error: $e, $s");
      return null;
    }
  }

  Future<dynamic> downloadFile(String url, Map<String, dynamic> data) async {
    try {
      final result = await _dio.post(
        url,
        data: data,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.bytes,
        ),
      );
      if (result.statusCode == 200 || result.statusCode == 201) {
        return result.data as List<int>;
      }
      print("downloadFile failed with status: ${result.statusCode}");
      return null;
    } catch (e, s) {
      print("downloadFile error: $e, $s");
      return null;
    }
  }

  Future<dynamic> get(url) async {
    try {
      final result = await _dio.get(url);
      if (result.statusCode == 201 || result.statusCode == 200) {
        return Map<String, dynamic>.from(result.data);
      }
      print("Get request failed with status code: ${result.statusCode}");
      return null;
    } catch (e, s) {
      print("Post request error: $e, $s");
      return null;
    }
  }

  Future<Map<String, dynamic>> mutation(document, variables,
      {showLoading = true}) async {
    var response;
    try {
      response =
          await _hasuraConnect.mutation(document, variables: variables ?? {});
      response = response['data'];
    } catch (e, s) {
      print("$e , $s");
      if (e is HasuraRequestError) {
        return {"_error": e.message, "_errorType": "hasura"};
      }
      final err = showHasuraError(e);
      return {"_error": err};
    }
    return response ?? {};
  }

  showHasuraError(e) {
    String errorMessage = "Unknown error";
    try {
      if (e is DioException) {
        errorMessage = e.message ?? "Network error";
      } else if (e is Map && e.containsKey('errors')) {
        // hasura_connect may return a map-like error
        final errors = e['errors'];
        if (errors is List && errors.isNotEmpty) {
          errorMessage = errors.first.toString();
        } else {
          errorMessage = e.toString();
        }
      } else {
        errorMessage = e.toString();
      }
    } catch (_) {
      errorMessage = e.toString();
    }

    // return parsed message for callers to handle
    return errorMessage;
  }

  Future subscription(document, {variables, showLoading = true}) async {
    var responses;
    try {
      final response = await _hasuraConnect.subscription(document,
          variables: variables ?? {});
      responses = response;
      print(responses);
    } catch (e, s) {
      print("$e , $s");
    }
    return responses;
  }

  dispose() {
    _hasuraConnect.disconnect();
  }
}
