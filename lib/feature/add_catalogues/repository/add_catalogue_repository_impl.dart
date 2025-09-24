import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catalogue_view_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_count_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/add_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/catagorys_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/catalogue_view_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/edit_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/get_catalogue_counts_query.dart';
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
  Future<List<Catalogues>?> getMyCatalogues(
      List<String>? catalogStatus, List<String>? status) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final catalogueData = await http.query(getMyCatalogueQuery, variables: {
      "limit": 100,
      "offset": 0,
      "where": {
        "_and": [
          {
            "_and": [
              {
                "title": {"_ilike": "%%"}
              }
            ]
          },
          {
            "dental_supplier_id": {"_eq": userId}
          },
          {
            "_or": [
              {
                "status": {
                  "_in": catalogStatus?.isEmpty == true
                      ? [
                          "APPROVED",
                          "PENDING_APPROVAL",
                          "EXPIRED",
                          "SCHEDULED",
                          "REJECTED",
                          "DRAFT"
                        ]
                      : catalogStatus
                }
              },
              if (status?.isNotEmpty == true)
                {
                  "catalogue_status": {
                    "_in": status?.isEmpty == true
                        ? ["ACTIVE", "INACTIVE"]
                        : status
                  }
                }
            ]
          }
        ]
      }
    });
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
  Future<dynamic> editCatalogue(variables) async {
    final data = await http.mutation(editCatalogueQuery, variables);
    return data;
  }

  @override
  Future<CatalogueCountData> catalogueCounts() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final data = await http.query(GetCatalogueCountsQuery,
        variables: {"dental_supplier_id": userId});
    final result = CatalogueCountData.fromJson(data);
    return result;
  }
}
