import 'package:di360_flutter/core/http_service.dart';

class ShareUtils {
  static String getShareUrl(String feedId) {
    return '${HttpService.dioUrl}/api/v1/prelogin/$feedId';
  }

    static String getShareUrlDeepling(String feedId,String category) {
    return '${HttpService.dioUrl}/deeplink/$category/$feedId';
  }
}

// /*

//   "/newsfeed/*",
//           "/catalogue/*",
//           "/learninghub/*",
//           "/profile/*",
//           "/directory/*",
//           "/jobs/*",
//           "/talents/*",
//           "/banners/*",
//           "/campaign/*",
//           "/join-community/*"
//           ///https://qabeta.dentalinterface360.com.au/deeplink/newsfeed/bcf81ec5-8f90-47a6-9226-aad851380745
//  */

