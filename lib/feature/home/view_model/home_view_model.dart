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
  String? userType;

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
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final roleType = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    final variables = {
      "where": {
        "status": {"_eq": "PUBLISHED"},
        "community_id": {"_is_null": true},
        "_and": [
          {
            "_or": [
              {
                "feed_type": {"_neq": "CATALOGUE"}
              },
              {
                "feed_type": {"_eq": "CATALOGUE"},
                "catalogues": {
                  "schedulerDay": {"_lte": "2026-01-30T00:00:00.000Z"}
                }
              }
            ]
          }
        ]
      },
      "limit": 10,
      "offset": 0,
      "userId": userId,
      "roleType": roleType
    };
    try {
      var res = await _http.query(getAllNewsfeedsQuery, variables: variables);
      if (res != null) {
        final result = AllNewsFeedData.fromJson(res);
        print(
            '********************************************Newsfeeds Data: ${result.newsfeeds}');
        allNewsFeedsData = result;
        Loaders.circularHideLoader(context);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      allNewsFeedsData = null;
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  getUserDetails() async {
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    final img = await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final user_id =
        await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    this.userName = name;
    this.profilePic = img;
    this.userID = user_id;
    this.userType = type;
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

const String getAllNewsfeedsQuery =
    r'''query getAllNewsfeeds($where: newsfeeds_bool_exp!, $limit: Int, $offset: Int, $userId: uuid, $roleType: String) {
  newsfeeds(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    post_image
    community_id
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
        __typename
      }
      __typename
    }
    dental_professional {
      id
      name
      profession_type
      profile_image
      email
      phone
      type
      __typename
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
        __typename
      }
      __typename
    }
    admin_user {
      id
      phone
      email
      __typename
    }
    courses {
      id
      presenters
      address
      cpd_points
      type
      course_banner_image
      __typename
    }
    catalogues {
      id
      schedulerDay
      __typename
    }
    jobs {
      id
      banner_image
      j_role
      location
      TypeofEmployment
      __typename
    }
    newsfeeds_likes {
      id
      dental_admin_id
      admin_user {
        id
        name
        __typename
      }
      dental_practice {
        business_name
        directories {
          id
          __typename
        }
        __typename
      }
      dental_supplier {
        business_name
        directories {
          id
          __typename
        }
        __typename
      }
      dental_professional {
        name
        directories {
          id
          __typename
        }
        __typename
      }
      __typename
    }
    my_like: newsfeeds_likes(
      where: {role_type: {_eq: $roleType}, _or: [{dental_supplier_id: {_eq: $userId}}, {dental_practice_id: {_eq: $userId}}, {dental_professional_id: {_eq: $userId}}, {dental_admin_id: {_eq: $userId}}]}
    ) {
      id
      __typename
    }
    newsfeeds_likes_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    news_feeds_comments(order_by: {created_at: desc}) {
      id
      comments
      created_at
      updated_at
      dental_admin_id
      comment_Pro_Img
      commenter_name
      comments_attachments
      comment_reply {
        id
        reply_text
        comment_id
        created_at
        reply_id
        reply_attachments
        dental_admin_id
        dental_practice_id
        dental_professional_id
        dental_supplier_id
        dental_supplier {
          name
          logo
          business_name
          directories {
            id
            logo
            __typename
          }
          __typename
        }
        dental_practice {
          name
          logo
          business_name
          directories {
            id
            logo
            __typename
          }
          __typename
        }
        dental_professional {
          name
          profile_image
          directories {
            id
            profile_image
            __typename
          }
          __typename
        }
        admin_user {
          name
          profile_image
          __typename
        }
        newsfeeds {
          id
          __typename
        }
        jobs {
          id
          __typename
        }
        courses {
          id
          __typename
        }
        __typename
      }
      dental_practice_id
      dental_professional_id
      dental_supplier_id
      dental_supplier {
        name
        logo
        business_name
        directories {
          id
          logo
          __typename
        }
        __typename
      }
      dental_practice {
        name
        logo
        business_name
        directories {
          id
          logo
          __typename
        }
        __typename
      }
      dental_professional {
        name
        profile_image
        directories {
          id
          profile_image
          __typename
        }
        __typename
      }
      admin_user {
        name
        profile_image
        __typename
      }
      newsfeed {
        id
        __typename
      }
      jobs {
        id
        __typename
      }
      courses {
        id
        __typename
      }
      __typename
    }
    news_feeds_comments_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}
''';

/*r'''
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
''';*/
