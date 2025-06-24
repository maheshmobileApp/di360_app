import 'dart:async';
import 'dart:io';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:dio/dio.dart';

final baseClient = BaseApiClient();

class BaseApiClient {
  late final Dio client = Dio(
    BaseOptions(baseUrl: ApiConst.baseUrl),
  );

  // BaseApiClient() {
  //   initialize();
  // }

  // Future<void> initialize() async {
  //   final isLogIn = await LocalStorage.getBoolValue(LocalStorageConst.isAuth);
  //   if (isLogIn) client.interceptors.add(CustomInterceptor());
  // }
  
  Future<dynamic> getCall(String endPoint) async {
    final url = '${ApiConst.baseUrl}$endPoint';
    final token = await LocalStorage.getStringVal(LocalStorageConst.token);
    var headersPayload = {
      'Authorization': 'Bearer $token',
      'Content-Type': ApiConst.contentType
    };
    try {
      var respone =
          await client.get(url, options: Options(headers: headersPayload));
      return respone.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> postCall(String endPoint, {dynamic payload}) async {
    final url = '${ApiConst.baseUrl}$endPoint';
    final token = await LocalStorage.getStringVal(LocalStorageConst.token);
    var headersPayload = {
      'Authorization': 'Bearer $token',
      'Content-Type': ApiConst.contentType
    };
    try {
      var respone = await client.post(url,
          options: Options(headers: headersPayload), data: payload);
      return respone.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> putCall(String endPoint, {dynamic payload}) async {
    final url = '${ApiConst.baseUrl}$endPoint';
    final token = await LocalStorage.getStringVal(LocalStorageConst.token);
    var headersPayload = {
      'Authorization': 'Bearer $token',
      'Content-Type': ApiConst.contentType
    };
    try {
      var respone = await client.put(url,
          options: Options(headers: headersPayload), data: payload);
      return respone.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteCall(String endPoint, {dynamic payload}) async {
    final url = '${ApiConst.baseUrl}$endPoint';
    final token = await LocalStorage.getStringVal(LocalStorageConst.token);
    var headersPayload = {
      'Authorization': 'Bearer $token',
      'Content-Type': ApiConst.contentType
    };
    try {
      var respone = await client.delete(url,
          options: Options(headers: headersPayload), data: payload);
      return respone.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> fileUpload(String api, File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
    var headersPayload = {'Content-Type': ApiConst.contentType};
    try {
      var request = await client.post(api,
          options: Options(headers: headersPayload), data: data);

      return request.data;
    } catch (e) {
      return e;
    }
  }
}
