import 'package:dio/dio.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HttpService {
  static String _url = 'https://dental-360-dev.hasura.app/v1/graphql';
  static String dioUrl = "https://api.dentalinterface.com/";
  HasuraConnect _hasuraConnect = HasuraConnect(_url, headers: {});
  static BaseOptions _options = new BaseOptions(
    baseUrl: dioUrl,
    responseType: ResponseType.json,
    connectTimeout: Duration(milliseconds: 4000),
    receiveTimeout: Duration(milliseconds: 6000),
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
      showHasuraError(e);
    }
    return response;
  }

  Future<dynamic> uploadImage(filePath) async {
    MultipartFile _uploadImage = await MultipartFile.fromFile(filePath);
    var _data = {
      "file": _uploadImage,
      "directory": 'project'
    };
    return await post('api/v1/file-upload/upload-s3', FormData.fromMap(_data));
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

      return null;
    } catch (e, s) {
      print("$e, $s");
      //_showError(e);
      return e;
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
      showHasuraError(e);
    }
    return response;
  }

  showHasuraError(e) {
    if (e.message.toString().contains("http")) {
      // _utils.showErrorSnackBar(
      //     msg:
      //         "We regret the inconvience, something is wrong at our end. please try again after sometime.",
      //     title: "Server Error");
    } else if (e.message.toString().contains("SocketException")) {
      // _utils.showErrorSnackBar(
      //     msg:
      //         'Seems to be slow internet connection, Please connect to a different source for better experience',
      //     title: "Slow Internet");
    } else {
      //  _utils.showToast(e.message ?? "Server error");
    }
  }

  Future subscription(document,
      {variables, showLoading = true}) async {
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
  _showError(DioError e) {
    if (e.message!.contains('SocketException') &&
        e.message!.contains('Network is unreachable')) {
      // _utils.showErrorSnackBar(
      //     msg:
      //         'Something is wrong from our end, Please try again after sometime',
      //     title: "Server Unavailable");
      return;
    } else if (e.type == DioErrorType.receiveTimeout) {
      // _utils.showErrorSnackBar(
      //     title: "Seems to be Slow Internet",
      //     msg: "Please connect to Internet for better experience");
      // return;
    }
    if (e.response?.data == null) {
      // _utils.showErrorSnackBar(
      //     title: "Server error", msg: e.message.toString());
    } else {
      // _utils.showAlertNotification(e.response?.data['message'].toString());
    }
  }

  dispose() {
    _hasuraConnect.disconnect();
  }
}
