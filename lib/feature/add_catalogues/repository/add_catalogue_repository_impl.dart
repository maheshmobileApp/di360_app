import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catalogue_view_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/add_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/catagorys_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/catalogue_view_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/edit_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/get_my_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/inactive_view_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/remove_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/send_approval_query.dart';
import 'package:di360_flutter/feature/add_catalogues/repository/add_catalogue_repository.dart';

class AddCatalogueRepositoryImpl extends AddCatalogueRepository {
  final HttpService http = HttpService();

  @override
  Future<dynamic> addCatalogue(dynamic variables) async {
    final data = await http.mutation(addCatalogueQuery, variables);
    return data;
  }

  @override
  Future<List<Catalogues>?> getMyCatalogues(dynamic variables) async {
    final catalogueData =
        await http.query(getMyCatalogueQuery, variables: variables);
    final result = MyCataloguesData.fromJson(catalogueData);
    return result.catalogues ?? [];
  }

  @override
  Future<CataloguesByPk?> cataloguView(String? id) async {
    final catalogueData =
        await http.query(catalogueViewQuery, variables: {"id": id});
    final result = CatalogData.fromJson(catalogueData);
    return result.cataloguesByPk;
  }

  @override
  Future<dynamic> removeCatalogue(String? id) async {
    final catalogueData = await http.mutation(removeCatalogueQuery, {"id": id});
    return catalogueData;
  }

  @override
  Future<dynamic> sendApprovalCatalogue(String? id) async {
    final isoString = DateTime.now().toUtc().toIso8601String();
    final catalogueData = await http.mutation(send_approval_query, {
      "id": id,
      "updateObj": {"status": "PENDING_APPROVAL", "pending_at": isoString}
    });
    return catalogueData;
  }

  @override
  Future<dynamic> inActiveCatalogue(String? id) async {
    final catalogueData = await http.mutation(InactiveViewQuery, {
      "id": id,
      "updateObj": {"catalogue_status": "INACTIVE"}
    });
    return catalogueData;
  }

  @override
  Future<List<CatalogueCategories>?> getCatagorys() async {
    final data = await http.query(catagorys_query, variables: {
      "andList": [
        {
          "status": {
            "_in": ["APPROVED", "PENDING_APPROVAL", "SCHEDULED"]
          }
        }
      ]
    });
    final result = CatagoryData.fromJson(data);
    return result.catalogueCategories;
  }
  
  @override
  Future<dynamic> editCatalogue(variables) async{
    final data = await http.mutation(editCatalogueQuery, variables);
    return data;
  }
}
