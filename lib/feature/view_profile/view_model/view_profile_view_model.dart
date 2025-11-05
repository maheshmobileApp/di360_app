import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/utils/view_profile_enum.dart';

class ViewProfileViewModel extends ChangeNotifier with ValidationMixins {
  final ViewProfileRepoImpl repo = ViewProfileRepoImpl();
  final List<String> statuses = [
    'Basic Info',
    'Personal Details',
    'Contact Information',
    'Professional Details',
    'Other Info',
  ];

  bool isSuupliesSell = false;
   bool isSecondHandSuupliesSell = false;

  void toggleSupplies(bool value) {
    isSuupliesSell = value;
    notifyListeners();
  }

  void toggleSecondHandSupplies(bool value) {
    isSecondHandSuupliesSell = value;
    notifyListeners();
  }

  /// MUST MATCH enum length
  final List<GlobalKey<FormState>> formKeys = List.generate(
      ViewProfileSteps.values.length, (_) => GlobalKey<FormState>());

  String selectedStatus = "Basic Info";

  final PageController pageController = PageController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final businessNameController = TextEditingController();
  final abnNUmberController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessPhoneNoController = TextEditingController();
  final faxNumberController = TextEditingController();
  final alternateEmailController = TextEditingController();
  final alternatePhoneNoController = TextEditingController();
  final addressController = TextEditingController();
  final addressLineOneController = TextEditingController();
  final addressLineTwoController = TextEditingController();
  final cityController = TextEditingController();
  final landmarkController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final secondaryEmailController = TextEditingController();
  final secondaryPhoneNoController = TextEditingController();
  final professionTypeController = TextEditingController();
  final tgaController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountHolderNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bsbController = TextEditingController();
  String? logoUrl;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  int get totalSteps => ViewProfileSteps.values.length;

  void changeStatus(String value) {
    selectedStatus = value;
    _currentStep = statuses.indexOf(value);
    pageController.jumpToPage(_currentStep);

    notifyListeners();
  }

  DentalSuppliersByPk? viewProfile;

  Future<void> getViewProfileData(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await repo.getViewProfileData(userId, userType);

    if (res != null) {
      viewProfile = res;
      loadViewProfileData(viewProfile);
      selectedStatus = "Basic Info";
      print(viewProfile);
    }
    notifyListeners();
  }

  void loadViewProfileData(DentalSuppliersByPk? viewProfile) {
    nameController.text = viewProfile?.name ?? "";
    emailController.text = viewProfile?.email ?? "";
    phoneNoController.text = viewProfile?.phone ?? "";
    businessNameController.text = viewProfile?.businessName ?? "";
    abnNUmberController.text = viewProfile?.abnNumber ?? "";
    firstNameController.text = viewProfile?.firstName ?? "";
    middleNameController.text = viewProfile?.middleName ?? "";
    lastNameController.text = viewProfile?.lastName ?? "";
    businessEmailController.text = viewProfile?.businessEmail ?? "";
    businessPhoneNoController.text = viewProfile?.businessPhone ?? "";
    faxNumberController.text = viewProfile?.faxNumber ?? "";
    alternateEmailController.text = viewProfile?.altEmail ?? "";
    alternatePhoneNoController.text = viewProfile?.altPhone ?? "";
    addressController.text = viewProfile?.address ?? "";
    addressLineOneController.text = viewProfile?.address ?? "";
    addressLineTwoController.text = viewProfile?.address ?? "";
    cityController.text = "";
    landmarkController.text = "";
    countryController.text = "";
    stateController.text = "";
    zipCodeController.text = "";
    secondaryNameController.text = viewProfile?.secondaryContact?.name ?? "";
    secondaryEmailController.text = viewProfile?.secondaryContact?.email ?? "";
    secondaryPhoneNoController.text =
        viewProfile?.secondaryContact?.phone ?? "";
    professionTypeController.text = viewProfile?.professionType ?? "";
    tgaController.text = viewProfile?.tgaNumber ?? "";
    bankNameController.text = viewProfile?.bankDetails?.bankName ?? "";
    accountHolderNameController.text =
        viewProfile?.bankDetails?.accountHolderName ?? "";
    accountNumberController.text =
        viewProfile?.bankDetails?.accountNumber ?? "";
    bsbController.text = "";
    logoUrl = viewProfile?.logo?.url ?? "";

    notifyListeners();
  }
}
