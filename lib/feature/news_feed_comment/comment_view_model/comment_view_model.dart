import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/model_class/news_feed_comments_res.dart';
import 'package:di360_flutter/feature/news_feed_comment/query/add_comment_query.dart';
import 'package:di360_flutter/feature/news_feed_comment/query/update_comment_query.dart';
import 'package:di360_flutter/feature/news_feed_comment/repository/news_feed_comment_repo_impl.dart';
import 'package:di360_flutter/feature/news_feed_comment/repository/news_feed_comment_repository.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentViewModel extends ChangeNotifier {
  final NewsFeedCommentRepository repo = NewsFeedCommentRepoImpl();
  final HttpService _http = HttpService();

  CommentViewModel() {
    getUserId();
  }

  String? adminId;
  String? supplierId;
  String? practiceId;
  String? professionId;
  String? userID;
  List<PlatformFile> selectedFiles = [];
  List<CommentsAttachments> existingAttachments = [];

  TextEditingController commentController = TextEditingController();
  final FocusNode replyFocusNode = FocusNode();

  bool isReply = false;
  String? commentId;
  String? commenterName;
  bool replyCommentUpdate = false;
  bool commentUpdate = false;
  bool removeReplyFeild = false;
  String? hintText;

  NewsFeedCommentData? newsFeedComments;
  NewsFeedCommentData? newsFeedReplies;
  Map<String, bool> expandedReplies = {};
  Map<String, List<NewsFeedsComments>> repliesDataCache = {};

  @override
  void dispose() {
    replyFocusNode.dispose();
    super.dispose();
  }

  void updateHintText(String? hinttext, {bool? removeReplyVal}) {
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

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null) {
        selectedFiles.addAll(result.files);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  void removeFile(int index) {
    if (index < selectedFiles.length) {
      selectedFiles.removeAt(index);
      notifyListeners();
    }
  }

  void setEditAttachments(List<CommentsAttachments>? attachments) {
    existingAttachments = List.from(attachments ?? []);
    selectedFiles.clear();
    notifyListeners();
  }

  void removeExistingAttachment(int index) {
    if (index < existingAttachments.length) {
      existingAttachments.removeAt(index);
      notifyListeners();
    }
  }

  Future<List<Map<String, dynamic>>> _uploadFiles() async {
    List<Map<String, dynamic>> uploadedFiles = [];

    for (var file in selectedFiles) {
      try {
        final response = await _http.uploadImage(file.path);
        if (response != null && response['url'] != null) {
          uploadedFiles.add({
            "url": response['url'],
            "name": file.name,
            "type": file.extension ?? "file",
            "size": file.size,
          });
        }
      } catch (e) {
        print('Error uploading file ${file.name}: $e');
      }
    }

    return uploadedFiles;
  }

  Future<List<Map<String, dynamic>>> _getUploadedFiles() async {
    if (selectedFiles.isNotEmpty) {
      return await _uploadFiles();
    }
    return [];
  }

  addCommentTheFeed(BuildContext context, String feedId) async {
    await getUserId();
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    try {
      final uploadedFiles = await _getUploadedFiles();
      final variables = {
        "object": {
          "comment_text": commentController.text,
          "news_feeds_id": feedId,
          "parent_comment_id": null,
          "created_by_id": userId,
          "role_type": userType,
          "attachments": uploadedFiles,
          "dental_supplier_id":
              UserRole.supplier.value == userType ? userId : null,
          "dental_practice_id":
              UserRole.practice.value == userType ? userId : null,
          "dental_professional_id":
              UserRole.professional.value == userType ? userId : null,
          "dental_admin_id": null
        }
      };
      var res = await _http.mutation(commentQuery, variables);

      if (res.isNotEmpty) {
        commentController.clear();
        selectedFiles.clear();
        getComments(context, feedId);
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
      final uploadedFiles = await _getUploadedFiles();
      final existing = existingAttachments
          .map((a) =>
              {"url": a.url, "name": a.name, "type": a.type, "size": a.size})
          .toList();
      final variables = {
        "id": commentId,
        "_set": {
          "comment_text": commentController.text,
          "attachments": [...existing, ...uploadedFiles]
        }
      };
      var res = await _http.mutation(updateCommentQuery, variables);

      if (res.isNotEmpty) {
        commentController.clear();
        existingAttachments.clear();
        await getComments(context, feedId);
        selectedFiles.clear();
        //await getNewsfeedComment(context, feedId);
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

      if (res.isNotEmpty) {
        commentController.clear();
        await getComments(context, feedId);
        await getNewsfeedComment(context, feedId);
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
        final commentCount = res['newsfeeds']
            .first['news_feeds_comments_aggregate']['aggregate']['count'];
        updateTheCommentObject(context, feedId, newsFeed, commentCount);
      }
      Loaders.circularHideLoader(context);
    } catch (e) {
      scaffoldMessenger(e.toString());
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getComments(BuildContext context, String feedId) async {
    Loaders.circularShowLoader(context);
    final variables = {"feedId": feedId, "limit": 10, "offset": 0};
    try {
      var res = await repo.getComments(variables);
      if (res != null) {
        newsFeedComments = res;
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger(e.toString());
    }
    notifyListeners();
  }

  Future<void> getReplies(BuildContext context, String parentId) async {
    final variables = {"parentId": parentId, "limit": 3, "offset": 0};
    try {
      var res = await repo.getReplies(variables);
      // ignore: unnecessary_null_comparison
      if (res != null) {
        newsFeedReplies = res;
        repliesDataCache[parentId] = res.newsFeedsComments ?? [];
      }
    } catch (e) {
      scaffoldMessenger(e.toString());
    }
    notifyListeners();
  }

  void toggleReplyExpansion(String commentId) {
    expandedReplies[commentId] = !(expandedReplies[commentId] ?? false);
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
    final newsFeedVM = context.read<NewsFeedViewModel>();
    final feed = newsFeedVM.allNewsFeedsData?.newsfeeds
        ?.firstWhere((v) => v.id == feedId);
    feed?.newsFeedsComments?.clear();
    feed?.newsFeedsComments =
        newsFeeds?.map((e) => NewsFeedsComments.fromJson(e)).toList();
    feed?.newsFeedsCommentsAggregate?.aggregate?.count = count;
    updateIsReply(false, '', '', isedit: false, commentupdate: false);
    newsFeedVM.notifyListeners();
    notifyListeners();
  }

  replyCommentTheFeed(
    BuildContext context,
    String feedId,
  ) async {
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final directParentId = commentId ?? '';
    await getUserId();
    Loaders.circularShowLoader(context);
    final variables = {
      "object": {
        "comment_text": commentController.text,
        "news_feeds_id": feedId,
        "parent_comment_id": directParentId,
        "created_by_id": userId,
        "role_type": userType,
        "attachments": null,
        "dental_supplier_id":
            UserRole.supplier.value == userType ? userId : null,
        "dental_practice_id":
            UserRole.practice.value == userType ? userId : null,
        "dental_professional_id":
            UserRole.professional.value == userType ? userId : null,
        "dental_admin_id": null
      }
    };
    try {
      var res = await _http.mutation(commentQuery, variables);

      if (res.isNotEmpty) {
        commentController.clear();
        await getNewsfeedComment(context, feedId);
        await getComments(context, feedId);
        await getReplies(context, directParentId);
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

      if (res.isNotEmpty) {
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

  deleteTheReplyComment(
      BuildContext context, String id, String feedId, String parentId) async {
    Loaders.circularShowLoader(context);
    try {
      var res = await _http.mutation(deleteReplyCommentQuery, {"id": id});

      if (res.isNotEmpty) {
        commentController.clear();
        getComments(context, feedId);
        getReplies(context, parentId);
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

const String deleteCommentQuery = r'''
mutation deleteRecord($id: uuid!) {
  delete_news_feeds_comments_by_pk(id: $id) {
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

const String deleteReplyCommentQuery = r'''
mutation deleteRecord($id: uuid!) {
  delete_news_feeds_comments_by_pk(id: $id) {
    id
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
