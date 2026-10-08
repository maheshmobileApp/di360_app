import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/account_requests_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/supplier_accounts_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/repository/account_pay_requests_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class AccountPayRequestsViewModel extends ChangeNotifier {
  AccountPayRequestsRepoImpl repo = AccountPayRequestsRepoImpl();

  AccountRequestsData? accountRequestsData;
  SupplierAccountData? supplierAccountData;

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
}
