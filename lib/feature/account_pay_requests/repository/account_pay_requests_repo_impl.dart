import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/account_requests_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/model/supplier_accounts_res.dart';
import 'package:di360_flutter/feature/account_pay_requests/querys/add_supplier_account_query.dart';
import 'package:di360_flutter/feature/account_pay_requests/querys/get_supplier_accounts_query.dart';
import 'package:di360_flutter/feature/account_pay_requests/querys/supplier_account_requqest_query.dart';
import 'package:di360_flutter/feature/account_pay_requests/repository/account_pay_requests_repository.dart';
import 'package:di360_flutter/feature/supplies/model/get_dental_suppliers.dart';
import 'package:di360_flutter/feature/supplies/queries/get_dental_suppliers_query.dart';

class AccountPayRequestsRepoImpl implements AccountPayRequestsRepository {
  final HttpService http = HttpService();
  @override
  Future<AccountRequestsData> getAccountPayRequests(dynamic variables) async {
    final res =
        await http.query(accountPayRequestsViewQuery, variables: variables);
    return AccountRequestsData.fromJson(res);
  }

  @override
  Future<SupplierAccountData> getSupplierAccount(variables) async {
    final res =
        await http.query(getSupplierAccountsQuery, variables: variables);
    return SupplierAccountData.fromJson(res);
  }

  @override
  Future<DentalSuppliersData> getDentalSuppliers() async {
    final res = await http.query(getDentalSuppliersQuery);
    return DentalSuppliersData.fromJson(res);
  }

  @override
  Future<dynamic> addSupplierAccount(variables) async {
    
    final res = await http.mutation(addSupplierAccountQuery, variables);
    return res;
  }
}
