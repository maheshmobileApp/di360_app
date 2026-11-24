import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/purchased_products/model/purchased_order_items_res.dart';
import 'package:di360_flutter/feature/purchased_products/repository/purchased_order_items_repo_impl.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class PurchasedOrderTemsViewModel extends ChangeNotifier {
  final PurchasedOrderItemsRepoImpl repo = PurchasedOrderItemsRepoImpl();

  TextEditingController searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  bool isFilterApplied = false;

  String selectedSupplierId = '';
  String selectedSupplierName = '';
  String selectedBrand = '';
  String selectedCategory = '';

  PurchasedOrderItemsData? purchasedOrderItemsData;
  final stockOptions = ['All', 'Available', 'Low stock', 'Out of Stock'];
  String selectedStock = 'All';
  final Map<String, int> _quantities = {};
  int quantityFor(String productId) {
    return _quantities[productId] ?? 0;
  }

  void increaseQuantity(String productId) {
    _quantities[productId] = quantityFor(productId) + 1;
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    final current = quantityFor(productId);

    if (current > 1) {
      _quantities[productId] = current - 1;
      notifyListeners();
    }
  }

  void resetQuantity(String productId) {
    _quantities[productId] = 0;
    notifyListeners();
  }

  void setFilterApply(bool val) {
    isFilterApplied = val;
    notifyListeners();
  }

  void setSelectedSupplier(String? id, String? name) {
    selectedSupplierId = id ?? "";
    selectedSupplierName = name ?? "";
    notifyListeners();
  }

  void setSelectedStock(String v) {
    selectedStock = v;
    notifyListeners();
  }

   void setStartDate(DateTime date) {
    startDateController.text =
        DateFormatUtils.formatToYyyyMmDd(date);
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDateController.text =
        DateFormatUtils.formatToYyyyMmDd(date);
    notifyListeners();
  }

  void clearDates() {
    
  }

  Future<void> getPurchasedOrderItems(BuildContext context,
      {isLoadMore = false}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    final variables = {
      "buyer": {
        "dental_professional_id": {"_eq": userId}
      }
    };
    final res = await repo.getPurchasedOrderItems(variables);
    purchasedOrderItemsData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  void setSelectedBrand(String? v) {
    selectedBrand = v ?? '';
    notifyListeners();
  }

  void setSelectedCategory(String? v) {
    selectedCategory = v ?? '';
    notifyListeners();
  }

  void clearFilters() {
    selectedSupplierId = '';
    selectedSupplierName = '';
    selectedBrand = '';
    selectedCategory = '';
    notifyListeners();
  }
}
