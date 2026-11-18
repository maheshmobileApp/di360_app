import 'package:di360_flutter/feature/supllies_module/model/all_supplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/approve_supplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/draft_suplies_count.dart';
import 'package:di360_flutter/feature/supllies_module/model/supplies_detail_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_brands_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_categories_res.dart';
import 'package:di360_flutter/feature/supllies_module/model/supply_sub_categories_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';

abstract class SuppliesModuleRepository {
  Future<GetSupplyData> getSuppliesList(dynamic variables);
  Future<SupplyBrandsData> getSupplyBrands();
  Future<SupplyCategoriesData> getSupplyCategories();
  Future<SupplySubCategoriesData> getSupplySubCategories();
  Future<AllSuppliesData> getAllSuppliesCount(dynamic variables);
  Future<DraftSuppliesData> getDraftSuppliesCount(dynamic variables);
  Future<ApproveSuppliesData> getApproveSuppliesCount(dynamic variables);
  Future<SuppliesDetailData> getSuppliesDetails(dynamic variables);
}
