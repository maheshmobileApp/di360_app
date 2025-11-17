import 'dart:io';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewProfileViewModel extends ChangeNotifier with ValidationMixins {
  final ViewProfileRepoImpl repo = ViewProfileRepoImpl();
  AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();

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
  File? logoFile;

  DirectoryCategories? selectedBusineestype;
  List<DirectoryBusinessTypes> directoryBusinessTypes = [];

  void setSelectedBusineestype(DirectoryCategories emp) {
    selectedBusineestype = emp;
    notifyListeners();
  }

  Future<void> getViewProfileData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await repo.getViewProfileData(userId, userType);

    if (res != null) {
      viewProfile = res;
      loadViewProfileData(viewProfile);
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
    final allCategories = directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.name == viewProfile?.professionType,
      orElse: () => null,
    );
    if (businessType != null) {
      setSelectedBusineestype(businessType);
    }
    //  professionTypeController.text = viewProfile?.professionType ?? "";
    logoUrl = viewProfile?.logo?.url ?? "";
    notifyListeners();
  }

  Future<void> getBusinessTypes() async {
    final result = await addDirectorRepositoryImpl.getBusinessTypes();
    if (result?.directoryBusinessTypes != null) {
      directoryBusinessTypes = result?.directoryBusinessTypes ?? [];
    }
    notifyListeners();
  }

  Future<void> pickLogoImage(ImageSource source,BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      logoFile = File(pickedFile.path);
      navigationService.goBack();
      uploadBussinessLogo(context);
      notifyListeners();
    }
  }

  Future<void> uploadBussinessLogo(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var logo = logoFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);

    final result = await repo.uploadLogo({
      "id": viewProfile?.id,
      "userImage": {"logo": logo ?? viewProfile?.logo?.toJson()}
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateViewProfile(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final result = await repo.updateViewProfileData({
      "id": userId,
      "supplierObj": {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneNoController.text,
        "business_name": businessNameController.text,
        "abn_number": abnNUmberController.text,
        "address": addressController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "middle_name": middleNameController.text,
        "fax_number": faxNumberController.text,
        "alt_email": alternateEmailController.text,
        "alt_phone": alternatePhoneNoController.text,
        "profession_type": selectedBusineestype?.name,
        "profile_completed": true
      }
    });
    if (result != null) {
      getViewProfileData();
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
