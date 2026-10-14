import 'package:di360_flutter/feature/account_pay_requests/model/account_requests_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/supplier_accounts_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_dental_suppliers.dart';

abstract class AccountPayRequestsRepository {
  Future<AccountRequestsData> getAccountPayRequests(dynamic variables);
  Future<SupplierAccountData> getSupplierAccount(dynamic variables);
  Future<DentalSuppliersData> getDentalSuppliers();
  Future<dynamic> addSupplierAccount(dynamic variables);
}
