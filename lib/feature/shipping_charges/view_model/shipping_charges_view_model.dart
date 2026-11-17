import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/shipping_charges/model/shipping_charges_res.dart';
import 'package:di360_flutter/feature/shipping_charges/repository/shipping_charges_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class ShippingChargesViewModel extends ChangeNotifier {
  final ShippingChargesRepoImpl repo = ShippingChargesRepoImpl();

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  ShippingChargesData? shippingChargesData;

  Future<void> getShippingCharges(BuildContext context) async {
    Loaders.circularShowLoader(context);

    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "where": {
        "dental_supplier_id": {"_eq": userId}
      }
    };
    final res = await repo.getShippingCharges(variables);
    shippingChargesData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }
}
