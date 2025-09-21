import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/repositorys/add_profess_director_repository_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
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
  List<TextEditingController> hobbiesCntr = [];
  List<TextEditingController> universitiesCntr = [];
  List<TextEditingController> educationCntr = [];
  List<TextEditingController> workAtCntr = [];

// Navigation
  final PageController pageController = PageController();
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => ConstantData.profesSteps.length;
  final List<GlobalKey<FormState>> formKeys =
      List.generate(7, (_) => GlobalKey<FormState>());

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

  void loadHobbies(List<Hobbies> list) {
    hobbiesCntr =
        list.map((h) => TextEditingController(text: h.name ?? "")).toList();
    notifyListeners();
  }

  void updateHobby(BuildContext context, int index, String value) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.hobbies?[index].name = value;
    notifyListeners();
  }

  void addHobby(BuildContext context) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.hobbies?.add(Hobbies(name: null));
    hobbiesCntr.add(TextEditingController());
    notifyListeners();
  }

  void removeHobby(BuildContext context, int index) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.hobbies?.removeAt(index);
    hobbiesCntr.removeAt(index);
    notifyListeners();
  }

  void loadUniversities(List<UniversitySchool> list) {
    universitiesCntr =
        list.map((h) => TextEditingController(text: h.name ?? "")).toList();
    notifyListeners();
  }

  void updateUniversities(BuildContext context, int index, String value) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.universitySchool?[index].name = value;
    notifyListeners();
  }

  void addUniversities(BuildContext context) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.universitySchool
        ?.add(UniversitySchool(name: null));
    universitiesCntr.add(TextEditingController());
    notifyListeners();
  }

  void removeUniversities(BuildContext context, int index) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.universitySchool?.removeAt(index);
    universitiesCntr.removeAt(index);
    notifyListeners();
  }

  void loadEducation(List<Education> list) {
    educationCntr =
        list.map((h) => TextEditingController(text: h.name ?? "")).toList();
    notifyListeners();
  }

  void updateEducation(BuildContext context, int index, String value) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.education?[index].name = value;
    notifyListeners();
  }

  void addEducation(BuildContext context) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.education?.add(Education(name: null));
    educationCntr.add(TextEditingController());
    notifyListeners();
  }

  void removeEducation(BuildContext context, int index) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.education?.removeAt(index);
    educationCntr.removeAt(index);
    notifyListeners();
  }

  void loadWorkAt(List<WorkingAt> list) {
    workAtCntr =
        list.map((h) => TextEditingController(text: h.name ?? "")).toList();
    notifyListeners();
  }

  void updateWorkAt(BuildContext context, int index, String value) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.workingAt?[index].name = value;
    notifyListeners();
  }

  void addWorkAt(BuildContext context) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.workingAt?.add(WorkingAt(name: null));
    workAtCntr.add(TextEditingController());
    notifyListeners();
  }

  void removeWorkAt(BuildContext context, int index) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.getBasicInfoData.first.workingAt?.removeAt(index);
    workAtCntr.removeAt(index);
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
            ? addDirectorVM.getBasicInfoData.first.bannerImage
            : banner,
        "profile_image": profile == null
            ? addDirectorVM.getBasicInfoData.first.profileImage
            : profile,
        "university_school": addDirectorVM.getBasicInfoData.first.universitySchool,
        "working_at": addDirectorVM.getBasicInfoData.first.workingAt,
        "designation": designationCntr.text,
        "education": addDirectorVM.getBasicInfoData.first.education,
        "hobbies": addDirectorVM.getBasicInfoData.first.hobbies,
        "special_interests": [],
        "type": "PROFESSIONAL",
        "latitude": '',
        "longitude": '',
        "pincode": "",
        "dental_professional_id": userId
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
      addDirectorVM.getDirectories();
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
            addDirectorVM.getBasicInfoData.first.universitySchool,
        "working_at": addDirectorVM.getBasicInfoData.first.workingAt,
        "designation": designationCntr.text,
        "education": addDirectorVM.getBasicInfoData.first.education,
        "hobbies": addDirectorVM.getBasicInfoData.first.hobbies,
        "special_interests": [],
        "type": "PROFESSIONAL"
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
      addDirectorVM.getDirectories();
      scaffoldMessenger('Update BasicInfo successfully');
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
    loadHobbies(data.hobbies ?? []);
    loadUniversities(data.universitySchool ?? []);
    loadEducation(data.education ?? []);
    loadWorkAt(data.workingAt ?? []);
    notifyListeners();
  }
}
