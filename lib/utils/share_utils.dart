import 'package:di360_flutter/core/http_service.dart';

class ShareUtils {
  static String getShareUrl(String feedId) {
    return '${HttpService.dioUrl}/api/v1/prelogin/$feedId';
  }
}
