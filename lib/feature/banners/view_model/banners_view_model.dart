import 'dart:io';
import 'dart:ui' as ui;
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/banners/model/edit_banner_model.dart';
import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/repository/banner_repository_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class BannersViewModel extends ChangeNotifier {
  final BannerRepositoryImpl repo = BannerRepositoryImpl();
  final HttpService _http = HttpService();

  File? selectedBannerImg;
  TextEditingController bannerNameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  List<BannerCategories> catagorysList = [];
  BannerCategories? selectedCatagory;
  List<Banners> bannersList = [];
  String? banner_image;
  dynamic banner_name;
  BannersByPk? bannerView;
  String? editBannerId;
  bool isEditBanner = false;
  bool isRelistBanner = false;
  String? existingBannerImageUrl;
  String? requiredDimension;

  getBannerData(BuildContext context) {
    getBannersList(context);
    getBannerCategoryData();
  }

  void updateSelectedCatagory(BannerCategories? catagory) {
    selectedCatagory = catagory;
    requiredDimension = catagory?.dimensions;
    if (!isEditBanner && !isRelistBanner) {
      selectedBannerImg = null;
    }
    notifyListeners();
  }
  // void updateSelectedCatagory(BannerCategories category) {
  //   selectedCatagory = category;
  //   requiredDimension = category.dimensions; // store dimension
  //   selectedPresentedImg = null; // reset old image
  //   notifyListeners();
  // }

  void updateEditBannerVal(bool val) {
    isEditBanner = val;
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
  List<String>? bannersStatus = [];
  int? allBannersCount = 0;
  int? draftBannersCount = 0;
  int? pendingApprovalBannersCount = 0;
  int? approvedScheduledBannersCount = 0;
  int? expiredBannersCount = 0;
  int? rejectBannersCount = 0;
  File? bannerFile;
  Map<String, int> get statusCountMap => {
        'All': allBannersCount ?? 0,
        'Draft': draftBannersCount ?? 0,
        'Pending Approval': pendingApprovalBannersCount ?? 0,
        'Approved & Scheduled': approvedScheduledBannersCount ?? 0,
        'Expired': expiredBannersCount ?? 0,
        'Reject': rejectBannersCount ?? 0,
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
    selectedBannerImg = value;
    serverBannerImg = null;
    notifyListeners();
  }

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'All') {
      bannersStatus = [
        "APPROVED",
        "PENDING",
        "EXPIRED",
        "SCHEDULED",
        "REJECTED",
        "DRAFT"
      ];
    } else if (status == 'Draft') {
      bannersStatus = ['DRAFT'];
    } else if (status == 'Pending Approval') {
      bannersStatus = ['PENDING'];
    } else if (status == 'Approved & Scheduled') {
      bannersStatus = ["APPROVED", "SCHEDULED"];
    } else if (status == 'Expired') {
      bannersStatus = ['EXPIRED'];
    } else if (status == 'Reject') {
      bannersStatus = ['REJECTED'];
    }
    getBannersList(context);

    notifyListeners();
  }

  Future<void> getBannersCounts() async {
    final res = await repo.bannersCounts();
    allBannersCount = res.aLL?.aggregate?.count;
    pendingApprovalBannersCount = res.pending?.aggregate?.count;
    draftBannersCount = res.draft?.aggregate?.count;
    approvedScheduledBannersCount = res.approved?.aggregate?.count;
    expiredBannersCount = res.expired?.aggregate?.count;
    rejectBannersCount = res.rejected?.aggregate?.count;
    notifyListeners();
  }

  Future<void> getBannerCategoryData() async {
    catagorysList = await repo.bannerCategotyList();
    notifyListeners();
  }

//based on image
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
    Loaders.circularShowLoader(context);

    try {
      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      await getBannersCounts();

      final variables = {
        "where": {
          "status": {
            "_in": bannersStatus?.isEmpty == true
                ? [
                    "APPROVED",
                    "PENDING",
                    "EXPIRED",
                    "SCHEDULED",
                    "REJECTED",
                    "DRAFT"
                  ]
                : bannersStatus,
          },
          "from_id": {"_eq": userId}
        },
        "limit": 10000,
        "offset": 0,
      };

      final res = await repo.getMyBanners(variables);

      if (res != null) {
        bannersList = res;
        Loaders.circularHideLoader(context);
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading banners: $e");
    } finally {
      if (context.mounted) {
        Loaders.circularHideLoader(context);
      }
    }
  }

  void setBannerImage(String value) {
    serverBannerImg = value;
    notifyListeners();
  }

  void setBannerName(String value) {
    banner_name = value;
    notifyListeners();
  }

  String? serverBannerImg;
  Future<void> validateBannerImg() async {
    if (serverBannerImg == null) {
      if (selectedBannerImg?.path != null) {
        var value = await _http.uploadImage(selectedBannerImg?.path);
        if (value != null) {
          banner_image = value['url'];
          banner_name = value['name'];
        }
      }
    } else {
      banner_image = serverBannerImg ?? "";
    }
    notifyListeners();
  }

//add banner
  Future<void> addBannersData(BuildContext context, bool isDarft) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    Loaders.circularShowLoader(context);
    await validateBannerImg();

    final scheduleStr = scheduleDate != null ? DateFormatUtils.formatToYyyyMmDd(scheduleDate!) : null;
    final expiryStr = expiryDate != null ? DateFormatUtils.formatToYyyyMmDd(expiryDate!) : null;

    final res = await repo.addBanners({
      "fields": {
        "image": [
          {
            "url": banner_image,
            "name": banner_name,
            "type": "image",
            "extension": "jpeg"
          }
        ],
        "status": isDarft ? "DRAFT" : "PENDING",
        "banner_name": bannerNameController.text,
        "category_name": selectedCatagory?.name,
        "from_id": id,
        "company_name": name,
        "url": urlController.text,
        "schedule_date": scheduleStr,
        "expiry_date": expiryStr
      }
    });
    if (res != null) {
      Loaders.circularHideLoader(context);
      await getBannersList(context);

      navigationService.goBack();
      clearAddBannerData();
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

  //data assign in editfields
  assignTheSelectedCatagory(String? name) {
    if (name == null || name.isEmpty) return;
    try {
      final obj = catagorysList.firstWhere(
        (v) => v.name == name,
        orElse: () => catagorysList.first,
      );
      updateSelectedCatagory(obj);
    } catch (e) {
      debugPrint("Category not found: $name");
    }
    notifyListeners();
  }

  void setEditBannerId(String? id) {
    editBannerId = id;
    notifyListeners();
  }

  Future<void> editDataAssign(BannersByPk? bannersView) async {
    bannerNameController.text = bannersView?.bannerName ?? '';
    assignTheSelectedCatagory(bannersView?.categoryName);
    setEditBannerId(bannersView?.id ?? "");
    if (bannersView?.image != null && bannersView?.image?.isNotEmpty == true) {
      setBannerImage(bannersView?.image?.first.url ?? "");
      setBannerName(bannersView?.image?.first.name ?? "");
    }
    urlController.text = bannersView?.url ?? "";

    if (bannersView?.scheduleDate != null &&
        bannersView?.scheduleDate?.isNotEmpty == true) {
      try {
        scheduleDate = DateTime.parse(bannersView?.scheduleDate ?? "");
      } catch (e) {
        scheduleDate = null;
      }
    }

    if (bannersView?.expiryDate != null &&
        bannersView?.expiryDate?.isNotEmpty == true) {
      try {
        expiryDate = DateTime.parse(bannersView?.expiryDate ?? "");
      } catch (e) {
        expiryDate = null;
      }
    }

    notifyListeners();
  }

  Future<void> editBannerNavigator(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.editBannerView(id);
    if (res != null) {
      bannerView = res;
      updateEditBannerVal(true);
      editDataAssign(res);
      Loaders.circularHideLoader(context);
      navigationService.navigateTo(RouteList.addBanners);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  //update Banner
  Future<void> updateBannerData(BuildContext context, bool isDarft) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    Loaders.circularShowLoader(context);
    await validateBannerImg();

    final scheduleStr = scheduleDate != null ? DateFormatUtils.formatToYyyyMmDd(scheduleDate!) : null;
    final expiryStr = expiryDate != null ? DateFormatUtils.formatToYyyyMmDd(expiryDate!) : null;

    final variables = {
      "id": editBannerId,
      "fields": {
        "banner_name": bannerNameController.text,
        "url": urlController.text,
        "image": [
          {
            "url": banner_image,
            "name": banner_name,
            "type": "image",
            "extension": "jpeg"
          }
        ],
        "schedule_date": scheduleStr,
        "expiry_date": expiryStr,
        "category_name": selectedCatagory?.name,
        "from_id": id,
        "status": "PENDING",
        "company_name": name
      }
    };

    final res = await repo.updateBanner(variables);
    if (res != null) {
      getBannersCounts();
      Loaders.circularHideLoader(context);
      navigationService.goBack();
      clearAddBannerData();
      getBannersList(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  //Relisting
  Future<void> relistDataAssign(BannersByPk? bannersView) async {
    bannerNameController.text = bannersView?.bannerName ?? '';
    assignTheSelectedCatagory(bannersView?.categoryName);
    editBannerId = bannersView?.id ?? "";
    if (bannersView?.image != null && bannersView!.image!.isNotEmpty) {
      banner_image = bannersView.image!.first.url;
    }
    urlController.text = bannersView?.url ?? "";
    scheduleDate = null;
    expiryDate = null;

    isRelistBanner = true;
    notifyListeners();
  }

  Future<void> relistBannerNavigator(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.editBannerView(id);
    if (res != null) {
      bannerView = res;
      updateEditBannerVal(false); // not editing existing banner
      relistDataAssign(res);
      Loaders.circularHideLoader(context);
      navigationService.navigateTo(RouteList.addBanners);
    } else {
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
    selectedBannerImg = null;
    banner_image = null;
    isEditBanner = false;
    isRelistBanner = false;
    notifyListeners();
  }
}
