import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/get_my_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/repository/add_catalogue_repository.dart';

class AddCatalogueRepositoryImpl extends AddCatalogueRepository {
  final HttpService http = HttpService();
  @override
  Future<void> addCatalogue(String catalogueName) {
    // TODO: implement addCatalogue
    throw UnimplementedError();
  }

  @override
  Future<List<Catalogues>?> getMyCatalogues(dynamic variables) async {
    final catalogueData =
        await http.query(getMyCatalogueQuery, variables: variables);
    final result = MyCataloguesData.fromJson(catalogueData);
    return result.catalogues ?? [];
  }
}
