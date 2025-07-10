import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/model_class/get_followers_res.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();

  GetFollowersData? getFollowersData;
  AllNewsFeedData? allNewsFeedsData;
  String? userName;
  String? profilePic;
  String? userID;

  getFollowersCount(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    getUserDetails();
    try {
      var res =
          await _http.query(getFollowersQuery, variables: {'userId': userId});
      if (res != null) {
        Loaders.circularHideLoader(context);
        final result = GetFollowersData.fromJson(res);
        getFollowersData = result;
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> getAllNewsfeeds(BuildContext context) async {
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.query(getAllNewsfeedsQuery, variables: {
        'status': 'PUBLISHED',
      });
      if (res != null) {
        final result = AllNewsFeedData.fromJson(res);
        allNewsFeedsData = result;
        Loaders.circularHideLoader(context);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {}
    notifyListeners();
  }

  getUserDetails() async {
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    final img = await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    final user_id =
        await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    this.userName = name;
    this.profilePic = img;
    this.userID = user_id;
    notifyListeners();
  }
}

const String getFollowersQuery = r'''
query getFollowers($userId: uuid) {
  to_whome_i_am_following_aggregate: directory_followers_aggregate(
    where: {
      _or: [
        {dental_supplier_id: {_eq: $userId}},
        {dental_practice_id: {_eq: $userId}},
        {dental_professional_id: {_eq: $userId}},
        {dental_admin_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    aggregate {
      count
    }
  }

  to_whome_i_am_following: directory_followers(
    where: {
      _or: [
        {dental_supplier_id: {_eq: $userId}},
        {dental_practice_id: {_eq: $userId}},
        {dental_professional_id: {_eq: $userId}},
        {dental_admin_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    id
    following_status
    follower_dental_professional_id
    follower_dental_supplier_id
    follower_dental_practice_id
    follower_dental_professional {
      id
      name
      profile_image
      type
    }
    follower_dental_supplier {
      id
      name
      logo
      type
    }
    follower_dental_practice {
      id
      name
      logo
      type
    }
    dental_supplier { id name }
    dental_practice { id name }
    dental_professional { id name }
    dental_admin { id name }
  }

  who_is_following_aggregate: directory_followers_aggregate(
    where: {
      _or: [
        {follower_dental_supplier_id: {_eq: $userId}},
        {follower_dental_practice_id: {_eq: $userId}},
        {follower_dental_professional_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    aggregate {
      count
    }
  }

  who_is_following: directory_followers(
    where: {
      _or: [
        {follower_dental_supplier_id: {_eq: $userId}},
        {follower_dental_practice_id: {_eq: $userId}},
        {follower_dental_professional_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    id
    dental_admin_id
    dental_professional_id
    dental_practice_id
    dental_supplier_id
    following_status
    dental_supplier { id name }
    dental_practice { id name }
    dental_professional { id name }
    dental_admin { id name }
  }
}
''';

const String getAllNewsfeedsQuery = r'''
query getAllNewsfeeds($status: String!) {
  newsfeeds(
    where: {status: {_eq: $status}},
    order_by: {updated_at: desc}
  ) {
    id
    created_at
    post_image
    description
    category_type
    attachments
    feed_type
    payload
    user_role
    video_url
    web_url
    user_id
    status
    title
    dental_practice_id
    dental_professional_id
    dental_supplier_id
    dental_admin_id

    dental_supplier {
      id
      logo
      business_name
      profession_type
      email
      phone
      name
      type
      directories {
        id
        company_name
        logo
        description
        banner_image
      }
    }

    dental_professional {
      id
      name
      profession_type
      profile_image
      email
      phone
      type
    }

    dental_practice {
      id
      logo
      business_name
      profession_type
      email
      phone
      name
      type
      directories {
        company_name
        logo
        description
        banner_image
      }
    }

    admin_user {
      id
      phone
      email
    }

    newsfeeds_likes {
      dental_admin_id
      admin_user {
        id
        name
      }
      dental_practice {
        id
        name
        logo
        type
        profession_type
      }
      dental_supplier {
        id
        name
        logo
        type
        profession_type
      }
      dental_professional {
        id
        name
        profession_type
        type
        profile_image
      }
    }

    newsfeeds_likes_aggregate {
      aggregate {
        count
      }
    }

    news_feeds_comments {
      id
      comments
      created_at
      dental_admin_id
      comment_Pro_Img
      commenter_name
      comments_attachments

      comment_reply {
        id
        reply_text
        comment_id
        reply_id
        reply_attachments
        dental_admin_id
        dental_practice_id
        dental_professional_id
        dental_supplier_id

        dental_supplier {
          name
          logo
          directories { id }
        }

        dental_practice {
          name
          logo
          directories { id }
        }

        dental_professional {
          name
          profile_image
          directories { id }
        }

        admin_user {
          name
          profile_image
        }
      }

      dental_practice_id
      dental_professional_id
      dental_supplier_id

      dental_supplier {
        name
        logo
        directories { id }
      }

      dental_practice {
        name
        logo
        directories { id }
      }

      dental_professional {
        name
        profile_image
        directories { id }
      }

      admin_user {
        name
        profile_image
      }
    }

    news_feeds_comments_aggregate {
      aggregate {
        count
      }
    }
  }
}
''';
