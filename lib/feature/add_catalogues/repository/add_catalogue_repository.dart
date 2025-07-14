import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';

abstract class AddCatalogueRepository {
  Future<void> addCatalogue(String catalogueName);
  Future<List<Catalogues>?> getMyCatalogues(dynamic variables);
}