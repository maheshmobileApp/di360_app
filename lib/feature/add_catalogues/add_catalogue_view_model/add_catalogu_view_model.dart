import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/repository/add_catalogue_repository_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class AddCatalogueViewModel extends ChangeNotifier {
  final AddCatalogueRepositoryImpl repo = AddCatalogueRepositoryImpl();
  String selectedStatus = 'All';

  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Approved & Scheduled',
    'Expired',
    'Reject'
  ];

  final Map<String, int> counts = {
    'All': 10,
    'Draft': 0,
    'Pending Approval': 1,
    'Approved & Scheduled': 1,
    'Expired': 0,
    'Reject': 2,
  };

  List<String>? catalogStatus = [];

  List<Catalogues>? myCatalogueList;

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;

    if (status == 'All') {
      catalogStatus = [
        "APPROVED",
        "PENDING_APPROVAL",
        "EXPIRED",
        "SCHEDULED",
        "REJECTED",
        "DRAFT"
      ];
    } else if (status == 'Draft') {
      catalogStatus = ['DRAFT'];
    } else if (status == 'Pending Approval') {
      catalogStatus = ['PENDING_APPROVAL'];
    } else if (status == 'Approved & Scheduled') {
      catalogStatus = ["APPROVED", "SCHEDULED"];
    } else if (status == 'Expired') {
      catalogStatus = ['EXPIRED'];
    } else if (status == 'Reject') {
      catalogStatus = ['REJECTED'];
    }

    getMyCataloguesData(context);
    notifyListeners();
  }

  Future<void> getMyCataloguesData(BuildContext context) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    final res = await repo.getMyCatalogues({
      "limit": 70,
      "offset": 0,
      "searchTitle": "%%",
      "searchCategory": "%%",
      "searchCompany": "%%",
      "status": catalogStatus?.isEmpty == true
          ? [
              "APPROVED",
              "PENDING_APPROVAL",
              "EXPIRED",
              "SCHEDULED",
              "REJECTED",
              "DRAFT"
            ]
          : catalogStatus,
      "dental_supplier_id": id
    });
    Loaders.circularHideLoader(context);
    myCatalogueList = res;
    notifyListeners();
  }
}
