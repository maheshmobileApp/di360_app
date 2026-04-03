import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/repositorys/add_profess_director_repository_impl.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/email_phone_visiable_enums.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class ProfessionalAddDirectorVm extends ChangeNotifier {
  final AddProfessDirectorRepositoryImpl repository =
      AddProfessDirectorRepositoryImpl();

  final TextEditingController mobileNumberCntr = TextEditingController();
  final TextEditingController designationCntr = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  TextEditingController hobbiesCntr = TextEditingController();
  TextEditingController universitiesCntr = TextEditingController();
  TextEditingController educationCntr = TextEditingController();
  TextEditingController workAtCntr = TextEditingController();

  double? latitude;
  double? longitude;

  List<String> getHobbies = [];
  List<String> getUniversitys = [];
  List<String> getEducation = [];
  List<String> getWorkingAt = [];

// Navigation
  final PageController pageController = PageController();
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => ConstantData.profesSteps.length;
  final List<GlobalKey<FormState>> formKeys =
      List.generate(3, (_) => GlobalKey<FormState>());

  updateCurrentStep() {
    _currentStep = 0;
    notifyListeners();
  }

  bool validateCurrentStep() {
    if (_currentStep != 0) return true;
    return formKeys[0].currentState?.validate() ?? false;
  }

  void goToNextStep() {
    if (!validateCurrentStep()) return;
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  void goToPreviousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      assignTheProfessBasic(navigatorKey.currentContext!);
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      _currentStep = step;
      pageController.jumpToPage(step);
      notifyListeners();
    }
  }

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

  String? _emailVisibility;

  String? get emailVisibility => _emailVisibility;

  void setEmailVisibility(String? value) {
    _emailVisibility = value;
    notifyListeners();
  }

  String? _phoneVisibility;

  String? get phoneVisibility => _phoneVisibility;

  void setPhoneVisibility(String? value) {
    _phoneVisibility = value;
    notifyListeners();
  }

  void addHobby(String value) {
    if (value.isNotEmpty) {
      if (value.contains(',')) {
        getHobbies.addAll(
            value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty));
      } else {
        getHobbies.add(value);
      }
      hobbiesCntr.clear();
      notifyListeners();
    }
  }

  void removeHobby(int index) {
    getHobbies.removeAt(index);
    notifyListeners();
  }

  void addUniversities(String value) {
    if (value.isNotEmpty) {
      if (value.contains(',')) {
        getUniversitys.addAll(
            value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty));
      } else {
        getUniversitys.add(value);
      }
      universitiesCntr.clear();
    }
    notifyListeners();
  }

  void removeUniversities(int index) {
    getUniversitys.removeAt(index);
    notifyListeners();
  }

  void addEducation(String value) {
    if (value.isNotEmpty) {
      if (value.contains(',')) {
        getEducation.addAll(
            value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty));
      } else {
        getEducation.add(value);
      }
      educationCntr.clear();
    }
    notifyListeners();
  }

  void removeEducation(int index) {
    getEducation.removeAt(index);
    notifyListeners();
  }

  void addWorkAt(String value) {
    if (value.isNotEmpty) {
      if (value.contains(',')) {
        getWorkingAt.addAll(
            value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty));
      } else {
        getWorkingAt.add(value);
      }
      workAtCntr.clear();
    }
    notifyListeners();
  }

  void removeWorkAt(int index) {
    getWorkingAt.removeAt(index);
    notifyListeners();
  }

  updateTheHobbyEducationUniversityWorksListData() {
    final hobby = hobbiesCntr.text;
    final university = universitiesCntr.text;
    final education = educationCntr.text;
    final workAt = workAtCntr.text;
    if (hobby.isNotEmpty) {
      addHobby(hobby);
    }
    if (university.isNotEmpty) {
      addUniversities(university);
    }
    if (education.isNotEmpty) {
      addEducation(education);
    }
    if (workAt.isNotEmpty) {
      addWorkAt(workAt);
    }
    notifyListeners();
  }

  Future<void> addBasicData(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    updateTheHobbyEducationUniversityWorksListData();
    var profile = addDirectorVM.logoFile == null
        ? null
        : await repository.http.uploadImage(addDirectorVM.logoFile?.path);
    var banner = addDirectorVM.bannerFile == null
        ? null
        : await repository.http.uploadImage(addDirectorVM.bannerFile?.path);
    final result = await repository.addProfesBasicInfo({
      "professinalObj": {
        "name": nameController.text,
        "phone": '$_countryCode${mobileNumberCntr.text}',
        "email": emailController.text,
        "address": addressController.text,
        "alt_phone": alternateNumberController.text,
        "profession_type": addDirectorVM.selectedBusineestype?.name,
        "description": descController.text,
        "directory_category_id": addDirectorVM.selectedBusineestype?.id,
        "banner_image": banner == null
            ? addDirectorVM.getBasicInfoData.isEmpty
                ? null
                : addDirectorVM.getBasicInfoData.first.bannerImage
            : banner,
        "profile_image": profile == null
            ? addDirectorVM.getBasicInfoData.isEmpty
                ? null
                : addDirectorVM.getBasicInfoData.first.profileImage
            : profile,
        "university_school": getUniversitys,
        "working_at": getWorkingAt,
        "designation": designationCntr.text,
        "education": getEducation,
        "hobbies": getHobbies,
        "special_interests": [],
        "type": UserRole.professional.value,
        "latitude": addDirectorVM.getBasicInfoData.isEmpty
            ? null
            : addDirectorVM.getBasicInfoData.first.latitude == null
                ? latitude
                : addDirectorVM.getBasicInfoData.first.latitude,
        "longitude": addDirectorVM.getBasicInfoData.isEmpty
            ? null
            : addDirectorVM.getBasicInfoData.first.longitude == null
                ? longitude
                : addDirectorVM.getBasicInfoData.first.longitude,
        "pincode": "",
        "dental_professional_id": userId,
        "phone_visibility":
            VisibilityType.fromDisplayName(phoneVisibility)?.name ?? 'PRIVATE',
        "email_visibility":
            VisibilityType.fromDisplayName(emailVisibility)?.name ?? 'PRIVATE'
      }
    });
    if (result != null) {
      await LocalStorage.setBoolValue(
          LocalStorageConst.directoryComplete, true);
      await LocalStorage.setBoolValue(
          LocalStorageConst.firstNavigationDirectory, true);
      Loaders.circularHideLoader(context);
      addDirectorVM.getDirectories();
      goToNextStep();
      scaffoldMessenger('Add BasicInfo successfully');
      await updateViewProfile(
          addDirectorVM.selectedBusineestype?.name ?? '',
          profile == null
              ? addDirectorVM.getBasicInfoData.first.profileImage
              : profile);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateBasicData(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    updateTheHobbyEducationUniversityWorksListData();
    var profile = addDirectorVM.logoFile == null
        ? null
        : await repository.http.uploadImage(addDirectorVM.logoFile?.path);
    var banner = addDirectorVM.bannerFile == null
        ? null
        : await repository.http.uploadImage(addDirectorVM.bannerFile?.path);
    final result = await repository.updateProfesBasicInfo({
      "id": addDirectorVM.getBasicInfoData.first.id,
      "professinalUpdateObj": {
        "name": nameController.text,
        "phone": '$_countryCode${mobileNumberCntr.text}',
        "email": emailController.text,
        "address": addressController.text,
        "alt_phone": alternateNumberController.text,
        "profession_type": addDirectorVM.selectedBusineestype?.name,
        "description": descController.text,
        "directory_category_id": addDirectorVM.selectedBusineestype?.id,
        "banner_image": banner == null
            ? addDirectorVM.getBasicInfoData.first.bannerImage
            : banner,
        "profile_image": profile == null
            ? addDirectorVM.getBasicInfoData.first.profileImage
            : profile,
        "university_school": getUniversitys,
        "working_at": getWorkingAt,
        "designation": designationCntr.text,
        "education": getEducation,
        "hobbies": getHobbies,
        "special_interests": [],
        "type": UserRole.professional.value,
        "phone_visibility":
            VisibilityType.fromDisplayName(phoneVisibility)?.name ?? 'PRIVATE',
        "email_visibility":
            VisibilityType.fromDisplayName(emailVisibility)?.name ?? 'PRIVATE'
      }
    });
    if (result != null) {
      await LocalStorage.setBoolValue(
          LocalStorageConst.directoryComplete, true);
      Loaders.circularHideLoader(context);
      addDirectorVM.getDirectories();
      goToNextStep();
      scaffoldMessenger('Updated Basic Information successfully');
      await updateViewProfile(
          addDirectorVM.selectedBusineestype?.name ?? '',
          profile == null
              ? addDirectorVM.getBasicInfoData.first.profileImage
              : profile);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateViewProfile(String profesType, dynamic prfImg) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    await repository.updateProfesViewProfile({
      "id": userId,
      "changes": {
        "name": nameController.text,
        "address": addressController.text,
        "profession_type": profesType,
        "profile_image": prfImg
      }
    });
  }

  assignTheProfessBasic(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    final viewProfileVM = context.read<ViewProfileViewModel>();
    if (addDirectorVM.getBasicInfoData.isEmpty) {
      assignViewProfileData(context);
      return;
    }
    final data = addDirectorVM.getBasicInfoData.first;
    final viewProfileData = viewProfileVM.professionalViewProfileData;
    nameController.text = data.name ?? viewProfileData?.name ?? '';
    final phone = data.phone ?? viewProfileData?.phone ?? "";
    if (phone.startsWith('+61')) {
      _countryCode = '+61';
      mobileNumberCntr.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      _countryCode = '+64';
      mobileNumberCntr.text = phone.substring(3);
    } else {
      _countryCode = '+61';
      mobileNumberCntr.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    final allCategories = addDirectorVM.directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.id == data.directoryCategoryId,
      orElse: () => null,
    );
    if (businessType != null) {
      addDirectorVM.setSelectedBusineestype(businessType);
    }
    final document = parse(data.description ?? '');
    final String parsedString = document.body?.text ?? "";
    descController.text = parsedString;
    addressController.text = data.address ?? viewProfileData?.address ?? '';
    emailController.text = data.email ?? viewProfileData?.email ?? '';
    alternateNumberController.text =
        data.altPhone ?? viewProfileData?.altPhone ?? '';
    designationCntr.text = data.designation ?? '';
    setEmailVisibility(
        VisibilityType.fromEnumName(data.emailVisibility)?.displayName);
    setPhoneVisibility(
        VisibilityType.fromEnumName(data.phoneVisibility)?.displayName);
    getHobbies = data.hobbies ?? [];
    getUniversitys = data.universitySchool ?? [];
    getEducation = data.education ?? [];
    getWorkingAt = data.workingAt ?? [];
    notifyListeners();
  }

  assignViewProfileData(BuildContext context) async {
    final viewProfileVM = context.read<ViewProfileViewModel>();
    await viewProfileVM.getTheViewProfileData();
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    final data = viewProfileVM.professionalViewProfileData;

    nameController.text = data?.name ?? '';
    final phone = data?.phone ?? "";
    if (phone.startsWith('+61')) {
      _countryCode = '+61';
      mobileNumberCntr.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      _countryCode = '+64';
      mobileNumberCntr.text = phone.substring(3);
    } else {
      _countryCode = '+61';
      mobileNumberCntr.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    final allCategories = addDirectorVM.directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.name == data?.professionType,
      orElse: () => null,
    );
    if (businessType != null) {
      addDirectorVM.setSelectedBusineestype(businessType);
    }
    addressController.text = data?.address ?? '';
    emailController.text = data?.email ?? '';
    alternateNumberController.text = data?.altPhone ?? '';
    notifyListeners();
  }

  Future<void> clearProfessionalDirectorData() async {
    mobileNumberCntr.clear();
    designationCntr.clear();
    nameController.clear();
    emailController.clear();
    descController.clear();
    alternateNumberController.clear();
    addressController.clear();
    hobbiesCntr.clear();
    universitiesCntr.clear();
    educationCntr.clear();
    workAtCntr.clear();
    latitude = null;
    longitude = null;
    getHobbies.clear();
    getUniversitys.clear();
    getEducation.clear();
    getWorkingAt.clear();
    _currentStep = 0;
    _countryCode = '+61';
    _number = '';
    _emailVisibility = null;
    _phoneVisibility = null;
    notifyListeners();
  }
}
