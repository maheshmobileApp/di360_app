import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catalogue_view_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_count_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_type_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/add_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/catagorys_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/catalogue_view_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/edit_catalogue_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/get_catalogue_counts_query.dart';
import 'package:di360_flutter/feature/add_catalogues/querys/get_catalogue_type_query.dart';
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
      List<String>? catalogStatus, List<String>? status, int limit, int offset, String selectedStatus,
      {String? type, String? subCatagory, String? searchText}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "limit": limit,
      "offset": offset,
      "where": {
        "_and": [
          if (searchText?.isNotEmpty == true)
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
          if (type?.isNotEmpty == true)
            {
              "catalogue_category": {
                "name": {"_ilike": "%$type%"}
              }
            },
          if (subCatagory?.isNotEmpty == true)
            {
              "catalogue_sub_category": {
                "name": {"_ilike": "%$subCatagory%"}
              }
            },
          (selectedStatus ==
                  "All")
              ? {
                  "_or": [
                    {
                      "status": {
                        "_in":[
                                "APPROVED",
                                "PENDING_APPROVAL",
                                "EXPIRED",
                                "SCHEDULED",
                                "REJECTED",
                                "DRAFT"
                              ]
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
              : {
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
                }
          /*if (status?.isNotEmpty == true)
            {
              "catalogue_status": {
                "_in": status?.isEmpty == true ? ["ACTIVE", "INACTIVE"] : status
              }
            }*/
        ]
      }
    };
    print("variables $variables");
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
  Future<dynamic> inActiveCatalogue(String? id, String? status) async {
    final catalogueData = await http.mutation(InactiveViewQuery, {
      "id": id,
      "updateObj": {"catalogue_status": status}
    });
    return catalogueData;
  }

  @override
  Future<List<CatalogueSubCategories>?> getCatagorys() async {
    final data = await http.query(catagorys_query);
    final result = CatagoriesData.fromJson(data);
    return result.catalogueSubCategories;
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

  @override
  Future<List<CatalogueTypes>?> getCatalogueTypes() async {
    final data = await http.query(getCatalogueTypesQuery);
    final result = CatalogueTypeData.fromJson(data);
    return result.catalogueCategories;
  }
}
