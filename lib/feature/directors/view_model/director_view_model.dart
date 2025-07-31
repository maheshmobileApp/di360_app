import 'package:di360_flutter/feature/directors/model_class/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';
import 'package:di360_flutter/feature/directors/respository/director_repository_impl.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class DirectorViewModel extends ChangeNotifier {
  final DirectorRepositoryImpl repository = DirectorRepositoryImpl();

  DirectorViewModel() {
    getBannerList();
    getDirectorCatagoryList();
  }

  List<Directories> directorsList = [];
  List<Banners> bannerList = [];
  List<DirectoryBusinessTypes>? catagoryTypesList;
  List<dynamic> interleavedList = [];
  TextEditingController searchController = TextEditingController();

  String? _selectedCategoryId;

  String? get selectedCategoryId => _selectedCategoryId;

  void selectSingleCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  Future<void> getDirectorsList(BuildContext context) async {
    directorsList = [];
    Loaders.circularShowLoader(context);
    final res = await repository.getDirectors(
        _selectedCategoryId ?? '', searchController.text);
    if (res.isNotEmpty) {
      directorsList = res;
      await getBannerList();
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    await updateInterleavedList();
    notifyListeners();
  }

  Future<void> updateInterleavedList() async {
    List<dynamic> items = [];
    interleavedList = [];
    int bannerIndex = 0;

    for (int i = 0; i < directorsList.length; i += 2) {
      List<Directories> pair = [];
      pair.add(directorsList[i]);
      if (i + 1 < directorsList.length) {
        pair.add(directorsList[i + 1]);
      }
      items.add(pair);

      if (((i + 2) % 6 == 0) && bannerIndex < bannerList.length) {
        items.add(bannerList[bannerIndex]);
        bannerIndex++;
      }
    }

    interleavedList = items;
    notifyListeners();
  }

  Future<void> getBannerList() async {
    final res = await repository.getBannersList();
    if (res.isNotEmpty) {
      bannerList = res;
    }
    notifyListeners();
  }

  Future<void> getDirectorCatagoryList() async {
    final res = await repository.directoriesCatagory();
    if (res.isNotEmpty) {
      catagoryTypesList = res;
    }
    notifyListeners();
  }

  void clearFilter() {
    _selectedCategoryId = null;
    searchController.clear();
    getDirectorsList(navigatorKey.currentContext!);
    notifyListeners();
  }
}
