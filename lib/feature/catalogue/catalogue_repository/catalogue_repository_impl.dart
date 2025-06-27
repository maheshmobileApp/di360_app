import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_by_id_request.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_repository/catalogue_repository.dart';
import 'package:di360_flutter/feature/catalogue/get_catalogue_request.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';

class CatalogueRepositoryImpl extends CatalogueRepository {
  final HttpService http = HttpService();

  @override
  Future<List<CatalogueCategories>> getCatalogue() async {
    final catalogueData = await http.query(getCatalogueRequest, variables: {
      "andList": [
        {
          "_or": [
            {
              "dental_supplier": {
                "name": {"_ilike": "%%"}
              }
            },
            {
              "title": {"_ilike": "%%"}
            }
          ],
          "status": {
            "_in": ["APPROVED", "SCHEDULED"]
          }
        }
      ],
      "limit": 50,
      "offset": 0
    });
    final result = CatalogueData.fromJson(catalogueData);
    return result.catalogueCategories ?? [];
  }

  @override
  Future<CataloguesByPk?> getCatalogueById(String catalogId) async {
    final catalogueData = await http.query(catalogueByIdRequest,
        variables: {"id": catalogId});
    final result = CatalogueByIdData.fromJson(catalogueData);
    return result.cataloguesByPk;
  }
}
