import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();

  CommentViewModel() {
    getUserId();
  }

  String? adminId;
  String? supplierId;
  String? practiceId;
  String? professionId;
  String? userID;

  TextEditingController commentController = TextEditingController();
  final FocusNode replyFocusNode = FocusNode();

  bool isReply = false;
  String? commentId;
  String? commenterName;
  bool replyCommentUpdate = false;
  bool commentUpdate = false;
  bool removeReplyFeild = false;
  String? hintText;

  @override
  void dispose() {
    replyFocusNode.dispose();
    super.dispose();
  }

  void updateHintText(String? hinttext,{bool? removeReplyVal}) {
    hintText = hinttext;
    removeReplyFeild = removeReplyVal ?? false;
    notifyListeners();
  }

  void updateIsReply(bool value, String commentsId, String commenteName,
      {bool? isedit, bool? commentupdate}) {
    isReply = value;
    commentId = commentsId;
    commenterName = commenteName;
    replyCommentUpdate = isedit ?? false;
    commentUpdate = commentupdate ?? false;
    notifyListeners();
  }

  addCommentTheFeed(BuildContext context, String feedId) async {
    await getUserId();
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    final img = await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(commentQuery, {
        "addCommentsData": {
          "dental_practice_id": practiceId ?? null,
          "dental_professional_id": professionId ?? null,
          "commenter_name": name,
          "comment_Pro_Img": img,
          "comments": commentController.text,
          "comments_attachments": [],
          "dental_admin_id": adminId ?? null,
          "dental_supplier_id": supplierId ?? null,
          "news_feeds_id": feedId
        }
      });

      if (res != null) {
        commentController.clear();
        getNewsfeedComment(context, feedId);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  updateTheComment(BuildContext context, String feedId) async {
    await getUserId();
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(updateCommentQuery, {
        "id": commentId,
        "data": {"comments": commentController.text, "comments_attachments": []}
      });

      if (res != null) {
        commentController.clear();
        getNewsfeedComment(context, feedId);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  deleteTheComment(BuildContext context, String id, String feedId) async {
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(deleteCommentQuery, {"id": id});

      if (res != null) {
        commentController.clear();
        getNewsfeedComment(context, feedId);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  Future<void> getNewsfeedComment(BuildContext context, String feedId) async {
    try {
      var res = await _http.query(getNewsfeedQuery, variables: {'id': feedId});
      if (res != null) {
        final newsFeed = res['newsfeeds'].first['news_feeds_comments'];
        final commentCount = res['newsfeeds'].first['news_feeds_comments_aggregate']
            ['aggregate']['count'];
        updateTheCommentObject(context, feedId, newsFeed, commentCount);
      }
      Loaders.circularHideLoader(context);
    } catch (e) {
      scaffoldMessenger(e.toString());
      Loaders.circularHideLoader(context);
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

  Future<void> updateTheCommentObject(BuildContext context, String feedId,
      List<dynamic>? newsFeeds, dynamic count) async {
    final homeVM =
        context.read<HomeViewModel>();
    final feed = homeVM.allNewsFeedsData?.newsfeeds?.firstWhere((v) => v.id == feedId);
    feed?.newsFeedsComments?.clear();
    feed?.newsFeedsComments =
        newsFeeds?.map((e) => NewsFeedsComments.fromJson(e)).toList();
    feed?.newsFeedsCommentsAggregate?.aggregate?.count = count;
    updateIsReply(false, '', '', isedit: false, commentupdate: false);
    homeVM.notifyListeners();
    notifyListeners();
  }

  replyCommentTheFeed(BuildContext context, String feedId) async {
    await getUserId();
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(replyCommentQuery, {
        "addReplyData": {
          "dental_practice_id": practiceId ?? null,
          "dental_professional_id": professionId ?? null,
          "dental_supplier_id": supplierId ?? null,
          "news_feeds_id": feedId,
          "reply_text": "@$commenterName ${commentController.text}",
          "dental_admin_id": adminId ?? null,
          "comment_id": commentId,
          "reply_id": commentId,
          "liked_count": 0,
          "reply_attachments": []
        }
      });

      if (res != null) {
        commentController.clear();
        getNewsfeedComment(context, feedId);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  updateTheReplyCommentTheFeed(BuildContext context, String feedId) async {
    await getUserId();
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(updateReplyCommentQuery, {
        "id": commentId,
        "data": {
          "reply_text": "@$commenterName ${commentController.text}",
          "reply_attachments": []
        }
      });

      if (res != null) {
        commentController.clear();
        getNewsfeedComment(context, feedId);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  deleteTheReplyComment(BuildContext context, String id, String feedId) async {
    await getUserId();
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(deleteReplyCommentQuery, {"id": id});

      if (res != null) {
        commentController.clear();
        getNewsfeedComment(context, feedId);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }
}

const String deleteCommentQuery = '''
mutation DeleteNewsfeedComments(\$id: uuid!) {
  delete_news_feeds_comments_by_pk(id: \$id) {
    id
    __typename
  }
  delete_news_feeds_comments_replys(where: {comment_id: {_eq: \$id}}) {
    affected_rows
    __typename
  }
}
''';

const String updateCommentQuery = '''
mutation UpdateNewsfeedComments(\$id: uuid!, \$data: news_feeds_comments_set_input!) {
  update_news_feeds_comments_by_pk(pk_columns: {id: \$id}, _set: \$data) {
    id
    __typename
  }
}
''';

const String updateReplyCommentQuery = '''
mutation updateNewsfeedReply(\$id: uuid!, \$data: news_feeds_comments_replys_set_input!) {
  update_news_feeds_comments_replys_by_pk(pk_columns: {id: \$id}, _set: \$data) {
    id
    __typename
  }
}
''';

const String deleteReplyCommentQuery = '''
mutation deleteNewsfeedReply(\$id: uuid!) {
  delete_news_feeds_comments_replys_by_pk(id: \$id) {
    id
    __typename
  }
  delete_news_feeds_comments_replys(where: {reply_id: {_eq: \$id}}) {
    affected_rows
    __typename
  }
}
''';

final String commentQuery = '''
    mutation addNewsFeedComment(\$addCommentsData: news_feeds_comments_insert_input!) {
      insert_news_feeds_comments_one(object: \$addCommentsData) {
        id
        comments
        created_at
        dental_admin_id
    comment_Pro_Img
    commenter_name
    comments_attachments
    comment_reply {
      id
    }
    dental_practice_id
    dental_professional_id
    dental_supplier_id
    dental_supplier {
      name
    }
    dental_practice {
      name
    }
    dental_professional {
      name
    }
    admin_user {
      name
    }
    __typename
      }
    }
  ''';

const String replyCommentQuery = '''
  mutation addNewsFeedCommentsReplys(\$addReplyData: news_feeds_comments_replys_insert_input!) {
  insert_news_feeds_comments_replys_one(object: \$addReplyData) {
    id
    admin_user {
      id
      name
      email
      profile_image
      __typename
    }
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
    comment_id
    reply_text
    news_feeds_id
    dental_supplier_id
    dental_professional_id
    dental_practice_id
    dental_admin_id
    liked_count
    reply_id
    reply_attachments
    __typename
  }
}
  ''';

const String getNewsfeedQuery = '''
   query getAllNewsfeeds(\$id: uuid!) {
  newsfeeds(where: {id: {_eq: \$id}}) {
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
          id
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
        id
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
