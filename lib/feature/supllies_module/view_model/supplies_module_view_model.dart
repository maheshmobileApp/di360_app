import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/supllies_module/model/all_supplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/approve_supplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/draft_suplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/supplies_detail_res.dart';
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

  String selectedSuppliesStatus = "All";

  final List<String> suppliesStatus = [
    'All',
    'Draft',
    'Approved',
  ];

  void changeSuppliesStatus(String value, BuildContext context) {
    selectedSuppliesStatus = value;
    getSuppliesList(context);
    notifyListeners();
  }

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
        if (selectedSuppliesStatus != "All")
          {
            "status": {
              "_eq": selectedSuppliesStatus == "Approved" ? "APPROVED" : "DRAFT"
            }
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
            "product_type": {
              "_eq": selectedProductType == "Simple Product"
                  ? "simple"
                  : "with variant"
            }
          },
      ],
      "sortList": [
        {"status_changed_at": "desc"}
      ],
      "limit": 50,
      "offset": 0
    };
    final res = await repo.getSuppliesList(variables);
    await getAllSuppliesCount();
    await getDraftSuppliesCount();
    await getApproveSuppliesCount();
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

  AllSuppliesData? allSuppliesData;
  DraftSuppliesData? draftSuppliesData;
  ApproveSuppliesData? approveSuppliesData;
  SuppliesDetailData? suppliesDetailData;

  int allCount = 0;
  int draftCount = 0;
  int approvedCount = 0;

  Map<String, int?> get statusSuppliersCountMap => {
        'All': allCount,
        'Draft': draftCount,
        'Approved': approvedCount,
      };

  Future<void> getAllSuppliesCount() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "andList": [
        {
          "name": {"_ilike": "%%"}
        },
        {
          "dental_suppliers_id": {"_eq": id}
        }
      ]
    };
    final res = await repo.getAllSuppliesCount(variables);
    allSuppliesData = res;
    allCount = res.suppliesAggregate?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> getDraftSuppliesCount() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {"dental_suppliers_id": id};
    final res = await repo.getDraftSuppliesCount(variables);
    draftSuppliesData = res;
    draftCount = res.draft?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> getApproveSuppliesCount() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {"dental_suppliers_id": id};
    final res = await repo.getApproveSuppliesCount(variables);
    approveSuppliesData = res;
    approvedCount = res.approved?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> getSuppliesDetails(String id, BuildContext context) async {
    Loaders.circularShowLoader(context);

    final variables = {"id": id};
    final res = await repo.getSuppliesDetails(variables);
    suppliesDetailData = res;
    Loaders.circularHideLoader(context);

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
