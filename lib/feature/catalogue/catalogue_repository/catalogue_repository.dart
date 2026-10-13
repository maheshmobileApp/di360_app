import 'package:di360_flutter/feature/catalogue/model_class/catalogue_filter_suppliers.dart';
import 'package:di360_flutter/feature/catalogue/model_class/catalouges_list.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_suppliers_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';

abstract class CatalogueRepository {
  Future<List<CatalogueCategories>> getCatalogue(
      String? searchText,
      String? typeId,
      List<String>? categories,
      List<String>? suppliers,
      String loginId,
      {bool? isCommunityCatalogue});
  Future<CataloguesByPk?> getCatalogueById(String catalogueId);
  Future<List<CatalogData>?> getRelatedCatalogues(String catalogueId);
  Future<CatalogueFilterSupplierData> getFilterSuppliers();
  Future<dynamic> addLikeCatalogue(String? catalogueId);
  Future<dynamic> removeLikeCatalogue(String? catalogueId);
  Future<CatalougesListData> getCatalougesList(dynamic variables);
}
