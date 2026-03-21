import 'dart:io';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/view_profile/model/practice_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/professional_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/email_phone_visiable_enums.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/date_utils.dart' as di360_date_utils;
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ViewProfileViewModel extends ChangeNotifier with ValidationMixins {
  final ViewProfileRepoImpl repo = ViewProfileRepoImpl();
  AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final businessEmailController = TextEditingController();
  final websiteUrlController = TextEditingController();
  final aboutUsController = TextEditingController();
  final phoneNoController = TextEditingController();
  final businessNameController = TextEditingController();
  final abnNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
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
  final FocusNode addressFocusNode1 = FocusNode();
  final FocusNode addressFocusNode2 = FocusNode();

  String? logoUrl;
  String? userName;
  String? gender;

  DentalSuppliersByPk? supplierViewProfileData;
  DentalPracticesByPk? practiceViewProfileData;
  DentalProfessionalsByPk? professionalViewProfileData;
  File? logoFile;

  DirectoryCategories? selectedBusineestype;
  List<DirectoryBusinessTypes> directoryBusinessTypes = [];

  String _countryCode = '+61';
  String _number = '';

  String get countryCode => _countryCode;
  String get number => _number;

  String get fullPhone => '$_countryCode$_number';

  // last 3 digits
  String get lastThree =>
      _number.length >= 3 ? _number.substring(_number.length - 3) : _number;

  void setCountry(String code) {
    _countryCode = code;
    notifyListeners();
  }

  void setNumber(String value) {
    _number = value;
    notifyListeners();
  }

  String? selectedPhoneCode = "AU (+61)";
  void setPhoneCode(String value) {
    selectedPhoneCode = value;
    notifyListeners();
  }

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
    if (userType == UserRole.practice.value) {
      await getPracticeViewProfileData();
    } else if (userType == UserRole.professional.value) {
      await getProfessionalViewProfileData();
    } else {
      await getSuppilerViewProfileData();
    }
    notifyListeners();
  }

  Future<void> getSuppilerViewProfileData() async {
    final res = await repo.getViewProfileData();
    if (res != null) {
      supplierViewProfileData = res;
      loadViewProfileData(supplierViewProfileData);
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
    final phone = viewProfile?.phone ?? "";
    if (phone.startsWith('+61')) {
      selectedPhoneCode = 'AU (+61)';
      phoneNoController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      selectedPhoneCode = 'NZ (+64)';
      phoneNoController.text = phone.substring(3);
    } else {
      selectedPhoneCode = 'AU (+61)';
      phoneNoController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    businessNameController.text = viewProfile?.businessName ?? "";
    businessEmailController.text = viewProfile?.businessEmail ?? "";
    businessPhoneNoController.text = viewProfile.mobileNumber ?? "";
    websiteUrlController.text = viewProfile?.websiteLink ?? "";
    abnNumberController.text = viewProfile?.abnNumber ?? "";
    firstNameController.text =
        viewProfile?.firstName ?? viewProfile?.name ?? "";
    middleNameController.text = viewProfile?.middleName ?? "";
    lastNameController.text = viewProfile?.lastName ?? "";
    faxNumberController.text = viewProfile?.faxNumber ?? "";
    alternateEmailController.text = viewProfile?.altEmail ?? "";
    alternatePhoneNoController.text = viewProfile?.altPhone ?? "";
    addressController.text = viewProfile?.address ?? "";
    addressLineOneController.text = viewProfile?.addressLineOne ?? "";
    addressLineTwoController.text = viewProfile?.addressLineTwo ?? "";
    cityController.text = viewProfile?.city ?? "";
    landmarkController.text = viewProfile?.landMark ?? "";
    countryController.text = viewProfile?.country ?? "";
    stateController.text = viewProfile?.state ?? "";
    zipCodeController.text = '${viewProfile?.zipcode ?? ""}';
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
    userName = viewProfile?.name ?? "";
    await LocalStorage.setStringVal(
        LocalStorageConst.profilePic, logoUrl ?? '');
    await LocalStorage.setStringVal(LocalStorageConst.name, userName ?? '');
    notifyListeners();
  }

  void loadProfessionalViewProfileData(
      DentalProfessionalsByPk? viewProfile) async {
    nameController.text = viewProfile?.name ?? "";
    aboutUsController.text = "";
    emailController.text = viewProfile?.email ?? "";
    final phone = viewProfile?.phone ?? "";
    if (phone.startsWith('+61')) {
      _countryCode = '+61';
      phoneNoController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      _countryCode = '+64';
      phoneNoController.text = phone.substring(3);
    } else {
      _countryCode = '+61';
      phoneNoController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    firstNameController.text =
        viewProfile?.firstName ?? viewProfile?.name ?? "";
    middleNameController.text = viewProfile?.middleName ?? "";
    lastNameController.text = viewProfile?.lastName ?? "";
    alternateEmailController.text = viewProfile?.altEmail ?? "";
    alternatePhoneNoController.text = viewProfile?.altPhone ?? "";
    addressController.text = viewProfile?.address ?? "";
    addressLineOneController.text = viewProfile?.addressLineOne ?? "";
    addressLineTwoController.text = viewProfile?.addressLineTwo ?? "";
    cityController.text = viewProfile?.city ?? "";
    landmarkController.text = viewProfile?.landMark ?? "";
    countryController.text = viewProfile?.country ?? "";
    stateController.text = viewProfile?.state ?? "";
    zipCodeController.text = '${viewProfile?.zipcode ?? ""}';
    if (viewProfile?.dateOfBirth != null) {
      final date = DateTime.parse(viewProfile?.dateOfBirth ?? "");
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
    userName = viewProfile?.name ?? "";
    gender = viewProfile?.gender ?? "";

    await LocalStorage.setStringVal(
        LocalStorageConst.profilePic, logoUrl ?? '');
    await LocalStorage.setStringVal(LocalStorageConst.name, userName ?? '');
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
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      logoFile = File(pickedFile.path);
      navigationService.goBack();
      /*type == UserRole.professional.value
          ? uploadProfessLogo(context)
          : uploadBussinessLogo(context);*/
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
            (type == UserRole.practice.value
                ? practiceViewProfileData?.logo?.toJson()
                : supplierViewProfileData?.logo?.toJson())
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
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final profileCompleted =
        await LocalStorage.getBoolValue(LocalStorageConst.profileCompleted);
    type == UserRole.professional.value
        ? await uploadProfessLogo(context)
        : await uploadBussinessLogo(context);
    Map<String, dynamic> requestData = {"id": userId};
    if (type == UserRole.practice.value) {
      requestData["set"] = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": '$countryCode${phoneNoController.text}',
        "business_name": businessNameController.text,
        "mobile_number": businessPhoneNoController.text,
        "business_email": businessEmailController.text,
        "website_link": websiteUrlController.text,
        "abn_number": abnNumberController.text,
        "address": addressController.text,
        "address_line_one": addressLineOneController.text,
        "address_line_two": addressLineTwoController.text,
        "land_mark": landmarkController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "zipcode": int.tryParse(zipCodeController.text),
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "middle_name": middleNameController.text,
        "fax_number": faxNumberController.text,
        "alt_email": alternateEmailController.text,
        "alt_phone": alternatePhoneNoController.text,
        "profession_type": selectedBusineestype?.name,
        "profile_completed": true
      };
    } else if (type == UserRole.professional.value) {
      requestData["set"] = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": '$countryCode${phoneNoController.text}',
        "address": addressController.text,
        "address_line_one": addressLineOneController.text,
        "address_line_two": addressLineTwoController.text,
        "land_mark": landmarkController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "zipcode": int.tryParse(zipCodeController.text),
        "profession_type": selectedBusineestype?.name,
        "pro_details_aphra_registration_number": aphraNumberController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "middle_name": middleNameController.text,
        "gender": selectedGender?.toLowerCase(),
        "date_of_birth": dateOfBirthController.text,
        "salutation": selectedSalutation,
        "profile_completed": true,
        //"about_us": aboutUsController.text,
      };
    } else {
      requestData["set"] = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": '$phoneCode${phoneNoController.text}',
        "business_name": businessNameController.text,
        "mobile_number": businessPhoneNoController.text,
        "business_email": businessEmailController.text,
        "website_link": websiteUrlController.text,
        "abn_number": abnNumberController.text,
        "address": addressController.text,
        "address_line_one": addressLineOneController.text,
        "address_line_two": addressLineTwoController.text,
        "land_mark": landmarkController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "zipcode": int.tryParse(zipCodeController.text),
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

    final responseKey = type == UserRole.practice.value
        ? 'update_dental_practices'
        : type == UserRole.professional.value
            ? 'update_dental_professionals_by_pk'
            : 'update_dental_suppliers';

    if (result[responseKey]?['id'] != null || result[responseKey] != null) {
      type == UserRole.practice.value
          ? await getPracticeViewProfileData()
          : type == UserRole.professional.value
              ? await getProfessionalViewProfileData()
              : await getSuppilerViewProfileData();
      profileCompleted == false
          ? showAlertMessage(context,
              'Great Job! 🎉\n\nYou’ve completed your profile. \n\nWant to continue and complete your directory for better visibility?',
              onBack: () => directorNavigationHandle(context),
              onCancel: () => navigationService
                  .pushNamedAndRemoveUntil(RouteList.dashBoard),
              yes: "Yes, Let's Go",
              no: "Maybe Later")
          : navigationService.goBack();
      if (profileCompleted == false) await insertDirectories();

      await LocalStorage.setBoolValue(LocalStorageConst.profileCompleted, true);
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> insertDirectories() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";

    await repo.insertDirectory(type == UserRole.professional.value
        ? {
            "object": {
              "name": nameController.text,
              "email": emailController.text,
              "phone": '$phoneCode${phoneNoController.text}',
              "address": addressController.text,
              "profession_type": selectedBusineestype?.name,
              "type": type,
              "dental_professional_id": userId,
              "profile_image":
                  professionalViewProfileData?.profileImage?.toJson(),
              "phone_visibility": VisibilityType.PRIVATE.name,
              "email_visibility": VisibilityType.PRIVATE.name,
            }
          }
        : type == UserRole.supplier.value
            ? {
                "object": {
                  "name": nameController.text,
                  "email": emailController.text,
                  "business_name": businessNameController.text,
                  "business_email": businessEmailController.text.isEmpty
                      ? null
                      : businessEmailController.text,
                  "phone": '$phoneCode${phoneNoController.text}',
                  "mobile_number": businessPhoneNoController.text,
                  "profession_type": selectedBusineestype?.name,
                  "abn_acn": abnNumberController.text,
                  "address": addressController.text,
                  "type": type,
                  "dental_supplier_id": userId,
                  "logo": supplierViewProfileData?.logo?.toJson(),
                }
              }
            : {
                "object": {
                  "name": nameController.text,
                  "email": emailController.text,
                  "business_name": businessNameController.text,
                  "business_email": businessEmailController.text.isEmpty
                      ? null
                      : businessEmailController.text,
                  "phone": '$phoneCode${phoneNoController.text}',
                  "mobile_number": businessPhoneNoController.text,
                  "profession_type": selectedBusineestype?.name,
                  "abn_acn": abnNumberController.text,
                  "address": addressController.text,
                  "type": type,
                  "dental_practice_id": userId,
                  "logo": practiceViewProfileData?.logo?.toJson(),
                }
              });
  }

  directorNavigationHandle(BuildContext context) async {
    final directorComplete =
        await LocalStorage.getBoolValue(LocalStorageConst.directoryComplete);
    directorComplete == false
        ? await context
            .read<AddDirectoryViewModel>()
            .fetchTheDirectorData(context)
        : navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);
  }

  Future<bool> profileCompletedValue() async {
    final profile =
        await LocalStorage.getBoolValue(LocalStorageConst.profileCompleted);
    return profile;
  }

  Future<void> getPlaceDetails(String placeId) async {
    final String apiKey = ApiConst.staticGoogleAPIKey;
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["status"] == "OK") {
          final result = data["result"];

          String? city;
          String? state;
          String? country;
          String? postalCode;

          for (var component in result["address_components"]) {
            var types = component["types"] as List;
            if (types.contains("locality")) {
              city = component["long_name"];
            } else if (types.contains("administrative_area_level_1")) {
              state = component["long_name"];
            } else if (types.contains("country")) {
              country = component["long_name"];
            } else if (types.contains("postal_code")) {
              postalCode = component["long_name"];
            }
          }

          cityController.text = city ?? '';
          stateController.text = state ?? '';
          countryController.text = country ?? '';
          zipCodeController.text = postalCode ?? '';
        } else {}
      }
    } catch (e) {}
  }

  Future<void> deleteAccount(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final result = await repo.deleteAccount();
    Loaders.circularHideLoader(context);
    if (result['delete_clients'] != null) {
      navigationService.pushNamedAndRemoveUntil(RouteList.login);
      LocalStorage.clearAllData();
      scaffoldMessenger('Delete account successfully');
    } else {
      navigationService.pushNamedAndRemoveUntil(RouteList.login);
      LocalStorage.clearAllData();
      scaffoldMessenger(result.toString());
    }
    notifyListeners();
  }

  Future<void> clearProfileData() async {
    nameController.clear();
    emailController.clear();
    phoneNoController.clear();
    businessNameController.clear();
    businessPhoneNoController.clear();
    businessEmailController.clear();
    websiteUrlController.clear();
    aboutUsController.clear();
    abnNumberController.clear();
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    businessPhoneNoController.clear();
    faxNumberController.clear();
    alternateEmailController.clear();
    alternatePhoneNoController.clear();
    addressController.clear();
    addressLineOneController.clear();
    addressLineTwoController.clear();
    cityController.clear();
    landmarkController.clear();
    countryController.clear();
    stateController.clear();
    zipCodeController.clear();
    aphraNumberController.clear();
    dateOfBirthController.clear();
    logoUrl = null;
    logoFile = null;
    selectedBusineestype = null;
    selectedPhoneCode = "AU (+61)";
    selectedSalutation = null;
    selectedGender = null;
    scheduleDate = null;
    _countryCode = '+61';
    _number = '';
    notifyListeners();
  }
}
