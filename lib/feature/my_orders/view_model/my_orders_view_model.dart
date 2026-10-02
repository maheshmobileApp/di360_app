import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';
import 'package:di360_flutter/feature/my_orders/model/get_all_dental_suppliers_res.dart';
import 'package:di360_flutter/feature/my_orders/repository/my_orders_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class MyOrdersViewModel extends ChangeNotifier {
  final MyOrdersRepoImpl repo = MyOrdersRepoImpl();

  SuppliesOrdersData? suppliesOrdersData;
  static const int _ordersLimit = 10;
  int _ordersOffset = 0;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  bool isFilterApplied = false;

  final TextEditingController searchController = TextEditingController();
  String selectedOrderStatus = "";
  String selectedSupplierName = "";
  String selectedSupplierId = "";

  String filterStatus = "";
  String filterSupplierId = "";
  String filterStartDate = "";
  String filterEndDate = "";

  void setFilterApply(bool value) {
    isFilterApplied = value;
    notifyListeners();
  }

  void setFilterDates(String startDate, String endDate) {
    filterStartDate = startDate;
    filterEndDate = endDate;
    notifyListeners();
  }

  void setSelectedOrderStatus(String value) {
    selectedOrderStatus = value;
    filterStatus = value.toUpperCase();
    notifyListeners();
  }

  void setSelectedSupplier(String id, String name) {
    selectedSupplierId = id;
    selectedSupplierName = name;
    filterSupplierId = id;
    notifyListeners();
  }

  List<String> orderStatuses = [
    "Select Order Status",
    "Pending",
    "Approved",
    "Partially Shipped",
    "Shipped",
    "Delivered",
    "Cancelled",
    "Refunded"
  ];

  Future<void> getSuppliesOrders(
    BuildContext context, {
    bool isLoadMore = false,
  }) async {
    Loaders.circularShowLoader(context);
    if (isLoading || isLoadingMore) return;
    if (isLoadMore && !hasMoreData) return;

    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isLoading = true;
      _ordersOffset = 0;
      hasMoreData = true;
    }
    notifyListeners();

    if (filterStatus.isNotEmpty ||
        filterSupplierId.isNotEmpty ||
        filterStartDate.isNotEmpty ||
        filterEndDate.isNotEmpty) {
      setFilterApply(true);
    } else {
      setFilterApply(false);
    }

    final variables = {
      "andList": [
        (filterStatus != "")
            ? {
                "status": {"_eq": filterStatus}
              }
            : {
                "status": {"_neq": "DRAFT"}
              },
        if (filterSupplierId != "")
          {
            "suppliers_id": {"_eq": filterSupplierId}
          },
        if (filterStartDate != "" && filterEndDate != "")
          {
            "created_at": {"_gte": filterStartDate, "_lte": filterEndDate}
          }
      ],
      "limit": _ordersLimit,
      "offset": _ordersOffset,
    };

    try {
      final res = await repo.getSuppliesOrders(variables);
      final newOrders = res.suppliesOrders ?? [];

      if (isLoadMore) {
        final existingOrders = suppliesOrdersData?.suppliesOrders ?? [];
        suppliesOrdersData = SuppliesOrdersData(
          suppliesOrders: [...existingOrders, ...newOrders],
        );
      } else {
        suppliesOrdersData = res;
      }

      _ordersOffset += newOrders.length;
      hasMoreData = newOrders.length == _ordersLimit;
    } finally {
      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
    }
    Loaders.circularHideLoader(context);
  }

  AllDentalSuppliersData? suppliersData;

  Future<void> getAllDentalSuppliers(BuildContext context) async {
    Loaders.circularShowLoader(context);

    final res = await repo.getAllDentalSuppliers();
    suppliersData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  clearFilters() {
    selectedOrderStatus = "";
    selectedSupplierName = "";
    selectedSupplierId = "";
    filterStatus = "";
    filterSupplierId = "";
    filterStartDate = "";
    filterEndDate = "";
    notifyListeners();
  }
}
