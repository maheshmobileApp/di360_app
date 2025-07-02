import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_suppliers_res.dart';
import 'package:di360_flutter/feature/catalogue/querys/add_like_catalogue_query.dart';
import 'package:di360_flutter/feature/catalogue/querys/catalogue_by_id_request.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_repository/catalogue_repository.dart';
import 'package:di360_flutter/feature/catalogue/querys/filter_catagories_query.dart';
import 'package:di360_flutter/feature/catalogue/querys/filter_supplier_query.dart';
import 'package:di360_flutter/feature/catalogue/querys/get_catalogue_request.dart';
import 'package:di360_flutter/feature/catalogue/querys/get_related_catalogues.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_catagories_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/querys/remove_like_catalogue_query.dart';

class CatalogueRepositoryImpl extends CatalogueRepository {
  final HttpService http = HttpService();

  String? professionId;
  String? supplierId;
  String? practiceId;
  String? adminId;

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
    final catalogueData =
        await http.query(catalogueByIdRequest, variables: {"id": catalogId});
    final result = CatalogueByIdData.fromJson(catalogueData);
    return result.cataloguesByPk;
  }

  @override
  Future<List<CatalogData>?> getRelatedCatalogues(String catalogueId) async {
    final catalogueData = await http
        .query(getRelatedCatalogQuery, variables: {"id": catalogueId});
    final result = ReletedCataloguData.fromJson(catalogueData);
    return result.catalogues;
  }

  @override
  Future<List<FilterCategories>?> getFilterCatagories() async {
    final data = await http.query(filterCategoriesQuery);
    final result = CatagoriesData.fromJson(data);
    return result.catalogueCategories;
  }

  @override
  Future<List<DentalSuppliers>?> getFilterSuppliers() async {
    final data = await http.query(filterSuppilerQuery);
    final result = FilterSuppliersData.fromJson(data);
    return result.dentalSuppliers;
  }

  @override
  Future<dynamic> addLikeCatalogue(String? catalogueId) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final data = await http.mutation(addLikeCatalogueQuery, {
      "favObj": {
        "catalogue_id": catalogueId,
        "type": type,
        "dental_supplier_id": type == 'SUPPLIER' ? userId : null,
        "dental_professional_id": type == 'PROFESSIONAL' ? userId : null,
        "dental_practice_id": type == 'PRACTICE' ? userId : null,
      }
    });
    return data;
  }

  @override
  Future<dynamic> removeLikeCatalogue(String? catalogueId) async {
    final data =
        await http.mutation(removeLikeCatalogueQuery, {"id": catalogueId});
    return data;
  }
}
