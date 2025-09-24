import 'dart:io';
import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/repository/banner_repository_impl.dart';
import 'package:flutter/material.dart';

class BannersViewModel extends ChangeNotifier {
  final BannerRepositoryImpl repo = BannerRepositoryImpl();
  BannersViewModel() {
    getBannerCategoryData();
    
  }
  File? selectedPresentedImg;
  TextEditingController bannerNameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  List<BannerCategories>? catagorysList;
  BannerCategories? selectedCatagory;
  List<Banners>? bannersList;
  void updateSelectedCatagory(BannerCategories? catagory) {
    selectedCatagory = catagory;
    notifyListeners();
  }

  String selectedStatus = 'All';
  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Approved & Scheduled',
    'Expired',
    'Reject'
  ];
  List<String>? catalogStatus = [];
  int? allCatalogueCount = 0;
  int? draftCatalogueCount = 0;
  int? pendingApprovalCatalogueCount = 0;
  int? approvedScheduledCatalogueCount = 0;
  int? expiredCatalogueCount = 0;
  int? rejectCatalogueCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': allCatalogueCount,
        'Draft': draftCatalogueCount,
        'Pending Approval': pendingApprovalCatalogueCount,
        'Approved & Scheduled': approvedScheduledCatalogueCount,
        'Expired': expiredCatalogueCount,
        'Reject': rejectCatalogueCount,
      };
  DateTime? scheduleDate;
  DateTime? expiryDate;

  void setScheduleDate(DateTime date) {
    scheduleDate = date;
    if (expiryDate != null &&
        expiryDate!.isBefore(expiryDate!.add(const Duration(days: 1)))) {
      expiryDate = null;
    }
    notifyListeners();
  }

  void setExpiryDate(DateTime date) {
    expiryDate = date;
    notifyListeners();
  }

  void setPresentedImg(File? value) {
    selectedPresentedImg = value;
    notifyListeners();
  }

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

    getBannersList(context);
    notifyListeners();
  }

  Future<void> getBannerCategoryData() async {
    catagorysList = await repo.bannerCategotyList();
    print("redp${catagorysList}");
    notifyListeners();
  }

 Future<void> getBannersList(BuildContext context) async {
   // Loaders.circularShowLoader(context);
  final res = await repo.getMyBanners({
    "where": {
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
            : catalogStatus,
      },
      "category_name": {"_ilike": "%all%"}
    },
    "limit": 10,
    "offset": 0
  });
 if (res != null) {
     bannersList = res;
   print("REEEEE${bannersList}");
    //  Loaders.circularHideLoader(context);
    } else {
     // Loaders.circularHideLoader(context);
    }
  notifyListeners();
}

}
