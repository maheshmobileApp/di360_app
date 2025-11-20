import 'dart:io';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/view_profile/model/practice_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/professional_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/date_utils.dart' as di360_date_utils;
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
  final aphraNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  String? logoUrl;

  DentalSuppliersByPk? viewProfile;
  DentalPracticesByPk? practiceViewProfileData;
  DentalProfessionalsByPk? professionalViewProfileData;
  File? logoFile;

  DirectoryCategories? selectedBusineestype;
  List<DirectoryBusinessTypes> directoryBusinessTypes = [];

  String? selectedSalutation;
  String? selectedGender;
  DateTime? scheduleDate;

  void setScheduleDate(DateTime date) {
    scheduleDate = date;
    dateOfBirthController.text =
        di360_date_utils.DateFormatUtils.formatToYyyyMmDd(date);
    notifyListeners();
  }

  void setSelectedBusineestype(DirectoryCategories emp) {
    selectedBusineestype = emp;
    notifyListeners();
  }

  Future<void> getTheViewProfileData() async {
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (userType == "PRACTICE") {
      await getPracticeViewProfileData();
    } else if (userType == "PROFESSIONAL") {
      await getProfessionalViewProfileData();
    } else {
      await getSuppilerViewProfileData();
    }
    notifyListeners();
  }

  Future<void> getSuppilerViewProfileData() async {
    final res = await repo.getViewProfileData();
    if (res != null) {
      viewProfile = res;
      loadViewProfileData(viewProfile);
    }
    notifyListeners();
  }

  Future<void> getPracticeViewProfileData() async {
    final res = await repo.getPracticeViewProfileData();
    if (res != null) {
      practiceViewProfileData = res;
      loadViewProfileData(practiceViewProfileData);
    }
    notifyListeners();
  }

  Future<void> getProfessionalViewProfileData() async {
    final res = await repo.getProfessionalViewProfile();
    if (res != null) {
      professionalViewProfileData = res;
      loadProfessionalViewProfileData(professionalViewProfileData);
    }
    notifyListeners();
  }

  void loadViewProfileData(dynamic viewProfile) async {
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
    logoUrl = viewProfile?.logo?.url ?? "";
    await LocalStorage.setStringVal(
        LocalStorageConst.profilePic, logoUrl ?? '');
    notifyListeners();
  }

  void loadProfessionalViewProfileData(DentalProfessionalsByPk? viewProfile) async{
    nameController.text = viewProfile?.name ?? "";
    emailController.text = viewProfile?.email ?? "";
    phoneNoController.text = viewProfile?.phone ?? "";
    firstNameController.text = viewProfile?.firstName ?? "";
    middleNameController.text = viewProfile?.middleName ?? "";
    lastNameController.text = viewProfile?.lastName ?? "";
    alternateEmailController.text = viewProfile?.altEmail ?? "";
    alternatePhoneNoController.text = viewProfile?.altPhone ?? "";
    addressController.text = viewProfile?.address?.addressName ?? "";
    addressLineOneController.text = "";
    addressLineTwoController.text = "";
    cityController.text = viewProfile?.address?.city ?? "";
    landmarkController.text = "";
    countryController.text = viewProfile?.address?.country ?? "";
    stateController.text = viewProfile?.address?.state ?? "";
    zipCodeController.text = viewProfile?.address?.zipcode ?? "";
    if (viewProfile?.dateOfBirth != null) {
      final date = DateTime.parse(viewProfile!.dateOfBirth!);
      dateOfBirthController.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } else {
      dateOfBirthController.text = "";
    }
    selectedSalutation = viewProfile?.salutation?.isNotEmpty ?? false
        ? '${viewProfile?.salutation ?? ""}'
        : null;
    selectedGender = viewProfile?.gender?.isNotEmpty == true
        ? viewProfile!.gender![0].toUpperCase() +
            viewProfile.gender!.substring(1).toLowerCase()
        : null;
    aphraNumberController.text =
        viewProfile?.proDetailsAphraRegistrationNumber ?? '';
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
    logoUrl = viewProfile?.profileImage?.url ?? "";
    await LocalStorage.setStringVal(
        LocalStorageConst.profilePic, logoUrl ?? '');
    notifyListeners();
  }

  Future<void> getBusinessTypes() async {
    final result = await addDirectorRepositoryImpl.getBusinessTypes();
    if (result?.directoryBusinessTypes != null) {
      directoryBusinessTypes = result?.directoryBusinessTypes ?? [];
    }
    notifyListeners();
  }

  Future<void> pickLogoImage(ImageSource source, BuildContext context) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      logoFile = File(pickedFile.path);
      navigationService.goBack();
      type == 'PROFESSIONAL'
          ? uploadProfessLogo(context)
          : uploadBussinessLogo(context);
      notifyListeners();
    }
  }

  Future<void> uploadBussinessLogo(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var logo = logoFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final result = await repo.uploadLogo({
      "id": id,
      "userImage": {
        "logo": logo ??
            (type == 'PRACTICE'
                ? practiceViewProfileData?.logo?.toJson()
                : viewProfile?.logo?.toJson())
      }
    });
    Loaders.circularHideLoader(context);
    if (result != null) {
      // Handle success if needed
    }
    notifyListeners();
  }

  Future<void> uploadProfessLogo(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var logo = logoFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final result = await repo.uploadLogo({
      "id": id,
      "userImage": {
        "profile_image":
            logo ?? professionalViewProfileData?.profileImage?.toJson()
      }
    });
    Loaders.circularHideLoader(context);
    if (result != null) {
      // Handle success if needed
    }
    notifyListeners();
  }

  Future<void> updateViewProfile(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Map<String, dynamic> requestData = {
      "id": userId,
    };
    if (type == "PRACTICE") {
      requestData["practiceObj"] = {
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
      };
    } else if (type == "PROFESSIONAL") {
      requestData["_set"] = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneNoController.text,
        "address": {
          "city": cityController.text,
          "state": stateController.text,
          "country": countryController.text,
          "zipcode": zipCodeController.text,
          "latitude": professionalViewProfileData?.address?.latitude,
          "longitude": professionalViewProfileData?.address?.longitude,
          "addressName": addressController.text
        },
        "profession_type": selectedBusineestype?.name,
        "pro_details_aphra_registration_number": aphraNumberController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "middle_name": middleNameController.text,
        "gender": selectedGender,
        "date_of_birth": scheduleDate?.toIso8601String(),
        "salutation": selectedSalutation,
        "profile_completed": true
      };
    } else {
      requestData["supplierObj"] = {
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
      };
    }

    final result = await repo.updateViewProfileData(requestData);
    if (result != null) {
      type == "PRACTICE"
          ? getPracticeViewProfileData()
          : type == "PROFESSIONAL"
              ? getProfessionalViewProfileData()
              : getSuppilerViewProfileData();
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
