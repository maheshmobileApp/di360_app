import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_type_res.dart';
import 'package:di360_flutter/feature/add_catalogues/repository/add_catalogue_repository_impl.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_repository/catalogue_repository_impl.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_suppliers_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/utils/loader.dart';

class CatalogueViewModel extends ChangeNotifier {
  final CatalogueRepositoryImpl repo = CatalogueRepositoryImpl();
  final AddCatalogueRepositoryImpl addCataRepo = AddCatalogueRepositoryImpl();

  CatalogueViewModel() {
    getFilterTypes();
    getFilterCatagorie();
    //getFilterSupplier();
  }

  TextEditingController searchController = TextEditingController();

  List<CatalogueCategories> catalogueCategories = [];
  CataloguesByPk? cataloguesByIdData;
  List<CatalogData>? reletedCatalogues = [];
  List<CatalogueSubCategories> filterCategories = [];
  List<CatalogueTypes> filterTypes = [];
  List<DentalSuppliers>? filterSuppliers = [];

  Map<String, bool> showMoreMap = {};

  late Map<String, List<FilterItem>> filterOptions;
  List<String> suppliers = [];
  List<String> catagroies = [];
  String? type = '';
  String? selectedUserId;
  bool? cataloguesLoading;
  bool? catalogFilterApply;

  void updateCatalogFilterApply(bool val) {
    catalogFilterApply = val;
    notifyListeners();
  }

  Map<String, Set<int>> selectedIndices = {
    'type': {},
    'categories': {},
    'suppliers': {},
    'favourites': {},
  };

  Map<String, bool> sectionVisibility = {
    'type': true,
    'categories': true,
    'suppliers': true,
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

  final PageController pageController = PageController();
  int currentPage = 0;

  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> fetchCatalogue(BuildContext context) async {
    cataloguesLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    Loaders.circularShowLoader(context);
    var res = await repo.getCatalogue(
        searchController.text,type, catagroies, suppliers, selectedUserId ?? '');
    if (res != []) {
      catalogueCategories = res;
      initializeExpanded(catalogueCategories);
      Loaders.circularHideLoader(context);
      for (var cat in catalogueCategories) {
        showMoreMap[cat.name ?? ''] = false;
      }
    } else {
      catalogueCategories = [];
      Loaders.circularHideLoader(context);
    }
    cataloguesLoading = false;
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

  Future<void> getFilterTypes() async {
    final res = await addCataRepo.getCatalogueTypes();
    if (res != null) {
      filterTypes = res;
      initializeFilterOptions();
    }
    notifyListeners();
  }

  Future<void> getFilterCatagorie() async {
    final res = await addCataRepo.getCatagorys();
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
    final userRole = UserRole.fromString(type);
    if (userRole == UserRole.professional) {
      return CatalogueFavorites(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: userId,
        dentalSupplierId: null,
      );
    } else if (userRole == UserRole.supplier) {
      return CatalogueFavorites(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: null,
        dentalSupplierId: userId,
      );
    } else if (userRole == UserRole.practice) {
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
    final userRole = UserRole.fromString(type);
    if (userRole == UserRole.professional) {
      return CatalogueFavoritesReleated(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: userId,
        dentalSupplierId: null,
      );
    } else if (userRole == UserRole.supplier) {
      return CatalogueFavoritesReleated(
        id: null,
        catalogueId: null,
        type: type,
        dentalPracticeId: null,
        dentalProfessionalId: null,
        dentalSupplierId: userId,
      );
    } else if (userRole == UserRole.practice) {
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

  void initializeFilterOptions() async {
    final user_id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    filterOptions = {
      'Types': filterTypes.map((e) {
        return FilterItem(name: e.name ?? '', id: e.id ?? '');
      }).toList(),
      'categories': filterCategories.map((e) {
        return FilterItem(
          name: e.name ?? '',
          id: e.id ?? '',
        );
      }).toList(),
      'suppliers': [
        FilterItem(name: 'smiletech', id: user_id),
      ],
      'favourites': [
        FilterItem(name: 'My Favourites', id: user_id),
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

  void clearSelections(BuildContext context) {
    selectedIndices.updateAll((key, value) => {});
    searchController.clear();
    selectedUserId = null;
    suppliers = [];
    catagroies = [];
    type = null;
    updateCatalogFilterApply(false);
    fetchCatalogue(context);
    notifyListeners();
  }

  void printSelectedItems() {
    suppliers = [];
    catagroies = [];
    type = null;
    selectedIndices.forEach((section, indices) {
      final items = filterOptions[section];
      if (items != null && indices.isNotEmpty) {
        for (final i in indices) {
          updateCatalogFilterApply(true);
          final id = items[i].id;
          final name = items[i].name;
          if (section == "suppliers") {
            suppliers.add(name);
          } else if (section == "categories") {
            catagroies.add(id);
          } else if (section == "favourites") {
            selectedUserId = id;
          } else if (section == "Types") {
            type = id;
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
