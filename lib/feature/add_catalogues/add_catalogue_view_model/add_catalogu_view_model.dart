import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catalogue_view_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_type_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/repository/add_catalogue_repository_impl.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddCatalogueViewModel extends ChangeNotifier {
  final AddCatalogueRepositoryImpl repo = AddCatalogueRepositoryImpl();
  final HttpService _http = HttpService();

  AddCatalogueViewModel() {
    getCatalogCounts();
    getCatagorysData();
    getCatalogueTypeData();
    initializeFilterOptions();
    activeStatus = ["ACTIVE", "INACTIVE"];
    selectedStatus = "All";
  }

  String selectedStatus = 'All';

  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Approved & Scheduled',
    'Expired',
    'Reject',
    'InActive'
  ];

  final List<String> adminStatuses = [
    'All',
    'Pending Approval',
    'Approved & Scheduled',
    'Expired',
    'Reject',
    'InActive'
  ];

  int? allCatalogueCount = 0;
  int? draftCatalogueCount = 0;
  int? pendingApprovalCatalogueCount = 0;
  int? approvedScheduledCatalogueCount = 0;
  int? expiredCatalogueCount = 0;
  int? rejectCatalogueCount = 0;
  int? inActiveCatalogueCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': allCatalogueCount,
        'Draft': draftCatalogueCount,
        'Pending Approval': pendingApprovalCatalogueCount,
        'Approved & Scheduled': approvedScheduledCatalogueCount,
        'Expired': expiredCatalogueCount,
        'Reject': rejectCatalogueCount,
        'InActive': inActiveCatalogueCount
      };

  Map<String, int?> get adminStatusCountMap => {
        'All': allCatalogueCount,
        'Pending Approval': pendingApprovalCatalogueCount,
        'Approved & Scheduled': approvedScheduledCatalogueCount,
        'Expired': expiredCatalogueCount,
        'Reject': rejectCatalogueCount,
        'InActive': inActiveCatalogueCount
      };

  List<String>? catalogStatus = [];
  List<String>? activeStatus = [];
  String? editCatalogueId;
  String? monthCount;
  List<Catalogues>? myCatalogueList;
  CataloguesByPk? cataloguView;
  List<CatalogueSubCategories>? catagorysList;
  List<CatalogueTypes>? catalogueTypesList;
  TextEditingController catalogueNameController = TextEditingController();
  CatalogueSubCategories? selectedCatagory;
  CatalogueTypes? selectedCatalogueType;
  String? thumbnailImagePath;
  String? thumbnailServerPath;
  dynamic thumbnailImageObj;
  String? pdfPath;
  dynamic pdfPathUrl;
  bool isEditCatalogue = false;
  List<String> communityTypes = ["Both", "Community User"];
  String? selectedCommunityType = 'Both';
  bool communityStatus = false;
  String? userType;

  void setCommunityStatus() async {
    print("Setting community status");
    final communityValue =
        await LocalStorage.getStringVal(LocalStorageConst.communityStatus);
    communityStatus = communityValue == 'true';
    notifyListeners();
  }

  void setCommunityType(String value) {
    selectedCommunityType = value;
    notifyListeners();
  }

  void updateSelectedCatagory(CatalogueSubCategories? catagory) {
    selectedCatagory = catagory;
    notifyListeners();
  }

  void updateSelectedCatalogueType(CatalogueTypes? type) {
    selectedCatalogueType = type;
    notifyListeners();
  }

  void updateEditCatalogueVal(bool val) {
    isEditCatalogue = val;
    notifyListeners();
  }

  void changeStatus(String status, BuildContext context) async {
    selectedStatus = status;
    if (status == 'All') {
      catalogStatus = userType == UserRole.admin.value
          ? ["APPROVED", "PENDING_APPROVAL", "EXPIRED", "SCHEDULED", "REJECTED"]
          : [
              "APPROVED",
              "PENDING_APPROVAL",
              "EXPIRED",
              "SCHEDULED",
              "REJECTED",
              "DRAFT"
            ];
      activeStatus = ["ACTIVE", "INACTIVE"];
    } else if (status == 'Draft') {
      catalogStatus = ['DRAFT'];
      activeStatus = [];
    } else if (status == 'Pending Approval') {
      catalogStatus = ['PENDING_APPROVAL'];
      activeStatus = [];
    } else if (status == 'Approved & Scheduled') {
      catalogStatus = ["APPROVED", "SCHEDULED"];
      activeStatus = ["ACTIVE"];
    } else if (status == 'Expired') {
      catalogStatus = ['EXPIRED'];
      activeStatus = [];
    } else if (status == 'Reject') {
      catalogStatus = ['REJECTED'];
      activeStatus = [];
    } else if (status == 'InActive') {
      catalogStatus = ["APPROVED", "SCHEDULED"];
      activeStatus = ["INACTIVE"];
    }

    await getMyCataloguesData(context);
    notifyListeners();
  }

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

  Future<String> pickFiles(List<String>? allowedExtensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: allowedExtensions);
    notifyListeners();
    return result?.files.first.path ?? '';
  }

  Future<void> thumbnailImage() async {
    final res = await pickFiles(['jpg', 'png', 'jpeg']);
    if (res != '') {
      thumbnailServerPath == null;
      thumbnailImagePath = res;
      var value = await _http.uploadImage(res);
      thumbnailImageObj = value;
      notifyListeners();
    }
  }

  Future<void> uploadPdf() async {
    final res = await pickFiles(['pdf']);
    if (res != '') {
      pdfPath = res;
      var value = await _http.uploadImage(res);
      pdfPathUrl = value;
      notifyListeners();
    }
  }

  Future<void> addCatalogueData(BuildContext context, bool isDraft) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final communityStatus =
        await LocalStorage.getStringVal(LocalStorageConst.communityStatus);

    final isoString = DateTime.now().toUtc().toIso8601String();

    Loaders.circularShowLoader(context);
    if (thumbnailImageObj == null) {
      var value = await _http.uploadImage(thumbnailImagePath);
      thumbnailImageObj = value;
      notifyListeners();
    }
    if (pdfPathUrl == null) {
      var value = await _http.uploadImage(pdfPath);
      pdfPathUrl = value;
      notifyListeners();
    }
    final res = await repo.addCatalogue({
      "catalogueObj": {
        "title": catalogueNameController.text,
        "catalogue_category_id": selectedCatalogueType?.id,
        "catalogue_sub_category_id": selectedCatagory?.id,
        "thumbnail_image": thumbnailImageObj,
        "attachment": pdfPathUrl,
        "dental_supplier_id": id,
        "catalogue_status": "ACTIVE",
        "schedulerDay":
            '${scheduleDate?.year}-${scheduleDate?.month}-${scheduleDate?.day}',
        "months_count": null,
        "expiryDay":
            '${expiryDate?.year}-${expiryDate?.month}-${expiryDate?.day}',
        "status": isDraft ? "DRAFT" : "PENDING_APPROVAL",
        "pending_at": isoString,
        "community_user_type":
            selectedCommunityType == "Both" ? "BOTH" : "COMMUNITY_USER",
        "community_id": communityId,
        "community_status": communityStatus == "true" ? "YES" : "NO",
        "user_role": type,
      }
    });
    if (res != null) {
      Loaders.circularHideLoader(context);
      navigationService.goBack();
      clearAddCatalogueData();
      selectedStatus = 'Pending Approval';
      catalogStatus = ['PENDING_APPROVAL'];
      await getMyCataloguesData(navigatorKey.currentContext!);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  clearAddCatalogueData() {
    catalogueNameController.clear();
    thumbnailImagePath = null;
    thumbnailImageObj = null;
    thumbnailServerPath = null;
    pdfPath = null;
    pdfPathUrl = null;
    selectedCatagory = null;
    selectedCatalogueType = null;
    scheduleDate = null;
    expiryDate = null;
    updateEditCatalogueVal(false);
    notifyListeners();
  }

  int catalogueLimit = 10;
  int catalougueOffset = 0;
  bool hasMoreCatalogues = true;
  bool isLoadingMore = false;
  String? _lastType;
  String? _lastSubCatagory;

  Future<void> getMyCataloguesData(BuildContext context,
      {String? type, String? subCatagory, bool isPagination = false}) async {
    final userTypes = await LocalStorage.getStringVal(LocalStorageConst.type);
    userType = userTypes;
    if (isPagination) {
      if (!hasMoreCatalogues || isLoadingMore) return;
      isLoadingMore = true;
      catalougueOffset += catalogueLimit;
    } else {
      catalougueOffset = 0;
      hasMoreCatalogues = true;
      _lastType = type;
      _lastSubCatagory = subCatagory;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();
    final res = await repo.getMyCatalogues(catalogStatus, activeStatus,
        catalogueLimit, catalougueOffset, selectedStatus,
        type: _lastType, subCatagory: _lastSubCatagory);
    if (!isPagination && userTypes != UserRole.admin.value) getCatalogCounts();
    if (!isPagination && userTypes == UserRole.admin.value)
      getAdminCatalogStatusCounts();
    if (res != null) {
      myCatalogueList = isPagination ? [...?myCatalogueList, ...res] : res;
      if (res.length < catalogueLimit) hasMoreCatalogues = false;
    }
    if (!isPagination) Loaders.circularHideLoader(context);
    isLoadingMore = false;
    notifyListeners();
  }

  Future<void> getCatalogueView(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.cataloguView(id);
    if (res != null) {
      cataloguView = res;
      Loaders.circularHideLoader(context);
      navigationService.push(HorizantalPdf(
        key: ValueKey(cataloguView?.attachment?.url ?? ''),
        fileUrl: cataloguView?.attachment?.url ?? '',
        fileName: cataloguView?.attachment?.name ?? '',
        isfullScreen: true,
      ));
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> removeCatalogue(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.removeCatalogue(id);
    if (res != null) {
      scaffoldMessenger('Catalogue removed successfully');
      Loaders.circularHideLoader(context);
      getMyCataloguesData(context);
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> sendApprovalCatalogue(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.sendApprovalCatalogue(id);
    if (res != null) {
      Loaders.circularHideLoader(context);
      getMyCataloguesData(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> inActiveCatalogue(
      BuildContext context, String? id, String? status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.inActiveCatalogue(id, status);
    if (res != null) {
      Loaders.circularHideLoader(context);
      getMyCataloguesData(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> editCatalogueNavigator(
      BuildContext context, String? id, String expDate) async {
    Loaders.circularShowLoader(context);
    final res = await repo.cataloguView(id);
    if (res != null) {
      cataloguView = res;
      updateEditCatalogueVal(true);
      editDataAssign(res, expDate);
      Loaders.circularHideLoader(context);
      navigationService.navigateTo(RouteList.addCatalogScreen);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> editDataAssign(
      CataloguesByPk? cataloguView, String expirysDate) async {
    catalogueNameController.text = cataloguView?.title ?? '';
    thumbnailImageObj = cataloguView?.thumbnailImage;
    thumbnailServerPath = cataloguView?.thumbnailImage?.url ?? '';
    editCatalogueId = cataloguView?.id ?? '';
    monthCount = '${cataloguView?.monthsCount ?? ''}';
    pdfPath = cataloguView?.attachment?.name ?? '';
    pdfPathUrl = cataloguView?.attachment;
    assignTheSelectedCatagory(cataloguView?.catalogueSubCategory?.id);
    assignTheSelectedCatalogueType(cataloguView?.catalogueCategory?.id);
    scheduleDate = DateFormatUtils.parseToLocalDate(cataloguView?.schedulerDay);
    expiryDate = DateFormatUtils.parseToLocalDate(cataloguView?.expiryDay);
    setCommunityType(cataloguView?.communityUserType == "BOTH"
        ? "Both"
        : cataloguView?.communityUserType == "COMMUNITY_USER"
            ? "Community User"
            : '');
    notifyListeners();
  }

  assignTheSelectedCatagory(String? id) {
    final obj = catagorysList?.firstWhere((v) => v.id == id);
    updateSelectedCatagory(obj);
    notifyListeners();
  }

  assignTheSelectedCatalogueType(String? id) {
    final obj = catalogueTypesList?.firstWhere((v) => v.id == id);
    updateSelectedCatalogueType(obj);
    notifyListeners();
  }

  Future<void> getCatagorysData() async {
    final res = await repo.getCatagorys();
    if (res != null) {
      catagorysList = res;
    }
    notifyListeners();
  }

  Future<void> getCatalogueTypeData() async {
    final res = await repo.getCatalogueTypes();
    if (res != null) {
      catalogueTypesList = res;
    }
    notifyListeners();
  }

  Future<void> editCatalogueData(BuildContext context, bool isDarft) async {
    Loaders.circularShowLoader(context);
    if (thumbnailImageObj == null) {
      var value = await _http.uploadImage(thumbnailImagePath);
      thumbnailImageObj = value;
      notifyListeners();
    }
    if (pdfPathUrl == null) {
      var value = await _http.uploadImage(pdfPath);
      pdfPathUrl = value;
      notifyListeners();
    }
    final res = await repo.editCatalogue({
      "id": editCatalogueId,
      "updateObj": {
        "title": catalogueNameController.text,
        "catalogue_category_id": selectedCatalogueType?.id,
        "catalogue_sub_category_id": selectedCatagory?.id,
        "thumbnail_image": thumbnailImageObj,
        "attachment": pdfPathUrl,
        "catalogue_status": isDarft ? "DRAFT" : "PENDING_APPROVAL",
        "status": isDarft ? "DRAFT" : "PENDING_APPROVAL",
        "schedulerDay":
            '${scheduleDate?.year}-${scheduleDate?.month}-${scheduleDate?.day}',
        "months_count": int.tryParse(monthCount ?? ''),
        "expiryDay":
            '${expiryDate?.year}-${expiryDate?.month}-${expiryDate?.day}',
        "community_user_type":
            selectedCommunityType == "Both" ? "BOTH" : "COMMUNITY_USER",
      }
    });
    if (res != null) {
      if (isDarft) {
        selectedStatus = 'Draft';
        catalogStatus = ['DRAFT'];
      } else {
        selectedStatus = 'Pending Approval';
        catalogStatus = ['PENDING_APPROVAL'];
      }
      await getCatalogCounts();
      await getMyCataloguesData(navigatorKey.currentContext!);
      Loaders.circularHideLoader(context);
      navigationService.goBack();
      clearAddCatalogueData();
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getCatalogCounts() async {
    final res = await repo.catalogueCounts();
    allCatalogueCount = res.all?.aggregate?.count;
    pendingApprovalCatalogueCount = res.approvalPending?.aggregate?.count;
    draftCatalogueCount = res.draft?.aggregate?.count;
    approvedScheduledCatalogueCount = res.approved?.aggregate?.count;
    expiredCatalogueCount = res.expired?.aggregate?.count;
    rejectCatalogueCount = res.rejected?.aggregate?.count;
    inActiveCatalogueCount = res.inactive?.aggregate?.count;
    notifyListeners();
  }

  Future<void> getAdminCatalogStatusCounts() async {
    final res = await repo.adminCataloguesCount();
    allCatalogueCount = res.all?.aggregate?.count;
    pendingApprovalCatalogueCount = res.approvalPending?.aggregate?.count;
    approvedScheduledCatalogueCount = res.approved?.aggregate?.count;
    expiredCatalogueCount = res.expired?.aggregate?.count;
    rejectCatalogueCount = res.rejected?.aggregate?.count;
    inActiveCatalogueCount = res.inactive?.aggregate?.count;
    notifyListeners();
  }

  Future<void> approveTheCatalogue(String id,BuildContext context) async {
    Loaders.circularShowLoader(context);
    String timestamp = DateTime.now().toUtc().toIso8601String();
    final res = await repo.approveAndRejectCatalogueQuery({
      "id": id,
      "updateObj": {"status": "APPROVED", "approved_at": timestamp}
    });
    if (res != null) {
      await updateTheMyCatalogueList(id, "APPROVED");
    }
    Loaders.circularHideLoader(context);
  }

  Future<void> updateTheMyCatalogueList(String id, String status) async {
    final index = myCatalogueList?.indexWhere((item) => item.id == id);
    if (index != null && index >= 0) {
      myCatalogueList?[index].status = status;
      notifyListeners();
    }
  }

  late Map<String, List<FilterItem>> filterOptions;
  bool? catalogFilterApply;
  TextEditingController searchController = TextEditingController();

  void updateCatalogFilterApply(bool val) {
    catalogFilterApply = val;
    notifyListeners();
  }

  void toggleSection(String section) {
    sectionVisibility[section] = !(sectionVisibility[section] ?? true);
    notifyListeners();
  }

  void selectItem(String section, int index) {
    final currentSet = selectedIndices[section] ?? {};
    if (currentSet.contains(index)) {
      selectedIndices[section] = {};
    } else {
      selectedIndices[section] = {index};
    }
    notifyListeners();
  }

  Map<String, Set<int>> selectedIndices = {'type': {}, 'catagory': {}};

  Map<String, bool> sectionVisibility = {'type': true, 'catagory': true};

  String? selectedCatagoryName;
  String? selectedType;

  void initializeFilterOptions() async {
    filterOptions = {
      'Type': catalogueTypesList?.map((e) {
            return FilterItem(
              name: e.name ?? '',
              id: e.id ?? '',
            );
          }).toList() ??
          [],
      'Catagory': catagorysList?.map((e) {
            return FilterItem(
              name: e.name ?? '',
              id: e.id ?? '',
            );
          }).toList() ??
          []
    };
    notifyListeners();
  }

  void clearSelections() {
    selectedIndices.updateAll((key, value) => {});
    searchController.clear();
    selectedCatagoryName = null;
    selectedType = null;
    updateCatalogFilterApply(false);
    getMyCataloguesData(navigatorKey.currentContext!);
    notifyListeners();
  }

  void printSelectedItems() async {
    selectedIndices.forEach((section, indices) {
      final items = filterOptions[section];
      if (items != null && indices.isNotEmpty) {
        for (final i in indices) {
          updateCatalogFilterApply(true);
          final name = items[i].name;
          if (section == "Catagory") {
            selectedCatagoryName = name;
          } else if (section == "Type") {
            selectedType = name;
          }
        }
      }
    });
    await getMyCataloguesData(navigatorKey.currentContext!,
        type: selectedType, subCatagory: selectedCatagoryName);
  }
}

class FilterItem {
  final String name;
  final String id;
  bool isSelected;

  FilterItem({
    required this.name,
    required this.id,
    this.isSelected = false,
  });
}
