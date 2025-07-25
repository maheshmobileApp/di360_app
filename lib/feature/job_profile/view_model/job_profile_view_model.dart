import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repo_impl.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repository.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class JobProfileViewModel extends ChangeNotifier with ValidationMixins {
  final JobCreateRepository repo = JobCreateRepoImpl();

  JobProfileViewModel() {
    fetchJobRoles();
  }

  // Controllers
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController abnNumberController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
 final TextEditingController availabilityDateController = TextEditingController();

  //
  //Foam valodation
  final GlobalKey<FormState> location = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
    List.generate(6, (_) => GlobalKey<FormState>());
  final List<int> stepsWithValidation = [0];
final List<String> steps = [
  'Personal ',
  'Professional ',
  'Skills',
  'Availability',
  'Location',
];
final PageController pageController = PageController();
int _currentStep = 0;
int get currentStep => _currentStep;
int get totalSteps => steps.length;

bool validateCurrentStep() {
  if (_currentStep != 0) return true;
  return formKeys[0].currentState?.validate() ?? false;
}
//
// Selected dropdown values
  String? selectedRole;
  String? selectedEmploymentType;
  String? selectCountry;
  String? selectExperience;
  String? selectskills;
  String? selectworkRight;
  String selectedAvailabilityType = "Select Day";
// Files
  File? profileFile;
//
// Static data
 
  final List<String> employmentTypeList = [
    "Contractor",
    "Temporary Contractor",
    "Locum",
    "Full Time",
    "Part Time",
    "Casual"
  ];
  final List<String> countryList = ["India", "US", "PK"];
  final List<String> experienceOptions = [
    "0",
    "1-2",
    "3-5",
    "5-10",
    "10-15",
    "15-20",
    "20-25",
    "25-30",
    "30-35",
    "35-40",
    "40+"
  ];
  final List<String> skillsList = ["Skill A", "Skill B", "Skill C"];
  final List<String> workRightList = [
    "Australian citizen",
    "Permanent resident",
    "Temporary resident",
    "Overseas Student with work permit"
  ];
 List<String> weekDays = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
 List<String> availabilityTypes = [
  "Select Day",
  "Select Date"
];
  // Employment types
  final List<String> _selectedEmploymentChips = [];
  List<String> get selectedEmploymentChips => _selectedEmploymentChips;
   bool get shouldShowABNField {
  return _selectedEmploymentChips.any((type) =>
      type == "Contractor" ||
      type == "Temporary Contractor" ||
      type == "Locum");
}
List<String> getSelectedEmploymentTypes() =>
      List.from(_selectedEmploymentChips);
  //
  //Roles types
  List<JobsRoleList> jobRoles = [];
  List<String> roleOptions = [];
  //
  //Willing to travel
  bool isWillingToTravel = false;
  //
  //Availability
  bool isJoiningImmediate = false;
  DateTime? joiningDate;
  List<DateTime> joiningDates = [];
  //
  //Availability Type 
  List<DateTime> availabilityDates = [];
  List<String> selectedDays = [];
  List<DateTime> selectedDates = [];
  //
  bool isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

  // ───── Navigation Methods ─────
  //stepview navigations...
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
//validation methods.....
bool validateJobProfileLocation() {
  return location.currentState?.validate() ?? false;
}  
  // ───── Dropdown setters ─────
  void setSelectedRole(String? value) {
    selectedRole = value;
    notifyListeners();
  }
  void setSelectedCountry(String value) {
    selectCountry = value;
    notifyListeners();
  }
  void setSelectedEmpType(String emp) {
    selectedEmploymentType = emp;
    notifyListeners();
  }
  void setSelectedExperience(String? value) {
    selectExperience = value;
    notifyListeners();
  }
 void setSelectedWorkRight(String? value) {
     selectworkRight = value;
    notifyListeners();
  }
  void setSelectedSkills(String? value) {
     selectskills = value;
    notifyListeners();
  }
  
  // ───── Employment Chips ─────
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
  // ─────WillingToTravel ─────
  void toggleWillingToTravel(bool value) {
    isWillingToTravel = value;
    notifyListeners();
  }
  //─────ImmediateORJoining─────
  void toggleJoiningImmediate(bool value) {
    isJoiningImmediate = value;
    if (value) {
      joiningDate = null; 
    }
    notifyListeners();
  } 
  //─────JoiningDate─────
  void toggleJoiningDate(DateTime date) {
  if (joiningDates.any((d) => isSameDate(d, date))) {
    joiningDates.removeWhere((d) => isSameDate(d, date));
  } else {
    joiningDates.add(date);
  }
  updateJoiningDateControllerText();
}
void removeJoiningDate(DateTime date) {
  joiningDates.removeWhere((d) => isSameDate(d, date));
  updateJoiningDateControllerText();
}
void updateJoiningDateControllerText() {
  final formatted = joiningDates.map((d) => DateFormat('d/M/yyyy').format(d)).toList();
  joiningDateController.text = formatted.join(" | ");
  notifyListeners();
}

 //─────SelectabilityType─────
  void setAvailabilityType(String type) {
    selectedAvailabilityType = type;
    selectedDays.clear();
    selectedDates.clear();
    notifyListeners();
  }
  //─────SelectDay─────
  void toggleDay(String day) {
  if (selectedDays.contains(day)) {
    selectedDays.remove(day);
  } else {
    selectedDays.add(day);
  }
  notifyListeners();
}
 //─────SelectDate─────
 //─────SelectAvailabilityDate─────
  void toggleAvailabilityDate(DateTime date) {
  if (availabilityDates.any((d) => isSameDate(d, date))) {
    availabilityDates.removeWhere((d) => isSameDate(d, date));
  } else {
    availabilityDates.add(date);
  }
  updateAvailabilityDateControllerText();
}

void removeAvailabilityDate(DateTime date) {
  availabilityDates.removeWhere((d) => isSameDate(d, date));
  updateAvailabilityDateControllerText();
}

void updateAvailabilityDateControllerText() {
  final formatted = availabilityDates.map((d) => DateFormat('d/M/yyyy').format(d)).toList();
  availabilityDateController.text = formatted.join(" | ");
  notifyListeners();
}

  // ───── Data Fetching ─────
  //getjobrolesfromjson....
 Future<void> fetchJobRoles() async {
    jobRoles = await repo.getJobRoles();
    roleOptions = jobRoles.map((role) => role.roleName ?? "").toList();
    notifyListeners();
  }
  //imagepickers...
   Future<void> pickProfileImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      final img = await LocalStorage.getStringVal(LocalStorageConst.profilePic);

     profileFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }
@override
void dispose() {
  mobileNumberController.dispose();
  emailAddressController.dispose();
  abnNumberController.dispose();
  pageController.dispose();
  super.dispose();
}

}
