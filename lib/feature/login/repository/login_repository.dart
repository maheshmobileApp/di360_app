import 'package:di360_flutter/feature/login/model_class/get_supplier_community_owner_res.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_model.dart';

abstract class LoginRepository {

  Future<GetSupplierData> getSuppliers(String id);
  Future<GetSupplierCommunityOwnerData> getSupplierCommunityOwner(String id);

}