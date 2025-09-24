import 'dart:io';
import 'dart:ui' as ui;
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/repository/banner_repository_impl.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BannersViewModel extends ChangeNotifier {
  final BannerRepositoryImpl repo = BannerRepositoryImpl();
  final HttpService _http = HttpService();
  BannersViewModel() {
    getBannerCategoryData();
  }
  File? selectedPresentedImg;
  TextEditingController bannerNameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  List<BannerCategories>? catagorysList;
  BannerCategories? selectedCatagory;
  List<Banners>? bannersList;
  dynamic bannner_image;
  dynamic banner_name;
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
  File? bannerFile;
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
        "PENDING",
        "EXPIRED",
        "SCHEDULED",
        "REJECTED",
        "DRAFT"
      ];
    } else if (status == 'Draft') {
      catalogStatus = ['DRAFT'];
    } else if (status == 'Pending Approval') {
      catalogStatus = ['PENDING'];
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

  Future<ui.Size?> getImageSize(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);
      return ui.Size(image.width.toDouble(), image.height.toDouble());
    } catch (e) {
      print("Error reading image size: $e");
      return null;
    }
  }

  bool checkDimensions(ui.Size? actual, String? requiredDim) {
    if (requiredDim == null || actual == null) return true; // no restriction
    try {
      final parts = requiredDim.split('*');
      final requiredWidth = double.parse(parts[0]);
      final requiredHeight = double.parse(parts[1]);
      return actual.width == requiredWidth && actual.height == requiredHeight;
    } catch (e) {
      print("Error parsing required dimensions: $e");
      return true;
    }
  }

  Future<void> getBannersList(BuildContext context) async {
    // Loaders.circularShowLoader(context);
    final res = await repo.getMyBanners({
      "where": {
        "status": {
          "_in": catalogStatus?.isEmpty == true
              ? [
                  "APPROVED",
                  "PENDING",
                  "EXPIRED",
                  "SCHEDULED",
                  "REJECTED",
                  "DRAFT"
                ]
              : catalogStatus,
        },
        "category_name": {"_ilike": "%all%"}
      },
      "limit": 70,
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

  Future<void> validateBannerImg() async {
    var value = await _http.uploadImage(selectedPresentedImg?.path);
    bannner_image = value['url'];
    banner_name = value['name'];
    print(bannner_image);
    print(banner_name);
    notifyListeners();
  }

//add banner
  Future<void> addBannersData(BuildContext context) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    Loaders.circularShowLoader(context);
    await validateBannerImg();
    final res = await repo.addBanners({
      "banner": {
        "image": [
          {
            "url": bannner_image,
            "name": banner_name,
            "type": "image",
            "extension": "jpeg"
          }
        ],
        "status": "PENDING",
        "banner_name": bannerNameController.text,
        "category_name": selectedCatagory?.name,
        "from_id": id,
        "views": 9,
        "company_name": name,
        "url": urlController.text,
        "schedule_date":
            '${scheduleDate?.year}-${scheduleDate?.month}-${scheduleDate?.day}',
        "expiry_date":
            '${expiryDate?.year}-${expiryDate?.month}-${expiryDate?.day}'
      }
    });
    print("resppppp${res}");
    if (res != null) {
      Loaders.circularHideLoader(context);
      navigationService.goBack();
      clearAddBannerData();
      getBannersList(navigatorKey.currentContext!);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  //deleteBanner
  Future<void> removeBanner(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.deleteBanner(id);
    if (res != null) {
      scaffoldMessenger('Banner removed successfully');
      Loaders.circularHideLoader(context);
      getBannersList(context);
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  //clere fields
  clearAddBannerData() {
    bannerNameController.clear();
    urlController.clear();
    selectedCatagory = null;
    scheduleDate = null;
    expiryDate = null;

    notifyListeners();
  }
}
