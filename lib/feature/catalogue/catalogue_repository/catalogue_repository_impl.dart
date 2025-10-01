import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/model_class/filter_suppliers_res.dart';
import 'package:di360_flutter/feature/catalogue/querys/add_like_catalogue_query.dart';
import 'package:di360_flutter/feature/catalogue/querys/catalogue_by_id_request.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_repository/catalogue_repository.dart';
import 'package:di360_flutter/feature/catalogue/querys/filter_supplier_query.dart';
import 'package:di360_flutter/feature/catalogue/querys/get_catalogue_request.dart';
import 'package:di360_flutter/feature/catalogue/querys/get_related_catalogues.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_by_id_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/querys/remove_like_catalogue_query.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class CatalogueRepositoryImpl extends CatalogueRepository {
  final HttpService http = HttpService();

  @override
  Future<List<CatalogueCategories>> getCatalogue(
      String? searchText,
      String? typeId,
      List<String>? categories,
      List<String>? suppliers,
      String loginId) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final catalogueData = await http.query(getCatalogueQuery, variables: {
      "categoryWhere": {
        "status": {"_eq": "ACTIVE"},
        "catalogues": {
          "dental_supplier": {
            "name": {"_ilike": "%%"}
          }
        }
      },
      "catalogueWhere": {
        "status": {
          "_in": ["APPROVED", "SCHEDULED"]
        },
        "catalogue_status": {"_eq": "ACTIVE"},
        if (typeId != null && typeId.isNotEmpty)
          "catalogue_category_id": {"_eq": typeId},
        if (suppliers != null && suppliers.isNotEmpty)
          "dental_supplier": {
            "name": {"_in": suppliers}
          },
        if (categories != null && categories.isNotEmpty)
          "catalogue_sub_category": {
            "id": {"_in": categories}
          },
        if (searchText != null && searchText.isNotEmpty)
          "dental_supplier": {
            "name": {"_ilike": "%$searchText%"}
          },
        if (loginId != '' && loginId.isNotEmpty)
          "catalogue_favorites": {
            if (type == 'SUPPLIER') "dental_supplier_id": {"_eq": loginId},
            if (type == 'PRACTICE') "dental_practice_id": {"_eq": loginId},
            if (type == 'PROFESSIONAL')
              "dental_professional_id": {"_eq": loginId}
          }
      }
    });
    if (catalogueData != null) {
      final result = CatalogueData.fromJson(catalogueData);
      return result.catalogueCategories ?? [];
    } else {
      return [];
    }
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
  Future<List<DentalSuppliers>?> getFilterSuppliers() async {
    final data = await http.query(filterSuppilerQuery);
    final result = FilterSuppliersData.fromJson(data);
    return result.dentalSuppliers;
  }

  @override
  Future<dynamic> addLikeCatalogue(String? catalogueId) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userRole = UserRole.fromString(type);
    final data = await http.mutation(addLikeCatalogueQuery, {
      "favObj": {
        "catalogue_id": catalogueId,
        "type": type,
        "dental_supplier_id": userRole == UserRole.supplier ? userId : null,
        "dental_professional_id":
            userRole == UserRole.professional ? userId : null,
        "dental_practice_id": userRole == UserRole.practice ? userId : null,
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
