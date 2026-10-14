import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/account_requests_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/supplier_accounts_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/repository/account_pay_requests_repo_impl.dart';
import 'package:di360_flutter/feature/supplies/model/get_dental_suppliers.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class AccountPayRequestsViewModel extends ChangeNotifier {
  AccountPayRequestsRepoImpl repo = AccountPayRequestsRepoImpl();

  AccountRequestsData? accountRequestsData;
  SupplierAccountData? supplierAccountData;
  DentalSuppliersData? dentalSuppliersData;

  String? supplierValue;
  final accountNumberController = TextEditingController();

  void setSupplier(String? value) {
    supplierValue = value;
    notifyListeners();
  }

  Future<void> getAccountPayRequests(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final variables = {"limit": 50, "offset": 0};
    final res = await repo.getAccountPayRequests(variables);
    accountRequestsData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> getSupplierAccounts(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    final variables = {
      "limit": 50,
      "offset": 0,
      "where": {
        "dental_practice_id": {"_eq": userId}
      }
    };
    final res = await repo.getSupplierAccount(variables);
    supplierAccountData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> getDentalSuppliers(BuildContext context) async {
    Loaders.circularShowLoader(context);

    final res = await repo.getDentalSuppliers();
    dentalSuppliersData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> addSupplierAccount(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final supplierId = dentalSuppliersData?.dentalSuppliers
            ?.firstWhere((e) => e.businessName == supplierValue,
                orElse: () => DentalSuppliers())
            .id ??
        '';
    final variables = {
      "supplier_account": {
        "supplier_id": supplierId,
        "account_number": accountNumberController.text
      }
    };

    final res = await repo.addSupplierAccount(variables);
    Loaders.circularHideLoader(context);

    if (res is Map && res['_error'] != null) {
      final error = res['_error'].toString();
      final isDuplicate = error.contains('duplicate key') ||
          error.contains('constraint-violation') ||
          error.contains('Uniqueness violation');
      showTopMessage(
        context,
        isDuplicate
            ? 'Account already exists for this supplier.'
            : 'Something went wrong. Please try again.',
      );
      return;
    }

    await getSupplierAccounts(context);
    navigationService.goBack();
    scaffoldMessenger('Account added successfully.');
    notifyListeners();
  }

  bool fieldsCheck() {
    return supplierValue != null && accountNumberController.text.isNotEmpty;
  }

  clearAddAccountForm() {
    accountNumberController.clear();
    supplierValue = null;
  }
}
