import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/purchased_products/model/purchased_products_res.dart';
import 'package:di360_flutter/feature/purchased_products/repository/purchased_products_repo_impl.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class PurchasedProductsViewModel extends ChangeNotifier {
  final PurchasedProductsRepoImpl repo = PurchasedProductsRepoImpl();

  PurchasedProductsData? purchasedProductsData;
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

  Future<void> getPurchasedProducts(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final variables = {
      "buyer": {
        if (type == UserRole.professional.value)
          "dental_professional_id": {"_eq": userId},
        if (type == UserRole.practice.value)
          "dental_practice_id": {"_eq": userId}
      }
    };
    final res = await repo.purchasedProducts(variables);
    purchasedProductsData = res;
  }
}
