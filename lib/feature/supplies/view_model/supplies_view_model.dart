import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/repository/supplies_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class SuppliesViewModel extends ChangeNotifier {
  final SuppliesRepoImpl repo = SuppliesRepoImpl();

  getSupplyData? supplyData;
  Supplies? suppliesDetailsData;

  int _supplyLimit = 20;
  int _supplyOffset = 0;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  //cart quantity
  final Map<String, int> _cartQuantity = {};

  int getQuantity(String productId) {
    return _cartQuantity[productId] ?? 0;
  }

  void increaseQuantity(String productId) {
    _cartQuantity[productId] = getQuantity(productId) + 1;
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (getQuantity(productId) > 0) {
      _cartQuantity[productId] = getQuantity(productId) - 1;

      if (_cartQuantity[productId] == 0) {
        _cartQuantity.remove(productId);
      }

      notifyListeners();
    }
  }

  Future<void> getSuppliers(
    BuildContext context, {
    bool isLoadMore = false,
  }) async {
    if (isLoading || isLoadingMore) return;
    if (isLoadMore && !hasMoreData) return;

    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isLoading = true;
      _supplyOffset = 0;
      hasMoreData = true;
      Loaders.circularShowLoader(context);
    }

    final variables = {
      "andList": [
        {
          "status": {"_eq": "APPROVED"}
        },
        {
          "product_status": {"_eq": "ACTIVE"}
        },
        {
          "name": {"_ilike": "%%"}
        },
        {
          "supply_brand": {
            "status": {"_eq": "ACTIVE"}
          }
        },
        {
          "supply_category": {
            "status": {"_eq": "ACTIVE"}
          }
        },
        {
          "supply_sub_category": {
            "status": {"_eq": "ACTIVE"}
          }
        },
        {
          "supply_variants": {
            "make_default": {"_eq": true}
          }
        }
      ],
      "limit": _supplyLimit,
      "offset": _supplyOffset,
    };

    final res = await repo.getSuppliers(variables);

    final newItems = res.supplies ?? [];

    if (isLoadMore) {
      supplyData?.supplies?.addAll(newItems);
    } else {
      supplyData = res;
    }

    if (newItems.length < _supplyLimit) {
      hasMoreData = false;
    } else {
      _supplyOffset += _supplyLimit;
    }

    if (!isLoadMore) {
      Loaders.circularHideLoader(context);
      isLoading = false;
    } else {
      isLoadingMore = false;
    }

    notifyListeners();
  }

//add to cart
  Future<void> addToCart(BuildContext context, String supplyId,
      String supplyVariantId, int quantity) async {
    final variables = {
      "supply_carts": {
        "supply_id": supplyId,
        "supply_variant_id": supplyVariantId,
        "quantity": quantity,
      }
    };

    print("Add to cart variables: $variables");
    final res = await repo.addToCart(variables);
  }

  Future<void> getSuppliesDetails(BuildContext context, String supplyId) async {
    Loaders.circularShowLoader(context);

    final variables = {"id": supplyId};

    final res = await repo.getSuppliesDetails(variables);
    suppliesDetailsData = res.supplies?.firstOrNull;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }
}
