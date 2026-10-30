import 'package:di360_flutter/feature/shipping_charges/model/shipping_charges_res.dart';
import 'package:di360_flutter/feature/shipping_charges/repository/shipping_charges_repo_impl.dart';
import 'package:flutter/material.dart';

class ShippingChargesViewModel extends ChangeNotifier {
  final ShippingChargesRepoImpl repo = ShippingChargesRepoImpl();

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  ShippingChargesData? shippingChargesData;

  Future<void> getShippingCharges(BuildContext context) async {
    final variables = {"where": {}};
    final res = await repo.getShippingCharges(variables);
    shippingChargesData = res;
    notifyListeners();
  }
}
