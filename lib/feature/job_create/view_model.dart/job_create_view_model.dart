import 'dart:io';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repo_impl.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repository.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? selectedRole;
String? selectedEmploymentType;

class JobCreateViewModel extends ChangeNotifier {
  final JobCreateRepository repo = JobCreateRepoImpl();
  JobCreateViewModel(){
    fetchJobRoles();
    fetchEmpTypes();
  }
  final TextEditingController videoLinkController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instgramController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  String? selectedRole;
  String? selectedEmploymentType;
  String? selectCountry;

  List<String> _selectedEmploymentChips = [];
  List<String> get selectedEmploymentChips => _selectedEmploymentChips;

  File? logoFile;
  File? bannerFile;
  Future<void> pickLogoImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      logoFile = File(pickedFile.path);
      NavigationService().goBack;
      notifyListeners();
    }
  }

  Future<void> pickBannerImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      bannerFile = File(pickedFile.path);
      NavigationService().goBack;
      notifyListeners();
    }
  }

  final List<String> countryList = [
    "India",
    "us",
    "pk",
  ];

 
  final List<String> steps = [
    'Job Info',
    'Logo, etc',
    'Location',
    'Other info',
    'Pay',
    'Links',
  ];

  final PageController pageController = PageController();
  int _currentStep = 0;
  final int totalSteps = 6;
  int get currentStep => _currentStep;

  void goToNextStep() {
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      print("object");
      notifyListeners();
    }
  }

  void goToPreviousStep() {
    if (_currentStep > 0) {
      pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);

      _currentStep--;
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      _currentStep = step;
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);

      notifyListeners();
    }
  }

  List<JobsRoleList> jobRoles = [];
  List<String> roleOptions = [];
 List<JobTypes> EmpTypes = [];
  List<String> empOptions = [];
  Future<void> fetchJobRoles() async {
  jobRoles = await repo.getJobRoles();
  roleOptions = jobRoles.map((role) => role.roleName ?? "").toList();
  notifyListeners();
}

  void setSelectedRole(String? value) {
    selectedRole = value;
    notifyListeners();
  }

  void setSelectedCountry(String sc) {
    selectCountry = sc;
    notifyListeners();
  }

  void addEmploymentTypeChip(String empType) {
    if (!_selectedEmploymentChips.contains(empType)) {
      _selectedEmploymentChips.add(empType);
      notifyListeners();
    }
  }

  void removeEmploymentTypeChip(String empType) {
    _selectedEmploymentChips.remove(empType);
    notifyListeners();
  }

  void clearEmploymentTypeChips() {
    _selectedEmploymentChips.clear();
    notifyListeners();
  }

  
  List<String> getSelectedEmploymentTypes() {
    return List.from(_selectedEmploymentChips);
  }
Future<void> fetchEmpTypes() async {
  EmpTypes = await repo.getEmpTypes();
  empOptions = EmpTypes.map((emp) => emp.employeeTypeName ?? "").toList();
  notifyListeners();
}
  void setSelectedEmpType(String emp) {
    selectedEmploymentType = emp;
    notifyListeners();
  }
}
