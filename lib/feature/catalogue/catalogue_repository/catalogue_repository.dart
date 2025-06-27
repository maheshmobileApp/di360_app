import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';

abstract class CatalogueRepository {
  Future<List<CatalogueCategories>> getCatalogue();
  Future<CataloguesByPk?> getCatalogueById(String catalogueId);
}