import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_like_res.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/news_feed/model_class/get_news_feed_categories.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeedViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  NewsFeedViewModel() {
    getUserId();
    getFilterCategories();
  }

  List<NewsfeedCategories>? newsfeedCategories;

  String? adminId;
  String? supplierId;
  String? practiceId;
  String? professionId;
  String? userID;

  bool applyCatageories = false;

  void updateApplyCatageories(bool val) {
    applyCatageories = val;
    notifyListeners();
  }

  removeNewsFeedLike(BuildContext context, String feedId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    updateTheNewsFeedLikeCount(context, feedId, false);
    removeTheLikeObject(context, feedId);
    try {
      var res = await _http.mutation(removeNewsFeedLikeMutation, {
        "userId": userId,
        "feedId": feedId,
      });

      if (res != null) {
        // updateTheNewsFeedLikeCount(context, feedId, false);
        // removeTheLikeObject(context, feedId);
      }
    } catch (e) {
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  addNewsFeedLike(BuildContext context, String newsFeedId) async {
    updateTheNewsFeedLikeCount(context, newsFeedId, true);
    updateTheLikeObject(context, newsFeedId);
    try {
      var res = await _http.mutation(addNewsFeedLikeMutation, {
        "addLikes": {
          "dental_practice_id": practiceId ?? null,
          "dental_professional_id": professionId ?? null,
          "dental_admin_id": adminId ?? null,
          "dental_supplier_id": supplierId ?? null,
          "news_feeds_id": newsFeedId
        }
      });

      if (res != null) {
        // updateTheNewsFeedLikeCount(context, newsFeedId, true);
        // updateTheLikeObject(context, newsFeedId);
      }
    } catch (e) {
      print("Error adding like: $e");
    }

    notifyListeners();
  }

  Future updateTheNewsFeedLikeCount(
      BuildContext context, String feedId, bool isIncrement) async {
    final newsFeedList = context.read<HomeViewModel>().allNewsFeedsData;
    final post = newsFeedList?.newsfeeds?.firstWhere((v) => v.id == feedId);
    post?.newsfeedsLikesAggregate?.aggregate?.count = isIncrement
        ? post.newsfeedsLikesAggregate!.aggregate!.count! + 1
        : post.newsfeedsLikesAggregate!.aggregate!.count! - 1;
    notifyListeners();
  }

  Future<void> updateTheLikeObject(BuildContext context, String feedId) async {
    final newsFeedList =
        context.read<HomeViewModel>().allNewsFeedsData?.newsfeeds;
    final feed = newsFeedList?.firstWhere((v) => v.id == feedId);
    final newLike = await insertNewsFeedLikeObj();
    feed?.newsfeedsLikes?.insert(0, newLike);
    notifyListeners();
  }

  Future<NewsfeedsLikes> insertNewsFeedLikeObj() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);

    if (type == 'PROFESSIONAL') {
      return NewsfeedsLikes(
        dentalAdminId: null,
        adminUser: null,
        dentalPractice: null,
        dentalSupplier: null,
        dentalProfessional: NewsFeedLikeProfessional(
            id: userId, profileImage: null, type: type),
      );
    } else if (type == 'ADMIN') {
      return NewsfeedsLikes(
        adminUser: NewsLikeAdminUser(id: userId),
        dentalAdminId: null,
        dentalPractice: null,
        dentalProfessional: null,
        dentalSupplier: null,
      );
    } else if (type == 'SUPPLIER') {
      return NewsfeedsLikes(
        dentalAdminId: null,
        adminUser: null,
        dentalPractice: null,
        dentalSupplier:
            NewsFeedLikeSupplier(id: userId, logo: null, type: type),
        dentalProfessional: null,
      );
    } else if (type == 'PRACTICE') {
      return NewsfeedsLikes(
        dentalAdminId: null,
        adminUser: null,
        dentalPractice:
            NewsFeedLikePractice(id: userId, logo: null, type: type),
        dentalSupplier: null,
        dentalProfessional: null,
      );
    }

    // Default fallback
    throw Exception("Invalid user type");
  }

  Future<void> removeTheLikeObject(BuildContext context, String feedId) async {
    final newsFeedList =
        context.read<HomeViewModel>().allNewsFeedsData?.newsfeeds;
    final feed = newsFeedList?.firstWhere((v) => v.id == feedId);
    feed?.newsfeedsLikes?.removeWhere((v) =>
        v.dentalProfessional?.id == userID ||
        v.dentalSupplier?.id == userID ||
        v.dentalAdminId == userID ||
        v.dentalPractice?.id == userID);
    notifyListeners();
  }

  Future<void> getFilterCategories() async {
    const String query = '''
    query getAllNewsfeedCategories {
      newsfeed_categories(order_by: {created_at: desc}) {
        id
        category_name
        created_at
        updated_at
        created_by
        created_by_user_id
        __typename
      }
    }
  ''';

    try {
      final response = await _http.query(query);
      if (response != null) {
        final res = CategoriesData.fromJson(response);
        newsfeedCategories = res.newsfeedCategories;
        newsfeedCategories?.insert(
            0,
            NewsfeedCategories(
              id: '',
              categoryName: 'Catalog',
            ));
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
    notifyListeners();
  }

  Future<void> basedOnCategoriesGetFeeds(
      BuildContext context, bool isCatalog, String id) async {
    Loaders.circularShowLoader(context);
    try {
      final response = isCatalog
          ? await _http
              .query(getNewsFeedsByCatalog, variables: {"status": "PUBLISHED"})
          : await _http.query(getNewsFeedsByCategories,
              variables: {"status": "PUBLISHED", "category_type": id});
      if (response != null) {
        final result = AllNewsFeedData.fromJson(response);
        context.read<HomeViewModel>().allNewsFeedsData = result;
        updateApplyCatageories(true);
        Loaders.circularHideLoader(context);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error fetching categories: $e");
    }
    notifyListeners();
  }

  getUserId() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    userID = userId;
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == 'PROFESSIONAL') {
      professionId = userId;
    } else if (type == 'ADMIN') {
      adminId = userId;
    } else if (type == 'SUPPLIER') {
      supplierId = userId;
    } else if (type == 'PRACTICE') {
      practiceId = userId;
    }
    notifyListeners();
  }

  deleteTheNewsFeed(BuildContext context, String feedId) async {
    try {
      Loaders.circularShowLoader(context);
      var res = await _http.mutation(deleteTheNewsFeedQuery, {"id": feedId});
      if (res != null) {
        removeTheNewsFeedObject(context, feedId);
        Loaders.circularHideLoader(context);
        scaffoldMessenger('Newsfeed deleted successfully');
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  Future<void> removeTheNewsFeedObject(
      BuildContext context, String feedId) async {
    final homeVM = context.read<HomeViewModel>();
    homeVM.allNewsFeedsData?.newsfeeds?.removeWhere((v) => v.id == feedId);
    homeVM.notifyListeners();
    notifyListeners();
  }

}
const String editTheFeedQuery = r'''
mutation UpdateNewsfeed($id: uuid!, $data: newsfeeds_set_input!) {
  update_newsfeeds_by_pk(pk_columns: {id: $id}, _set: $data) {
   id
    created_at
    post_image
    description
    category_type
    attachments
    feed_type
    payload
    post_image
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
    newsfeeds_likes {
      dental_admin_id
      admin_user {
        id
        name
        __typename
      }
      dental_practice {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_supplier {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_professional {
        id
        name
        profession_type
        type
        profile_image
        __typename
      }
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
        __typename
      }
      dental_practice_id
      dental_professional_id
      dental_supplier_id
      dental_supplier {
        name
        logo
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

const String deleteTheNewsFeedQuery = r'''
mutation DeleteNewsfeed($id: uuid!) {
  delete_newsfeeds_by_pk(id: $id) {
    id
    __typename
  }
  delete_comments_replies: delete_news_feeds_comments_replys(
    where: {news_feeds_id: {_eq: $id}}
  ) {
    affected_rows
    __typename
  }
}
''';

const String addNewsFeedLikeMutation = r'''
mutation addNewsFeedLikes($addLikes: newsfeeds_likes_insert_input!) {
  insert_newsfeeds_likes_one(object: $addLikes) {
    id
    __typename
  }
}
''';

const String removeNewsFeedLikeMutation = r'''
mutation removeNewsfeedLikes($userId: uuid, $feedId: uuid) {
  delete_newsfeeds_likes(
    where: {
      _or: [
        { dental_supplier_id: { _eq: $userId } },
        { dental_practice_id: { _eq: $userId } },
        { dental_professional_id: { _eq: $userId } },
        { dental_admin_id: { _eq: $userId } }
      ],
      news_feeds_id: { _eq: $feedId }
    }
  ) {
    affected_rows
  }
}
''';

const String getNewsFeedsByCategories = r'''
query getAllNewsfeeds($status: String!, $category_type: String!) {
  newsfeeds(
    where: {
      _and: [
        { category_type: { _eq: $category_type } }
        { status: { _eq: $status } }
      ]
    }
    order_by: { updated_at: desc }
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
    newsfeeds_likes {
      dental_admin_id
      admin_user {
        id
        name
        __typename
      }
      dental_practice {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_supplier {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_professional {
        id
        name
        profession_type
        type
        profile_image
        __typename
      }
      __typename
    }
    newsfeeds_likes_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
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
          directories {
            id
            __typename
          }
          __typename
        }
        dental_practice {
          name
          logo
          directories {
            id
            __typename
          }
          __typename
        }
        dental_professional {
          name
          profile_image
          directories {
            id
            __typename
          }
          __typename
        }
        admin_user {
          name
          profile_image
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
        directories {
          id
          __typename
        }
        __typename
      }
      dental_practice {
        name
        logo
        directories {
          id
          __typename
        }
        __typename
      }
      dental_professional {
        name
        profile_image
        directories {
          id
          __typename
        }
        __typename
      }
      admin_user {
        name
        profile_image
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

const String getNewsFeedsByCatalog = r'''
query getAllNewsfeedsCatalog($status: String!) {
  newsfeeds(
    where: {
      _and: [
        { feed_type: { _eq: "CATALOGUE" } }
        { status: { _eq: $status } }
      ]
    }
    order_by: { updated_at: desc }
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
    newsfeeds_likes {
      dental_admin_id
      admin_user {
        id
        name
        __typename
      }
      dental_practice {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_supplier {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_professional {
        id
        name
        profession_type
        type
        profile_image
        __typename
      }
      __typename
    }
    newsfeeds_likes_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
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
          directories {
            id
            __typename
          }
          __typename
        }
        dental_practice {
          name
          logo
          directories {
            id
            __typename
          }
          __typename
        }
        dental_professional {
          name
          profile_image
          directories {
            id
            __typename
          }
          __typename
        }
        admin_user {
          name
          profile_image
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
        directories {
          id
          __typename
        }
        __typename
      }
      dental_practice {
        name
        logo
        directories {
          id
          __typename
        }
        __typename
      }
      dental_professional {
        name
        profile_image
        directories {
          id
          __typename
        }
        __typename
      }
      admin_user {
        name
        profile_image
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
