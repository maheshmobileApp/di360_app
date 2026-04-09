import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';

class ShareUtils {
  static String getShareUrl(String feedId) {
    return '${HttpService.dioUrl}/api/v1/prelogin/$feedId';
  }

  static String getShareUrlDeepling(String feedId, String category) {
    final feedType = FeedType.fromString(category);
    String path;

    switch (feedType) {
      case FeedType.newsfeed:
        path = 'newsfeed';
        break;
      case FeedType.catalogue:
        path = 'catalogue';
        break;
      case FeedType.learnhub:
        path = 'learnhub';
        break;
      case FeedType.jobs:
        path = 'jobs';
        break;
      case FeedType.profile:
        path = 'profile';
        break;
      case FeedType.directory:
        path = 'directory';
        break;
      case FeedType.talents:
        path = 'talents';
        break;
      case FeedType.banners:
        path = 'banners';
        break;
      case FeedType.campaign:
        path = 'campaign';
        break;
      case FeedType.joinCommunity:
        path = 'join-community';
        break;
      default:
        path = category.toLowerCase();
    }

    return '${HttpService.frontendUrl}/deeplink/$path/$feedId';
  }
}

// /*
//           "/newsfeed/*",
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
