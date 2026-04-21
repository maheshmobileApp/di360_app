import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/news_feed/model_class/get_news_feed_categories.dart';
import 'package:di360_flutter/feature/news_feed/querys/edit_feed_query.dart';
import 'package:di360_flutter/feature/news_feed/querys/get_all_news_feed_categories_query.dart';
import 'package:di360_flutter/feature/news_feed/querys/get_job_details_by_id.dart';
import 'package:di360_flutter/feature/news_feed/querys/news_feed_like_querys.dart';
import 'package:di360_flutter/feature/news_feed/querys/report_query.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeedViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  NewsFeedViewModel() {
    getUserId();
    getFilterCategories();
  }

  List<NewsfeedCategories>? newsfeedCategories;

  String? selectedCategoryId;

  void updateSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }

  ScrollController feedScrollController = ScrollController();

  String? adminId;
  String? supplierId;
  String? practiceId;
  String? professionId;
  String? userID;

  final Set<int> _expandedIndices = {};

  bool isExpanded(int index) => _expandedIndices.contains(index);

  void toggle(int index) {
    if (_expandedIndices.contains(index)) {
      _expandedIndices.remove(index);
    } else {
      _expandedIndices.add(index);
    }
    notifyListeners();
  }

  bool applyCatageories = false;

  void updateApplyCatageories(bool val) {
    applyCatageories = val;
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
        "dental_supplier_id": supplierId ?? null,
        "dental_practice_id": practiceId ?? null,
        "dental_professional_id": professionId ?? null,
        "dental_admin_id": adminId ?? null,
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
    final newsFeedList = context.read<HomeViewModel>().allNewsFeedsData;
    final post = newsFeedList?.newsfeeds
        ?.firstWhere((v) => v.id == feedId, orElse: () => Newsfeeds());
    post?.newsfeedsLikesAggregate?.aggregate?.count = isIncrement
        ? post.newsfeedsLikesAggregate!.aggregate!.count! + 1
        : post.newsfeedsLikesAggregate!.aggregate!.count! - 1;
    notifyListeners();
  }

  Future<void> updateTheLikeObject(
      BuildContext context, String feedId, String likeId) async {
    final newsFeedList =
        context.read<HomeViewModel>().allNewsFeedsData?.newsfeeds;
    final feed = newsFeedList?.firstWhere((v) => v.id == feedId);
    feed?.myLike?.insert(0, MyLike(id: likeId));
    notifyListeners();
  }

  Future<void> removeTheLikeObject(BuildContext context, String feedId) async {
    final newsFeedList =
        context.read<HomeViewModel>().allNewsFeedsData?.newsfeeds;
    final feed = newsFeedList?.firstWhere((v) => v.id == feedId,
        orElse: () => Newsfeeds());
    feed?.myLike?.clear();
    notifyListeners();
  }

  Future<void> getFilterCategories() async {
    try {
      final response = await _http.query(getAllNewsfeedCategoriesQuery);
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

  deleteTheNewsFeed(BuildContext context, String feedId) async {
    try {
      Loaders.circularShowLoader(context);
      var res = await _http.mutation(deleteTheNewsFeedQuery, {"id": feedId});
      if (res.isNotEmpty) {
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

  Future<void> blockUser(BuildContext context, String userId) async {
    Loaders.circularShowLoader(context);
    await _http.post('/api/v1/auth/check-news-feed-block', {
      "userId": userId,
    });
    scaffoldMessenger("Reported successfully");
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> reportNewsFeed(BuildContext context, String feedId) async {
    Loaders.circularShowLoader(context);
    final res = await _http.mutation(reportQuery, {"id": feedId});
    Loaders.circularHideLoader(context);
    if (res['update_newsfeeds'] != null) {
      removeTheNewsFeedObject(context, feedId);
    }
    notifyListeners();
  }

  Future<void> getJobDetailsByIds(BuildContext context, String id) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    final res = await _http
        .query(getJobDetailsById, variables: {"id": id, "loginID": userId});
    Loaders.circularHideLoader(context);
    if (res.isNotEmpty) {
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
}
