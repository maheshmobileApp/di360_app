import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/model_class/get_followers_res.dart';
import 'package:di360_flutter/feature/home/repository/home_repository_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();

  GetFollowersData? getFollowersData;
  AllNewsFeedData? allNewsFeedsData;
  String? userName;
  String? profilePic;
  String? userID;
  String? userType;

  int offset = 0;

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

  Future<void> getAllNewsfeeds(BuildContext context) async {
    Loaders.circularShowLoader(context);
    try {
      var res = await homeRepositoryImpl.getAllNewsFeed(offset);
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
