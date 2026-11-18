import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_details_res.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_res.dart';
import 'package:di360_flutter/feature/supplies_enquiries/repository/supplies_enquiries_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class SuppliesEnquiriesViewModel extends ChangeNotifier {
  final SuppliesEnquiriesRepoImpl repo = SuppliesEnquiriesRepoImpl();

  SuppliesEnquiriesData? suppliesEnquiriesData;
  SuppliesEnquiriesDetailsData? suppliesEnquiriesDetailsData;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  bool isFilterApplied = false;

  static const int _enquiriesLimit = 20;
  int _enquiriesOffset = 0;

  Future<void> getSuppliesEnquiries(BuildContext context,
      {bool isLoadMore = false}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (isLoading || isLoadingMore) return;
    if (isLoadMore && !hasMoreData) return;

    if (!isLoadMore) {
      Loaders.circularShowLoader(context);
    }

    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isLoading = true;
      _enquiriesOffset = 0;
      hasMoreData = true;
    }
    notifyListeners();

    try {
      final variables = {
        "sort": [
          {"created_at": "desc"}
        ],
        "andList": [
          {
            "supply": {
              "dental_suppliers_id": {"_eq": userId}
            }
          },
          {
            "supply": {
              "name": {"_ilike": "%t%"}
            }
          }
        ],
        "limit": _enquiriesLimit,
        "offset": _enquiriesOffset
      };

      final variablesTwo = {
        "userId": userId,
        "search": "%%",
        "sort": [
          {"created_at": "desc"}
        ],
        "limit": _enquiriesLimit,
        "offset": _enquiriesOffset
      };
      final res = await repo.getSuppliesEnquiries(
          type == UserRole.supplier.value ? variables : variablesTwo);
      final newEnquiries = res.supplyEnquiries ?? [];

      if (isLoadMore) {
        final existingEnquiries = suppliesEnquiriesData?.supplyEnquiries ?? [];
        suppliesEnquiriesData = SuppliesEnquiriesData(
          supplyEnquiries: [...existingEnquiries, ...newEnquiries],
        );
      } else {
        suppliesEnquiriesData = res;
      }

      _enquiriesOffset += newEnquiries.length;
      hasMoreData = newEnquiries.length == _enquiriesLimit;
    } finally {
      isLoading = false;
      isLoadingMore = false;
      if (!isLoadMore) {
        Loaders.circularHideLoader(context);
      }
      notifyListeners();
    }
  }

  Future<void> suppliesEnquiryDetails(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);

    final variables = {"id": id};
    final res = await repo.getSuppliesEnquiriesDetails(variables);
    suppliesEnquiriesDetailsData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }
}
