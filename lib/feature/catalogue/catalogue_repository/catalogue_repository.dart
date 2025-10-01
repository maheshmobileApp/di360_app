import 'package:di360_flutter/feature/catalogue/model_class/filter_suppliers_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';

abstract class CatalogueRepository {
  Future<List<CatalogueCategories>> getCatalogue(
    String? searchText,String? typeId,List<String>? categories,List<String>? suppliers,String loginId);
  Future<CataloguesByPk?> getCatalogueById(String catalogueId);
  Future<List<CatalogData>?> getRelatedCatalogues(String catalogueId);
  Future<List<DentalSuppliers>?> getFilterSuppliers();
  Future<dynamic> addLikeCatalogue(String? catalogueId);
  Future<dynamic> removeLikeCatalogue(String? catalogueId);
}
