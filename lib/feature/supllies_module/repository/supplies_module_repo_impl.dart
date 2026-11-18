import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/supllies_module/model/all_supplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/approve_supplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/draft_suplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/supplies_detail_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_brands_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_sub_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supplies_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supply_brands_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supply_categories_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/get_supply_sub_categories_query.dart';
import 'package:di360_flutter/feature/supllies_module/querys/supplies_aggregate.dart';
import 'package:di360_flutter/feature/supllies_module/querys/supplies_detail_query.dart';
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
  Future<SupplyCategoriesData> getSupplyCategories() async {
    final res = await http.query(getSupplyCategoriesQuery);
    return SupplyCategoriesData.fromJson(res);
  }

  @override
  Future<SupplySubCategoriesData> getSupplySubCategories() async {
    final res = await http.query(getSupplySubCategoriesQuery);
    return SupplySubCategoriesData.fromJson(res);
  }

  @override
  Future<AllSuppliesData> getAllSuppliesCount(dynamic variables) async {
    final res = await http.query(suppliesAggregateQuery, variables: variables);
    return AllSuppliesData.fromJson(res);
  }

  @override
  Future<ApproveSuppliesData> getApproveSuppliesCount(dynamic variables) async {
    final res =
        await http.query(suppliesApproveAgrregateQuery, variables: variables);
    return ApproveSuppliesData.fromJson(res);
  }

  @override
  Future<DraftSuppliesData> getDraftSuppliesCount(dynamic variables) async {
    final res =
        await http.query(suppliesDraftAgrregateQuery, variables: variables);
    return DraftSuppliesData.fromJson(res);
  }

  @override
  Future<SuppliesDetailData> getSuppliesDetails(variables) async {
     final res =
        await http.query(suppliesDetailQuery, variables: variables);
    return SuppliesDetailData.fromJson(res);
  }
}
