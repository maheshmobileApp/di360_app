import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_repository/catalogue_repository_impl.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_catagories_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_suppliers_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/utils/loader.dart';

class CatalogueViewModel extends ChangeNotifier {
  final CatalogueRepositoryImpl repo = CatalogueRepositoryImpl();

  CatalogueViewModel() {
    getFilterCatagorie();
    getFilterSupplier();
  }

  TextEditingController searchController = TextEditingController();

  List<CatalogueCategories> catalogueCategories = [];
  CataloguesByPk? cataloguesByIdData;
  List<CatalogData>? reletedCatalogues = [];
  List<FilterCategories>? filterCategories = [];
  List<DentalSuppliers>? filterSuppliers = [];

  Map<String, bool> showMoreMap = {};

  late Map<String, List<FilterItem>> filterOptions;

  Map<String, Set<int>> selectedIndices = {
    'suppliers': {},
    'categories': {},
    'favourites': {},
  };

  Map<String, bool> sectionVisibility = {
    'suppliers': true,
    'categories': true,
    'favourites': true,
  };

  Map<String, bool> expandedCategories = {};

  void initializeExpanded(List<CatalogueCategories> categories) {
    if (categories.isNotEmpty) {
      expandedCategories[categories.first.name ?? ''] = true;
    }
    notifyListeners();
  }

  bool isExpanded(String categoryName) {
    return expandedCategories[categoryName] ?? false;
  }

  void toggleExpanded(String categoryName) {
    expandedCategories[categoryName] =
        !(expandedCategories[categoryName] ?? false);
    notifyListeners();
  }

  Future<void> fetchCatalogue(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    Loaders.circularShowLoader(context);
    catalogueCategories =
        await repo.getCatalogue(searchController.text, catagroies, suppliers);
    initializeExpanded(catalogueCategories);
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

  Future<void> getReletedCatalog(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getRelatedCatalogues(id);
    if (res != null) {
      reletedCatalogues = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getFilterCatagorie() async {
    final res = await repo.getFilterCatagories();
    if (res != null) {
      filterCategories = res;
      initializeFilterOptions();
    }
    notifyListeners();
  }

  Future<void> getFilterSupplier() async {
    final res = await repo.getFilterSuppliers();
    if (res != null) {
      filterSuppliers = res;
      initializeFilterOptions();
    }
    notifyListeners();
  }

  Future<void> catalogueLike(List<Catalogues>? catalogues, String id) async {
    final catalog = catalogues?.firstWhere((v) => v.id == id);
    final newLike = await insertCatalogeLikeObj();
    catalog?.catalogueFavorites?.insert(0, newLike);
    await repo.addLikeCatalogue(id);
    notifyListeners();
  }

  Future<CatalogueFavorites> insertCatalogeLikeObj() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == UserRole.professional) {
      return CatalogueFavorites(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: userId,
        dentalSupplierId: null,
      );
    } else if (type == UserRole.supplier) {
      return CatalogueFavorites(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: null,
        dentalSupplierId: userId,
      );
    } else if (type == UserRole.practice) {
      return CatalogueFavorites(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: userId,
        dentalProfessionalId: null,
        dentalSupplierId: null,
      );
    }
    throw Exception("Invalid user type");
  }

  Future<void> catalogueUnLike(List<Catalogues>? catalogues, String id) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final catalog = catalogues?.firstWhere((v) => v.id == id);
    catalog?.catalogueFavorites?.removeWhere((v) =>
        v.dentalPracticeId == userId ||
        v.dentalProfessionalId == userId ||
        v.dentalSupplierId == userId);
    await repo.removeLikeCatalogue(id);
    notifyListeners();
  }

  Future<void> releatedCatalogueLike(String id) async {
    final catalog = reletedCatalogues?.firstWhere((v) => v.id == id);
    final newLike = await insertRelatedCatalogeLikeObj();
    catalog?.catalogueFavorites?.insert(0, newLike);
    await repo.addLikeCatalogue(id);
    notifyListeners();
  }

  Future<void> relatedCatalogueUnLike(String id) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final catalog = reletedCatalogues?.firstWhere((v) => v.id == id);
    catalog?.catalogueFavorites?.removeWhere((v) =>
        v.dentalPracticeId == userId ||
        v.dentalProfessionalId == userId ||
        v.dentalSupplierId == userId);
    await repo.removeLikeCatalogue(id);
    notifyListeners();
  }

  Future<CatalogueFavoritesReleated> insertRelatedCatalogeLikeObj() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == UserRole.professional) {
      return CatalogueFavoritesReleated(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: userId,
        dentalSupplierId: null,
      );
    } else if (type == UserRole.supplier) {
      return CatalogueFavoritesReleated(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: null,
        dentalSupplierId: userId,
      );
    } else if (type == UserRole.practice) {
      return CatalogueFavoritesReleated(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: userId,
        dentalProfessionalId: null,
        dentalSupplierId: null,
      );
    }
    throw Exception("Invalid user type");
  }

  void initializeFilterOptions() {
    filterOptions = {
      'suppliers': filterSuppliers?.map((e) {
            return FilterItem(
              name: e.name ?? '',
              id: e.id ?? '',
            );
          }).toList() ??
          [],
      'categories': filterCategories?.map((e) {
            return FilterItem(
              name: e.name ?? '',
              id: e.id ?? '',
            );
          }).toList() ??
          [],
      'favourites': [
        FilterItem(name: 'My Favourites', id: 'fav'),
      ],
    };

    notifyListeners();
  }

  void toggleSection(String section) {
    sectionVisibility[section] = !(sectionVisibility[section] ?? true);
    notifyListeners();
  }

  void selectItem(String section, int index) {
    final currentSet = selectedIndices[section] ?? {};

    if (currentSet.contains(index)) {
      currentSet.remove(index);
    } else {
      currentSet.add(index);
    }

    selectedIndices[section] = currentSet;
    notifyListeners();
  }

  void clearSelections() {
    selectedIndices.updateAll((key, value) => {});
    searchController.clear();
    suppliers = [];
    catagroies = [];
    notifyListeners();
  }

  List<String> suppliers = [];
  List<String> catagroies = [];

  void printSelectedItems() {
    suppliers = [];
    catagroies = [];
    selectedIndices.forEach((section, indices) {
      final items = filterOptions[section];
      if (items != null && indices.isNotEmpty) {
        for (final i in indices) {
          final id = items[i].id;
          if (section == "suppliers") {
            suppliers.add(id);
          } else if (section == "categories") {
            catagroies.add(id);
          }
        }
      }
    });
  }
}

class FilterItem {
  final String name;
  final String id;
  bool isSelected;

  FilterItem({
    required this.name,
    required this.id,
    this.isSelected = false,
  });
}
