import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/my_learning_hub/repository/my_learning_hub_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class MyLearningHubViewModel extends ChangeNotifier with ValidationMixins {
  final MyLearningHubRepoImpl repo = MyLearningHubRepoImpl();

  List<CoursesListingDetails> myRegisteredCourses = [];
  bool searchBarOpen = false;
  final searchController = TextEditingController();

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  Future<void> getCoursesWithMyRegistrations(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final res =
        await repo.getCoursesWithMyRegistrations(userId, searchController.text);

    if (res != null) {
      myRegisteredCourses = res;
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
