import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/news_feed/model_class/get_news_feed_categories.dart';
import 'package:di360_flutter/feature/news_feed/querys/edit_feed_query.dart';
import 'package:di360_flutter/feature/news_feed/querys/get_all_news_feed_categories_query.dart';
import 'package:di360_flutter/feature/news_feed/querys/get_job_details_by_id.dart';
import 'package:di360_flutter/feature/news_feed/querys/news_feed_like_querys.dart';
import 'package:di360_flutter/feature/news_feed/repository/news_feed_repo_impl.dart';
import 'package:di360_flutter/feature/news_feed/repository/news_feed_repository.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_feed_count_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/admin_news_feed_enum.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class NewsFeedViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final NewsFeedRepository repo = NewsFeedRepoImpl();
  TextEditingController reportText = TextEditingController();
  NewsFeedViewModel() {
    _init();
    searchController.addListener(notifyListeners);
    scrollController.addListener(_scrollListener);
  }

  Future<void> _init() async {
    await getUserId();
    //await getFilterCategories();
  }

  List<NewsfeedCategories>? newsfeedCategories;

  String? selectedCategoryId;

  void updateSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }

  final TextEditingController searchController = TextEditingController();

  String? adminId;
  String? supplierId;
  String? practiceId;
  String? professionId;
  String? userID;
  String? userType;

  final Set<int> _expandedIndices = {};
  bool applyCatageories = false;
  bool searchBarOpen = false;

  bool isExpanded(int index) => _expandedIndices.contains(index);

  void toggle(int index) {
    if (_expandedIndices.contains(index)) {
      _expandedIndices.remove(index);
    } else {
      _expandedIndices.add(index);
    }
    notifyListeners();
  }

  void updateApplyCatageories(bool val) {
    applyCatageories = val;
    notifyListeners();
  }

  void setSearchBar(bool val) {
    searchBarOpen = val;
    notifyListeners();
  }

  int offset = 0;
  int limit = 10;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  AllNewsFeedData? allNewsFeedsData;

  ScrollController scrollController = ScrollController();
  String? _activeFeedType;
  String? _activeCategoryType;

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore &&
        hasMoreData) {
      _loadMoreNewsfeeds();
    }
  }

  String selectedStatus = "Published";
  String listingStatus = "PUBLISHED";
  FeedCountData? feedCountData;
  int? pendingCount = 0;
  int? publishedCount = 0;
  int? unPublishedCount = 0;
  Map<String, int?> get statusCountMap => {
        'Published': publishedCount,
        'Unpublished': unPublishedCount,
        'Pending Approval': pendingCount,
      };

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == AdminNewsFeedStatus.pendingStatus.value) {
      listingStatus = AdminNewsFeedStatus.pending.value;
    } else if (status == AdminNewsFeedStatus.publishedStatus.value) {
      listingStatus = AdminNewsFeedStatus.published.value;
    } else if (status == AdminNewsFeedStatus.unpublishedStatus.value) {
      listingStatus = AdminNewsFeedStatus.unPublished.value;
    }

    getAllNewsfeeds(context,
        categoryType: selectedCategoryId, status: listingStatus);
    notifyListeners();
  }

  void _loadMoreNewsfeeds() async {
    if (isLoadingMore || !hasMoreData) return;
    isLoadingMore = true;
    offset += limit;
    try {
      var res = await repo.getAllNewsFeed(offset, limit, searchController.text,
          feedType: _activeFeedType,
          categoryType: _activeCategoryType,
          status: listingStatus);
      if (res != null) {
        final result = AllNewsFeedData.fromJson(res);
        if (result.newsfeeds?.isEmpty ?? true) {
          hasMoreData = false;
        } else {
          allNewsFeedsData?.newsfeeds?.addAll(result.newsfeeds ?? []);
        }
      } else {
        hasMoreData = false;
      }
    } catch (e) {
      hasMoreData = false;
      offset -= limit;
    }
    isLoadingMore = false;
    notifyListeners();
  }

  void resetPagination() {
    offset = 0;
    hasMoreData = true;
    allNewsFeedsData?.newsfeeds?.clear();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    searchController.removeListener(notifyListeners);
    searchController.dispose();
    super.dispose();
  }

  Future<void> getAllNewsfeeds(BuildContext context,
      {String? feedType, String? categoryType, String? status}) async {
    _activeFeedType = feedType;
    _activeCategoryType = categoryType;
    Loaders.circularShowLoader(context);
    resetPagination();
    try {
      var res = await repo.getAllNewsFeed(offset, limit, searchController.text,
          feedType: feedType, categoryType: categoryType, status: status);
      if (res != null) {
        final result = AllNewsFeedData.fromJson(res);
        allNewsFeedsData = result;
        await getAllStatusCounts();
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

  removeNewsFeedLike(BuildContext context, String feedId, String likeId) async {
    updateTheNewsFeedLikeCount(context, feedId, false);
    removeTheLikeObject(context, feedId);
    try {
      await _http.mutation(removeNewsFeedLikeMutation, {"id": likeId});
    } catch (e) {}
    notifyListeners();
  }

  addNewsFeedLike(BuildContext context, String newsFeedId) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    updateTheNewsFeedLikeCount(context, newsFeedId, true);
    final variables = {
      "fields": {
        "news_feeds_id": newsFeedId,
        "created_by_id": userID ?? null,
        "role_type": type,
        if (type == UserRole.supplier.value)
          "dental_supplier_id": supplierId ?? null,
        if (type == UserRole.practice.value)
          "dental_practice_id": practiceId ?? null,
        if (type == UserRole.professional.value)
          "dental_professional_id": professionId ?? null,
        if (type == UserRole.admin.value) "dental_admin_id": adminId ?? null,
      }
    };
    try {
      var res = await _http.mutation(addNewsFeedLikeMutation, variables);
      if (res['insert_newsfeeds_likes_one'] != null) {
        updateTheLikeObject(
            context, newsFeedId, res['insert_newsfeeds_likes_one']['id']);
      } else {
        // API failed — rollback optimistic count
        updateTheNewsFeedLikeCount(context, newsFeedId, false);
      }
    } catch (e) {
      updateTheNewsFeedLikeCount(context, newsFeedId, false);
    }
    notifyListeners();
  }

  Future updateTheNewsFeedLikeCount(
      BuildContext context, String feedId, bool isIncrement) async {
    final newsFeedList = allNewsFeedsData;
    final post = newsFeedList?.newsfeeds
        ?.firstWhere((v) => v.id == feedId, orElse: () => Newsfeeds());
    post?.newsfeedsLikesAggregate?.aggregate?.count = isIncrement
        ? post.newsfeedsLikesAggregate!.aggregate!.count! + 1
        : post.newsfeedsLikesAggregate!.aggregate!.count! - 1;
    notifyListeners();
  }

  Future<void> updateTheLikeObject(
      BuildContext context, String feedId, String likeId) async {
    final newsFeedList = allNewsFeedsData?.newsfeeds;
    final feed = newsFeedList?.firstWhere((v) => v.id == feedId);
    feed?.myLike?.insert(0, MyLike(id: likeId));
    notifyListeners();
  }

  Future<void> removeTheLikeObject(BuildContext context, String feedId) async {
    final newsFeedList = allNewsFeedsData?.newsfeeds;
    final feed = newsFeedList?.firstWhere((v) => v.id == feedId,
        orElse: () => Newsfeeds());
    feed?.myLike?.clear();
    notifyListeners();
  }

  Future<void> getFilterCategories() async {
    final professionTypeId =
        await LocalStorage.getStringVal(LocalStorageConst.professionId);
    final variables = {
      "where": {
        "_and": [
          {
            "community_id": {"_is_null": true}
          },
          if (professionTypeId.isNotEmpty)
            {
              "_or": [
                {
                  "access_rules": {
                    "directory_category_id": {"_eq": professionTypeId}
                  }
                }
              ]
            }
        ]
      },
      "limit": 5,
      "offset": 0
    };
    print("************variables $variables");
    try {
      final response = await _http.query(getAllNewsfeedCategoriesQuery,
          variables: variables);
      if (response['newsfeed_categories'] != null) {
        final res = CategoriesData.fromJson(response);
        newsfeedCategories = res.newsfeedCategories;
        newsfeedCategories?.insert(
            0, NewsfeedCategories(id: '1', categoryName: 'Catalogue'));
        newsfeedCategories?.insert(
            1, NewsfeedCategories(id: '2', categoryName: 'Jobs'));
        newsfeedCategories?.insert(
            2, NewsfeedCategories(id: '3', categoryName: 'Learning Hub'));
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> getUserId() async {
    final userId = await LocalStorage.getStringSync(LocalStorageConst.userId);
    final type = await LocalStorage.getStringSync(LocalStorageConst.type);
    userID = userId;
    userType = type;
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

  deleteTheNewsFeed(BuildContext context, String feedId) async {
    try {
      Loaders.circularShowLoader(context);
      var res = await _http.mutation(deleteTheNewsFeedQuery, {"id": feedId});
      if (res.isNotEmpty) {
        removeTheNewsFeedObject(context, feedId);
        Loaders.circularHideLoader(context);
        getAllNewsfeeds(context,
            categoryType: selectedCategoryId, status: listingStatus);
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
    allNewsFeedsData?.newsfeeds?.removeWhere((v) => v.id == feedId);
    notifyListeners();
  }

  Future<void> BlockReportHidePostUser(
      BuildContext context, String feedId, String action,
      {String? entityId}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    final variables = {
      "fields": {
        "entity_id": (action == "BLOCK") ? entityId : feedId,
        "entity_type": (action == "BLOCK") ? "PROFILE" : "POST",
        "action": action,
        "created_by_id": userId,
        "created_by_type": type,
        "status": "ACTIVE",
        "feed_id": feedId,
        if (action == "REPORT") "reason": reportText.text
      }
    };
    final res = await repo.BlockReportHidePost(variables);
    if (res != null) {
      getAllNewsfeeds(context);
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> getJobDetailsByIds(BuildContext context, String id) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    final variables = {"id": id, "loginID": userId};
    final res = await _http.query(getJobDetailsById, variables: variables);
    Loaders.circularHideLoader(context);
    if (res != null) {
      final result = JobdList.fromJson(res);
      final job =
          result.jobs?.isNotEmpty ?? false ? result.jobs?.first : Jobs();
      navigationService.navigateToWithParams(RouteList.jobdetailsScreen,
          params: job);
    } else {
      scaffoldMessenger("Job details not found");
    }
    notifyListeners();
  }

  Future<void> getAllStatusCounts(
      {String? categoryType, String? feedType}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "where": {
        "_and": [
          {
            "_or": [
              {
                "community_type": {"_eq": "BOTH"}
              },
              {
                "user_id": {"_eq": userId}
              }
            ]
          },
          {
            "_not": {
              "newsfeed_user_actions": {
                "created_by_id": {"_eq": userId},
                "entity_type": {"_eq": "POST"},
                "action": {
                  "_in": ["HIDE", "REPORT"]
                },
                "status": {"_eq": "ACTIVE"}
              }
            }
          },
          {
            "_not": {
              "blocked_by_user_actions": {
                "created_by_id": {"_eq": userId},
                "entity_type": {"_eq": "PROFILE"},
                "action": {"_eq": "BLOCK"},
                "status": {"_eq": "ACTIVE"}
              }
            }
          }
        ]
      }
    };

    final res = await repo.feedCount(variables);
    feedCountData = res;
    pendingCount = feedCountData?.pendingNews?.aggregate?.count ?? 0;
    publishedCount = feedCountData?.publishedNews?.aggregate?.count ?? 0;
    unPublishedCount = feedCountData?.unpublishedNews?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> publishUnPublishNewsFeeds(
      BuildContext context, String id, String status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.publishAndUnpublishNewsFeed(id, status);
    Loaders.circularHideLoader(context);
    if (res['update_newsfeeds_by_pk'].isNotEmpty) {
      scaffoldMessenger('Newsfeed updated successfully');
      await getAllNewsfeeds(context,
          categoryType: selectedCategoryId, status: listingStatus);
    }
  }
}
