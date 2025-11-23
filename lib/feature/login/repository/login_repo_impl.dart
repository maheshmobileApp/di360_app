import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_community_owner_res.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_model.dart';
import 'package:di360_flutter/feature/login/query/get_supplier_community_owner_query.dart';
import 'package:di360_flutter/feature/login/query/get_supplier_query.dart';
import 'package:di360_flutter/feature/login/repository/login_repository.dart';

class LoginRepoImpl extends LoginRepository {
  final HttpService http = HttpService();
  @override
  Future<GetSupplierData> getSuppliers(String id) async {
    final variables = {"id": id};

    final res = await http.query(getSupplierQuery, variables: variables);
    final data = GetSupplierData.fromJson(res);
    return data;
  }

  @override
  Future<GetSupplierCommunityOwnerData> getSupplierCommunityOwner(
      String id) async {
    final variables = {"dental_supplier_id": id};

    final res =
        await http.query(getSupplierCommunityOwnerQuery, variables: variables);
    final data = GetSupplierCommunityOwnerData.fromJson(res);
    return data;
  }
}
