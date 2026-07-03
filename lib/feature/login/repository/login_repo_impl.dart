import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_community_owner_res.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_model.dart';
import 'package:di360_flutter/feature/login/query/get_directory_query.dart';
import 'package:di360_flutter/feature/login/query/get_my_community_data_query.dart';
import 'package:di360_flutter/feature/login/query/get_supplier_community_owner_query.dart';
import 'package:di360_flutter/feature/login/query/get_supplier_query.dart';
import 'package:di360_flutter/feature/login/query/login_querys.dart';
import 'package:di360_flutter/feature/login/query/update_device_token_query.dart';
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

  @override
  Future updateDeviceToken(dynamic variables) async {
    final res = await http.post("/api/v1/auth/fcm-token", variables);
    return res;
  }

  @override
  Future<dynamic> getDirectory() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await http.query(getDirectorQuery, variables: {"id": userId});
    return res;
  }

  @override
  Future<dynamic> login(dynamic _variables) async {
    final res = await http.mutation(loginSchema, _variables);
    return res;
  }

  @override
  Future<dynamic> getMyCommunityData(String userId) async {
    final res = await http.query(getMyCommunityDataQuery, variables: {
      "where": {
        "member_id": {"_eq": userId},
        "status": {"_eq": "APPROVED"}
      }
    });
    return res;
  }
}
