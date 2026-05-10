import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/my_learning_hub/repository/my_learning_hub_repo_impl.dart';
import 'package:flutter/material.dart';

class MyLearningHubViewModel extends ChangeNotifier with ValidationMixins {
  final MyLearningHubRepoImpl repo = MyLearningHubRepoImpl();

  List<CoursesListingDetails> myRegisteredCourses = [];
  bool searchBarOpen = false;
  final searchController = TextEditingController();

  int _myLearningHubLimit = 10;
  int _myLearningHubOffset = 0;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  bool isLoading = false;

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  Future<void> getCoursesWithMyRegistrations(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
      _myLearningHubOffset += _myLearningHubLimit;
    } else {
      _myLearningHubOffset = 0;
      hasMoreData = true;
      isLoading = true;
    }

    notifyListeners();

    final res = await repo.getCoursesWithMyRegistrations(
        searchController.text, _myLearningHubLimit, _myLearningHubOffset);

    if (res != null) {
      if (loadMore) {
        myRegisteredCourses.addAll(res);
        isLoadingMore = false;
      } else {
        myRegisteredCourses = res;
        isLoading = false;
      }
      hasMoreData = res.length >= _myLearningHubLimit;
    } else {
      isLoading = false;
      isLoadingMore = false;
    }

    notifyListeners();
  }

  Future<void> getCoursesWithFilters(BuildContext context, String? type,
      String? category, String? date) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    //Loaders.circularShowLoader(context);
    final res = await repo.getCoursesWithFilters(userId, type, category, date);

    if (res != null) {
      myRegisteredCourses = res;
      //Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
