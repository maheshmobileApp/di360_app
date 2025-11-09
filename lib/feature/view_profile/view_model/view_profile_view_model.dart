import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repo_impl.dart';
import 'package:flutter/material.dart';

class ViewProfileViewModel extends ChangeNotifier with ValidationMixins {
  final ViewProfileRepoImpl repo = ViewProfileRepoImpl();

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
  final professionTypeController = TextEditingController();
  String? logoUrl;

  DentalSuppliersByPk? viewProfile;

  Future<void> getViewProfileData(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await repo.getViewProfileData(userId, userType);

    if (res != null) {
      viewProfile = res;
      loadViewProfileData(viewProfile);
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
    professionTypeController.text = viewProfile?.professionType ?? "";
    logoUrl = viewProfile?.logo?.url ?? "";
    notifyListeners();
  }
}
