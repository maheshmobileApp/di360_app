import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catalogue_view_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_count_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';

abstract class AddCatalogueRepository {
  Future<dynamic> addCatalogue(dynamic variables);
  Future<List<Catalogues>?> getMyCatalogues(dynamic variables);
  Future<CataloguesByPk?> cataloguView(String? id);
  Future<void> removeCatalogue(String? id);
  Future<void> sendApprovalCatalogue(String? id);
  Future<void> inActiveCatalogue(String? id);
  Future<List<CatalogueCategories>?> getCatagorys();
  Future<dynamic> editCatalogue(dynamic variables);
  Future<CatalogueCountData> catalogueCounts();
}