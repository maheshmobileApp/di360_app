import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_brands_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_sub_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supplies_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supply_brands_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supply_categories_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supply_sub_categories_query.dart';
import 'package:di360_flutter/feature/supllies_module/repository/supplies_module_repository.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';

class SuppliesModuleRepoImpl implements SuppliesModuleRepository {
  final http = HttpService();

  @override
  Future<GetSupplyData> getSuppliesList(variables) async {
    final res = await http.query(getSuppliesQuery, variables: variables);
    return GetSupplyData.fromJson(res);
  }

  @override
  Future<SupplyBrandsData> getSupplyBrands() async {
    final res = await http.query(getSupplyBrandsQuery);
    return SupplyBrandsData.fromJson(res);
  }

  @override
  Future<SupplyCategoriesData> getSupplyCategories()  async {
    final res = await http.query(getSupplyCategoriesQuery);
    return SupplyCategoriesData.fromJson(res);
  }
  @override
  Future<SupplySubCategoriesData> getSupplySubCategories()  async {
    final res = await http.query(getSupplySubCategoriesQuery);
    return SupplySubCategoriesData.fromJson(res);
  }
}
