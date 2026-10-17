import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/account_requests_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/supplier_accounts_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/repository/account_pay_requests_repo_impl.dart';
import 'package:di360_flutter/feature/supplies/model/get_dental_suppliers.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class AccountPayRequestsViewModel extends ChangeNotifier {
  AccountPayRequestsRepoImpl repo = AccountPayRequestsRepoImpl();

  AccountRequestsData? accountRequestsData;
  SupplierAccountData? supplierAccountData;
  DentalSuppliersData? dentalSuppliersData;

  List<SupplierAccounts> _supplierAccountsList = [];
  List<SupplierAccounts> get supplierAccountsList => _supplierAccountsList;

  static const int _saLimit = 10;
  int _saOffset = 0;
  bool saHasMore = true;
  bool saIsLoadingMore = false;

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

  Future<Map<String, dynamic>> _buildSaVariables(
      int offset, String userId, String userType) async =>
      {
        "limit": _saLimit,
        "offset": offset,
        "where": {
          if (userType == UserRole.professional.value)
            "dental_professional_id": {"_eq": userId},
          if (userType == UserRole.practice.value)
            "dental_practice_id": {"_eq": userId}
        }
      };

  Future<void> getSupplierAccounts(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    _saOffset = 0;
    saHasMore = true;
    final variables = await _buildSaVariables(0, userId, userType);
    final res = await repo.getSupplierAccount(variables);
    supplierAccountData = res;
    _supplierAccountsList = res?.supplierAccounts ?? [];
    if (_supplierAccountsList.length < _saLimit) saHasMore = false;
    _saOffset = _supplierAccountsList.length;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> loadMoreSupplierAccounts() async {
    if (!saHasMore || saIsLoadingMore) return;
    saIsLoadingMore = true;
    notifyListeners();
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    final variables = await _buildSaVariables(_saOffset, userId, userType);
    final res = await repo.getSupplierAccount(variables);
    final newItems = res?.supplierAccounts ?? [];
    _supplierAccountsList.addAll(newItems);
    if (newItems.length < _saLimit) saHasMore = false;
    _saOffset += newItems.length;
    saIsLoadingMore = false;
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
    clearAddAccountForm();
    navigationService.goBack();
    scaffoldMessenger('Account added successfully.');
    notifyListeners();
  }

  bool fieldsCheck() {
    return supplierValue != null && accountNumberController.text.isNotEmpty;
  }

  clearAddAccountForm() {
    accountNumberController.text = "";
    supplierValue = null;
  }
}
