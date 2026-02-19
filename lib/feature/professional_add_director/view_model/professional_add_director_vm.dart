import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/repositorys/add_profess_director_repository_impl.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
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

  List<Hobbies> getHobbies = [];
  List<UniversitySchool> getUniversitys = [];
  List<Education> getEducation = [];
  List<WorkingAt> getWorkingAt = [];

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

  void addHobby(String value) {
    if (value.isNotEmpty) {
      getHobbies.add(Hobbies(name: value));
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
      getUniversitys.add(UniversitySchool(name: value));
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
      getEducation.add(Education(name: value));
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
      getWorkingAt.add(WorkingAt(name: value));
      workAtCntr.clear();
    }
    notifyListeners();
  }

  void removeWorkAt(int index) {
    getWorkingAt.removeAt(index);
    notifyListeners();
  }

  Future<void> addBasicData(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);

    var profile = addDirectorVM.logoFile == null
        ? null
        : await repository.http.uploadImage(addDirectorVM.logoFile?.path);
    var banner = addDirectorVM.bannerFile == null
        ? null
        : await repository.http.uploadImage(addDirectorVM.bannerFile?.path);
    final result = await repository.addProfesBasicInfo({
      "professinalObj": {
        "name": nameController.text,
        "phone": mobileNumberCntr.text,
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
        "dental_professional_id": userId
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
      addDirectorVM.getDirectories();
      goToNextStep();
      scaffoldMessenger('Add BasicInfo successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateBasicData(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);

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
        "phone": mobileNumberCntr.text,
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
        "university_school":
            getUniversitys,
        "working_at": getWorkingAt,
        "designation": designationCntr.text,
        "education": getEducation,
        "hobbies": getHobbies,
        "special_interests": [],
        "type": UserRole.professional.value
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
      addDirectorVM.getDirectories();
      goToNextStep();
      scaffoldMessenger('Updated Basic Information successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  assignTheProfessBasic(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    final data = addDirectorVM.getBasicInfoData.first;
    nameController.text = data.name ?? '';
    mobileNumberCntr.text = data.phone ?? '';
    final document = parse(data.description ?? '');
    final String parsedString = document.body?.text ?? "";
    descController.text = parsedString;
    addressController.text = data.address ?? '';
    emailController.text = data.email ?? '';
    alternateNumberController.text = data.altPhone ?? '';
    designationCntr.text = data.designation ?? '';
    getHobbies = data.hobbies ?? [];
    getUniversitys = data.universitySchool ?? [];
    getEducation = data.education ?? [];
    getWorkingAt = data.workingAt ?? [];
    notifyListeners();
  }
}
