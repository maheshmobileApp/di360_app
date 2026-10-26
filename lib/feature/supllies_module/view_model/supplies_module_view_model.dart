import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_brands_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_sub_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/repository/supplies_module_repo_impl.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class SuppliesModuleViewModel extends ChangeNotifier {
  final SuppliesModuleRepoImpl repo = SuppliesModuleRepoImpl();

  TextEditingController searchController = TextEditingController();

  GetSupplyData? getSupplyData;
  SupplyBrandsData? supplyBrandsData;
  SupplyCategoriesData? supplyCategoriesData;
  SupplySubCategoriesData? supplySubCategoriesData;
  String? selectedBrandId;
  String? selectedCategoryId;
  String? selectedSubCategoryId;
  String? selectedProductType;

  void setSelectedBrand(String? id) {
    selectedBrandId = id;
    notifyListeners();
  }

  void setSelectedCategory(String? id) {
    selectedCategoryId = id;
    selectedSubCategoryId = null; // reset sub-category when category changes
    notifyListeners();
  }

  void setSelectedSubCategory(String? id) {
    selectedSubCategoryId = id;
    notifyListeners();
  }

  void setSelectedProductType(String? id) {
    selectedProductType = id;
    notifyListeners();
  }

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  bool isFilterApplied = false;

  void setFilterApply(bool value) {
    isFilterApplied = value;
    notifyListeners();
  }

  Future<void> getSuppliesList(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "andList": [
        {
          "status": {"_eq": "APPROVED"}
        },
        {
          "name": {"_ilike": "%${searchController.text}%"}
        },
        {
          "dental_suppliers_id": {"_eq": id}
        },
        if (selectedBrandId != null && selectedBrandId!.isNotEmpty)
          {
            "supply_brand_id": {"_eq": selectedBrandId}
          },
        if (selectedCategoryId != null && selectedCategoryId!.isNotEmpty)
          {
            "supply_category_id": {"_eq": selectedCategoryId}
          },
        if (selectedSubCategoryId != null && selectedSubCategoryId!.isNotEmpty)
          {
            "supply_sub_category_id": {"_eq": selectedSubCategoryId}
          },
        if (selectedProductType != null && selectedProductType!.isNotEmpty)
          {
            "product_type": {"_eq": selectedProductType == "Simple Product" ? "simple": "with variant"}
          },
      ],
      "sortList": [
        {"status_changed_at": "desc"}
      ],
      "limit": 50,
      "offset": 0
    };
    final res = await repo.getSuppliesList(variables);
    getSupplyData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> getSupplyBrands() async {
    final res = await repo.getSupplyBrands();
    supplyBrandsData = res;
    notifyListeners();
  }

  Future<void> getSupplyCategories() async {
    final res = await repo.getSupplyCategories();
    supplyCategoriesData = res;
    notifyListeners();
  }

  Future<void> getSupplySubCategories() async {
    final res = await repo.getSupplySubCategories();
    supplySubCategoriesData = res;
    notifyListeners();
  }

  clearFilters() {
    selectedBrandId = null;
    selectedCategoryId = null;
    selectedSubCategoryId = null;
    selectedProductType = null;
    notifyListeners();
  }
}
