import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/purchased_products/model/purchased_order_items_res.dart';
import 'package:di360_flutter/feature/purchased_products/repository/purchased_order_items_repo_impl.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
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

  String? startDate;
  String? endDate;

  void setStartDate(DateTime date) {
    startDateController.text = DateFormatUtils.formatToYyyyMmDd(date);
    startDate = date.toString();

    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDateController.text = DateFormatUtils.formatToYyyyMmDd(date);
    endDate = date.toString();
    notifyListeners();
  }

  void clearDates() {}

  Future<void> getPurchasedOrderItems(BuildContext context,
      {isLoadMore = false}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    final variables = {
      "where": {
        "_and": [
          {
            "supplies_order": {
              if (type == UserRole.professional.value)
                "dental_professional_id": {"_eq": userId},
              if (type == UserRole.practice.value)
                "dental_practice_id": {"_eq": userId}
            }
          },
          {
            "supplies_order": {
              "status": {"_neq": "CANCELLED"}
            }
          },
          if (searchController.text.isNotEmpty)
          {
                "_or": [
                    {
                        "supply": {
                            "name": {
                                "_ilike": "%${searchController.text}%"
                            }
                        }
                    },
                    {
                        "supply_variant": {
                            "sku_code": {
                                "_ilike": "%${searchController.text}%"
                            }
                        }
                    },
                    {
                        "supplies_order": {
                            "supplier": {
                                "business_name": {
                                    "_ilike": "%${searchController.text}%"
                                }
                            }
                        }
                    },
                    {
                        "supply": {
                            "supply_brand": {
                                "name": {
                                    "_ilike": "%${searchController.text}%"
                                }
                            }
                        }
                    }
                ]
            },
          if (selectedSupplierName != "")
            {
              "supplies_order": {
                "supplier": {
                  "business_name": {"_eq": selectedSupplierName}
                }
              }
            },
          if (selectedBrand != "")
            {
              "supply": {
                "supply_brand": {
                  "name": {"_eq": selectedBrand}
                }
              }
            },
          if (selectedCategory != "")
            {
              "supply": {
                "supply_category": {
                  "name": {"_eq": selectedCategory}
                }
              }
            },
          if (selectedStock != "All")
            {
              "supply_variant": {
                "available_stock": selectedStock == "Available"
                    ? {"_gte": 10}
                    : selectedStock == "Low stock"
                        ? {"_gt": 0, "_lt": 10}
                        : {"_lte": 0}
              }
            },
          if (startDate != null)
            {
              "supplies_order": {
                "created_at": {"_gte": startDate}
              }
            },
          if (endDate != null)
            {
              "supplies_order": {
                "created_at": {"_lte": endDate}
              }
            }
        ]
      }
    };
    print('variables $variables');
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

  Future<void> clearFilters() async{
    selectedSupplierId = '';
    selectedSupplierName = '';
    selectedBrand = '';
    selectedCategory = '';
    selectedStock = 'All';
    setFilterApply(false);
    searchController.clear();
    startDateController.clear();
    endDateController.clear();
    startDate = null;
    endDate = null;
    notifyListeners();
  }
}
