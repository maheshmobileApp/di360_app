import 'package:di360_flutter/feature/my_favourites/model/supply_favourites_res.dart';
import 'package:di360_flutter/feature/my_favourites/repository/my_favourites_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class MyFavouritesViewModel extends ChangeNotifier {
  final MyFavouritesRepoImpl repo = MyFavouritesRepoImpl();

  SupplyFavouritesData? supplyFavouritesData;
  final Map<String, int> _quantities = {};
  final searchController = TextEditingController();

  String? selectedSupplierId;
  String? selectedSupplierName;
  String? selectedStock;

  bool isFilterApplied = false;

  final stockOptions = ['All', 'Available', 'Low stock', 'Out of Stock'];

  void setSelectedStock(String? value) {
    selectedStock = value;
    notifyListeners();
  }

  void setFilterApply(bool value) {
    isFilterApplied = value;
    notifyListeners();
  }

  void setSelectedSupplier(String? id, String? name) {
    selectedSupplierId = id;
    selectedSupplierName = name;
    notifyListeners();
  }

  Future<void> clearFilters() async {
    selectedSupplierId = null;
    selectedSupplierName = null;
    selectedStock = null;
    searchController.clear();
    setFilterApply(false);
    notifyListeners();
  }

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

  Future<void> getSupplyFavourites(BuildContext context) async {
    Loaders.circularShowLoader(context);

    final variables = {
      "limit": 10,
      "offset": 0,
      "where": {
        "supply": {
          "product_status": {"_eq": "ACTIVE"},
          if (selectedSupplierName != null &&
              selectedSupplierName != "All Suppliers")
            "dental_supplier": {
              "business_name": {"_eq": selectedSupplierName}
            }
        },
        if (searchController.text != "")
          "_or": [
            {
              "supply": {
                "name": {"_ilike": "%${searchController.text}%"}
              }
            },
            {
              "supply": {
                "dental_supplier": {
                  "business_name": {"_ilike": "%${searchController.text}%"}
                }
              }
            }
          ],
        if (selectedStock != null && selectedStock != "All")
          "supply_variant": {
            "stock_status": {"_eq": _getStockText(selectedStock)}
          }
      }
    };

    final res = await repo.getSupplyFavourites(variables);
    supplyFavouritesData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  String _getStockText(String? text) {
    if (text == 'Available') {
      return 'IN_STOCK';
    } else if (text == 'Low stock') {
      return 'LOW_STOCK';
    } else if (text == 'Out of stock') {
      return 'OUT_OF_STOCK';
    } else if (text == 'All') {
      return 'All';
    }
    return '';
  }

  Future<void> deleteFavourite(
      BuildContext context, String supplyId, String supplyVariantId) async {
    final variables = {
      "supplyId": supplyId,
      "supplyVariantId": supplyVariantId
    };
    final res = await repo.deleteFavourite(variables);
    if (res != null) {
      await getSupplyFavourites(context);
      scaffoldMessenger("Removed from Favourite");
    }
    notifyListeners();
  }
}
