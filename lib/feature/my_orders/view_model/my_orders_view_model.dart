import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';
import 'package:di360_flutter/feature/my_orders/repository/my_orders_repo_impl.dart';
import 'package:flutter/material.dart';

class MyOrdersViewModel extends ChangeNotifier {
  final MyOrdersRepoImpl repo = MyOrdersRepoImpl();

  SuppliesOrdersData? suppliesOrdersData;
  static const int _ordersLimit = 10;
  int _ordersOffset = 0;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  Future<void> getSuppliesOrders(
    BuildContext context, {
    bool isLoadMore = false,
  }) async {
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

    final variables = {
      "andList": [
        {
          "status": {"_neq": "DRAFT"}
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
  }
}
