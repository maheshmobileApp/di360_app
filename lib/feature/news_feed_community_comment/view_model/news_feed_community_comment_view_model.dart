import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed_comment/model_class/news_feed_comments_res.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/queries/news_feed_community_comment_reply.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/query/add_news_feed_comment_query.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/repository/news_feed_community_comment_repo.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/repository/news_feed_community_comment_repo_impl.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class NewsFeedCommunityCommentViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final NewsFeedCommunityCommentRepo repo = NewsFeedCommunityCommentRepoImpl();

  NewsFeedCommunityCommentViewModel() {
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
  String? commenterName;
  bool replyCommentUpdate = false;
  bool commentUpdate = false;
  bool removeReplyFeild = false;
  String? hintText;
  List<PlatformFile> selectedFiles = [];
  List<CommentsAttachments> existingAttachments = [];
  Map<String, bool> expandedReplies = {};
  NewsFeedCommentData? newsFeedReplies;
  Map<String, List<NewsFeedsComments>> repliesDataCache = {};

  String? replyToId; // used in insert API
  String? refreshParentId; // used in getReplies()
  String? selectedCommentId;

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

  void updateIsReply(
    bool value,
    String replyToCommentId,
    String commenterName, {
    String? refreshId,
    bool? isedit,
    bool? commentupdate,
  }) {
    isReply = value;
    selectedCommentId = replyToCommentId;

    replyToId = replyToCommentId;

    refreshParentId = refreshId ?? replyToCommentId;

    this.commenterName = commenterName;

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
    print("*****************addCommentfee");
    await getUserId();
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    try {
      // Upload files first
      final uploadedFiles = await _getUploadedFiles();

      var res = await _http.mutation(addNewsFeedCommentQuery, {
        "object": {
          "comment_text": commentController.text,
          "news_feeds_id": feedId,
          "parent_comment_id": null,
          "created_by_id": userId,
          "role_type": userType,
          "attachments": uploadedFiles,
          if (UserRole.practice.value == userType)
            "dental_practice_id": practiceId,
          if (UserRole.professional.value == userType)
            "dental_professional_id": professionId,
          if (UserRole.admin.value == userType) "dental_admin_id": adminId,
          if (UserRole.supplier.value == userType)
            "dental_supplier_id": supplierId,
        }
      });

      if (res.isNotEmpty) {
        resetCommentState();
        await getNewsfeedComment(context, feedId);
        final comment = newsFeedComments?.newsFeedsComments
            ?.cast<NewsFeedsComments?>()
            .firstWhere(
              (e) => e?.id == replyToId,
              orElse: () => null,
            );

        if (comment != null) {
          comment.repliesAggregate?.aggregate?.count =
              (comment.repliesAggregate?.aggregate?.count ?? 0) + 1;
        }
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error adding comment: $e");
    }

    notifyListeners();
  }

  updateTheComment(BuildContext context, String feedId) async {
    await getUserId();
    Loaders.circularShowLoader(context);
    try {
      final uploadedFiles = await _getUploadedFiles();
      final existingAsMap = existingAttachments
          .map((a) =>
              {"url": a.url, "name": a.name, "type": a.type, "size": a.size})
          .toList();
      final allAttachments = [...existingAsMap, ...uploadedFiles];
      final variables = {
        "id": selectedCommentId,
        "_set": {
          "comment_text": commentController.text,
          "attachments": allAttachments
        }
      };
      var res = await _http.mutation(updateCommentQuery, variables);

      if (res.isNotEmpty) {
        resetCommentState();
        await getNewsfeedComment(context, feedId);
        resetCommentState();
        Loaders.circularHideLoader(context);
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

  NewsFeedCommentData? newsFeedComments;
  Future<void> getNewsfeedComment(BuildContext context, String feedId) async {
    Loaders.circularShowLoader(context);
    final variables = {"feedId": feedId, "limit": 10, "offset": 0};
    try {
      var res = await repo.getComments(variables);
      newsFeedComments = res;
    } catch (e) {
      print("Error fetching comments: $e");
      scaffoldMessenger(e.toString());
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  /*Future<void> getNewsfeedComment(BuildContext context, String feedId) async {
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
  }*/

  getUserId() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    userID = userId;
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == UserRole.professional.value) {
      professionId = userId;
    } else if (type == UserRole.admin.value) {
      adminId = userId;
    } else if (type == UserRole.supplier.value) {
      supplierId = userId;
    } else if (type == UserRole.practice.value) {
      practiceId = userId;
    }
    notifyListeners();
  }

  Future<void> updateTheCommentObject(BuildContext context, String feedId,
      List<dynamic>? newsFeeds, dynamic count) async {
    final homeVM = context.read<NewsFeedCommunityViewModel>();
    final feed = homeVM.newsFeedCommunityData?.newsfeeds
        ?.firstWhere((v) => v.id == feedId);
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
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);

    Loaders.circularShowLoader(context);
    try {
      final uploadedFiles = await _getUploadedFiles();
      final variables = {
        "object": {
          "comment_text": commentController.text,
          "news_feeds_id": feedId,
          "parent_comment_id": replyToId,
          "created_by_id": userId,
          "role_type": userType,
          "attachments": uploadedFiles,
          if (UserRole.practice.value == userType)
            "dental_practice_id": practiceId,
          if (UserRole.professional.value == userType)
            "dental_professional_id": professionId,
          if (UserRole.admin.value == userType) "dental_admin_id": adminId,
          if (UserRole.supplier.value == userType)
            "dental_supplier_id": supplierId,
        }
      };
      var res =
          await _http.mutation(replyCommunityNewsFeedCommentQuery, variables);

      print("**************$variables");

      if (res.isNotEmpty) {
        final parentId = refreshParentId!;

        resetCommentState();

        repliesDataCache.remove(parentId);

        await loadReplies(
          context,
          parentId,
          forceRefresh: true,
        );

        Loaders.circularHideLoader(context);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e, s) {
      Loaders.circularHideLoader(context);

      print(e);
      print(s);
    }

    notifyListeners();
  }

  
  updateTheReplyCommentTheFeed(BuildContext context, String feedId) async {
    await getUserId();
    Loaders.circularShowLoader(context);
    try {
      final uploadedFiles = await _getUploadedFiles();
      final variables = {
        "id": selectedCommentId,
        "_set": {
          "comment_text": commentController.text,
          "attachments": uploadedFiles
        }
      };
      /*{
    "id": "4af71a66-11e5-453b-91c4-f73a4669f899",
    "_set": {
        "comment_text": "hi update",
        "attachments": null
    }
} */
      print("********ReplyComment Update ****$variables");
      var res = await _http.mutation(updateReplyCommentQuery, variables);

      if (res.isNotEmpty) {
        final parentId = refreshParentId!;

        resetCommentState();

        await getNewsfeedComment(context, feedId);

        await loadReplies(
          context,
          parentId,
          forceRefresh: true,
        );
        Loaders.circularHideLoader(context);
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      print("Error removing like: $e");
    }

    notifyListeners();
  }

  void EditReplyComment(NewsFeedsComments? comments) {
    FocusScope.of(navigatorKey.currentContext!).requestFocus(replyFocusNode);
    final comment = comments?.commentText ?? '';
    commentController.text = comment;
    setEditAttachments(comments?.commentsAttachments);
    selectedCommentId = comments?.id;

    updateIsReply(false, comments?.id ?? '', '', isedit: true, refreshId : comments?.parentCommentId);
  }

  Future<void> deleteTheReplyComment(
    BuildContext context,
    String id,
    String feedId,
    String parentCommentId,
  ) async {
    Loaders.circularShowLoader(context);
    var res = await _http.mutation(deleteReplyCommentQuery, {"id": id});

    if (res.isNotEmpty) {
      commentController.clear();
      repliesDataCache.remove(id);
      expandedReplies.remove(id);

      repliesDataCache.remove(parentCommentId);

      await loadReplies(
        context,
        parentCommentId,
        forceRefresh: true,
      );
      repliesDataCache.remove(parentCommentId);

      await loadReplies(
        context,
        parentCommentId,
        forceRefresh: true,
      );
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
  }

  void toggleReplyExpansion(String commentId) {
    expandedReplies[commentId] = !(expandedReplies[commentId] ?? false);
    notifyListeners();
  }

  Future<void> handleReplyExpansion(
    BuildContext context,
    String commentId,
  ) async {
    final isExpanded = expandedReplies[commentId] ?? false;

    if (isExpanded) {
      expandedReplies[commentId] = false;
      notifyListeners();
      return;
    }

    if (!repliesDataCache.containsKey(commentId)) {
      await loadReplies(context, commentId);
    }

    expandedReplies[commentId] = true;
    notifyListeners();
  }

  Future<void> loadReplies(
    BuildContext context,
    String parentId, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && repliesDataCache.containsKey(parentId)) {
      expandedReplies[parentId] = true;
      notifyListeners();
      return;
    }

    final res = await repo.getReplies({
      "parentId": parentId,
      "limit": 10,
      "offset": 0,
    });

    repliesDataCache[parentId] = res.newsFeedsComments ?? [];

    expandedReplies[parentId] = true;

    notifyListeners();
  }

  void collapseReplies(String id) {
    expandedReplies[id] = false;

    notifyListeners();
  }

  Future<void> toggleReplies(
    BuildContext context,
    String id,
  ) async {
    if (expandedReplies[id] ?? false) {
      collapseReplies(id);
    } else {
      await loadReplies(context, id);
    }
  }

  void resetCommentState() {
    isReply = false;
    replyToId = null;
    refreshParentId = null;
    selectedCommentId = null;

    commentUpdate = false;
    replyCommentUpdate = false;

    commentController.clear();
    selectedFiles.clear();
    existingAttachments.clear();

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

const String updateCommentQuery = r'''
mutation EditComment($id: uuid!, $_set: news_feeds_comments_set_input!) {
  update_news_feeds_comments_by_pk(pk_columns: {id: $id}, _set: $_set) {
    id
    comment_text
    __typename
  }
}
''';

const String updateReplyCommentQuery = r'''
mutation EditComment($id: uuid!, $_set: news_feeds_comments_set_input!) {
  update_news_feeds_comments_by_pk(pk_columns: {id: $id}, _set: $_set) {
    id
    comment_text
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
