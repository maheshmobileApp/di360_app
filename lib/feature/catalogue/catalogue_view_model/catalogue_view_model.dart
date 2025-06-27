import 'package:di360_flutter/feature/catalogue/catalogue_repository/catalogue_repository_impl.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CatalogueViewModel extends ChangeNotifier {
  final CatalogueRepositoryImpl repo = CatalogueRepositoryImpl();

  List<CatalogueCategories> catalogueCategories = [];
  CataloguesByPk? cataloguesByIdData;

  Map<String, bool> showMoreMap = {};

  Future<void> fetchCatalogue(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    Loaders.circularShowLoader(context);
    catalogueCategories = await repo.getCatalogue();
    Loaders.circularHideLoader(context);
    for (var cat in catalogueCategories) {
      showMoreMap[cat.name ?? ''] = false;
    }

    notifyListeners();
  }

  void toggleShowMore(String categoryName) {
    showMoreMap[categoryName] = !(showMoreMap[categoryName] ?? false);
    notifyListeners();
  }

  bool isShowMore(String categoryName) {
    return showMoreMap[categoryName] ?? false;
  }

  Future<void> getCatalogDetails(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getCatalogueById(id);
    if (res != null) {
      cataloguesByIdData = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
