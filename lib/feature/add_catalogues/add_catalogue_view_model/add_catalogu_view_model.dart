import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catalogue_view_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/feature/add_catalogues/repository/add_catalogue_repository_impl.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddCatalogueViewModel extends ChangeNotifier {
  final AddCatalogueRepositoryImpl repo = AddCatalogueRepositoryImpl();
  final HttpService _http = HttpService();

  AddCatalogueViewModel() {
    getCatagorysData();
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
  CataloguesByPk? cataloguView;
  List<CatalogueCategories>? catagorysList;
  TextEditingController catalogueNameController = TextEditingController();
  CatalogueCategories? selectedCatagory;
  String? thumbnailImagePath;
  dynamic thumbnailImageUrl;
  String? pdfPath;
  dynamic pdfPathUrl;

  void updateSelectedCatagory(CatalogueCategories? catagory) {
    selectedCatagory = catagory;
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

    getMyCataloguesData(context);
    notifyListeners();
  }

  DateTime? _scheduleDate;
  DateTime? _expiryDate;

  DateTime? get scheduleDate => _scheduleDate;
  DateTime? get expiryDate => _expiryDate;

  void setScheduleDate(DateTime date) {
    _scheduleDate = date;

    // reset expiry if it’s invalid
    if (_expiryDate != null &&
        _expiryDate!.isBefore(_scheduleDate!.add(const Duration(days: 1)))) {
      _expiryDate = null;
    }

    notifyListeners();
  }

  void setExpiryDate(DateTime date) {
    _expiryDate = date;
    notifyListeners();
  }

  Future<String> pickFiles(List<String>? allowedExtensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions
    );
    notifyListeners();
    return result?.files.first.path ?? '';
  }

  Future<void> thumbnailImage() async {
    final res = await pickFiles(['jpg', 'png', 'jpeg']);
    if (res != '') {
      thumbnailImagePath = res;
      var value = await _http.uploadImage(res);
      thumbnailImageUrl = value;
      print(thumbnailImageUrl);
      notifyListeners();
    }
  }

  Future<void> uploadPdf() async {
    final res = await pickFiles(['pdf']);
    if (res != '') {
      pdfPath = res;
      var value = await _http.uploadImage(res);
      pdfPathUrl = value;
      print(pdfPathUrl);
      notifyListeners();
    }
  }

  Future<void> addCatalogueData(BuildContext context) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final isoString = DateTime.now().toUtc().toIso8601String();

    Loaders.circularShowLoader(context);
    if (thumbnailImageUrl == null) {
      var value = await _http.uploadImage(thumbnailImagePath);
      thumbnailImageUrl = value;
      print(thumbnailImageUrl);
      notifyListeners();
    }
    if (pdfPathUrl == null) {
      var value = await _http.uploadImage(pdfPath);
      pdfPathUrl = value;
      print(pdfPathUrl);
      notifyListeners();
    }
    final res = await repo.addCatalogue({
      "catalogueObj": {
        "title": catalogueNameController.text,
        "catalogue_category_id": selectedCatagory?.id,
        "thumbnail_image": thumbnailImageUrl,
        "attachment": pdfPathUrl,
        "dental_supplier_id": id,
        "catalogue_status": "ACTIVE",
        "schedulerDay":
            '${scheduleDate?.year}-${scheduleDate?.month}-${scheduleDate?.day}',
        "months_count": null,
        "expiryDay":
            '${expiryDate?.year}-${expiryDate?.month}-${expiryDate?.day}',
        "status": "PENDING_APPROVAL",
        "pending_at": isoString
      }
    });
    if (res != null) {
      Loaders.circularHideLoader(context);
      navigationService.goBack();
      clearAddCatalogueData();
      selectedStatus = 'Pending Approval';
      catalogStatus = ['PENDING_APPROVAL'];
      getMyCataloguesData(navigatorKey.currentContext!);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  clearAddCatalogueData() {
    catalogueNameController.clear();
    thumbnailImagePath = null;
    thumbnailImageUrl = null;
    pdfPath = null;
    pdfPathUrl = null;
    selectedCatagory = null;
    _scheduleDate = null;
    _expiryDate = null;
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
    if (res != null) {
      myCatalogueList = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getCatalogueView(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.cataloguView(id);
    if (res != null) {
      cataloguView = res;
      Loaders.circularHideLoader(context);
      navigationService.push(HorizantalPdf(
        key: ValueKey(
          cataloguView?.attachment?.url ?? '',
        ),
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

  Future<void> inActiveCatalogue(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.inActiveCatalogue(id);
    if (res != null) {
      Loaders.circularHideLoader(context);
      getMyCataloguesData(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getCatagorysData() async {
    final res = await repo.getCatagorys();
    if (res != null) {
      catagorysList = res;
    }
    notifyListeners();
  }
}
