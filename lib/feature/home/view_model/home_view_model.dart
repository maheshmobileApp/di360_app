import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_followers_res.dart';
import 'package:di360_flutter/feature/home/repository/home_repository_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();

  GetFollowersData? getFollowersData;
  String? userName;
  String? profileName;
  String? profilePic;
  String? userID;
  String? userType;

  int offset = 0;
  int limit = 10;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  /*ScrollController scrollController = ScrollController();

  HomeViewModel() {
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore &&
        hasMoreData) {
      loadMoreNewsfeeds();
    }
  }

  void loadMoreNewsfeeds() async {
    if (isLoadingMore || !hasMoreData) return;
    isLoadingMore = true;

    offset += limit;
    print('Loading more... offset: $offset');
    try {
      var res = await homeRepositoryImpl.getAllNewsFeed(offset, limit);
      if (res != null) {
        final result = AllNewsFeedData.fromJson(res);
        print('Received ${result.newsfeeds?.length ?? 0} items');
        if (result.newsfeeds?.isEmpty ?? true) {
          hasMoreData = false;
        } else {
          allNewsFeedsData?.newsfeeds?.addAll(result.newsfeeds ?? []);
        }
      } else {
        hasMoreData = false;
      }
    } catch (e) {
      print('Error loading more: $e');
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
    scrollController.dispose();
    super.dispose();
  }*/

  getFollowersCount(BuildContext context) async {
    Loaders.circularShowLoader(context);
    getUserDetails();
    try {
      var res = await homeRepositoryImpl.getFollowerCount();
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

  /*Future<void> getAllNewsfeeds(BuildContext context,
      {String? feedType, String? categoryType}) async {
    Loaders.circularShowLoader(context);
    resetPagination();
    try {
      var res = await homeRepositoryImpl.getAllNewsFeed(offset, limit,
          feedType: feedType, categoryType: categoryType);
      if (res != null) {
        final result = AllNewsFeedData.fromJson(res);
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
  }*/

  getUserDetails() async {
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    final img = await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final businessName = await LocalStorage.getStringVal(LocalStorageConst.businessName);
    final user_id =
        await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    this.userName = name;
    this.profileName = (type == UserRole.professional.value) ? name : businessName;
    this.profilePic = img;
    this.userID = user_id;
    this.userType = type;
    notifyListeners();
  }
}
