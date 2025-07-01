import 'dart:io';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? selectedRole;
String? selectedEmploymentType;

class JobCreateViewModel extends ChangeNotifier {
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
  final List<String> roleOptions = [
    "Software Developer",
    "UI/UX Designer",
    "Project Manager",
    "Data Analyst",
    "Marketing Specialist"
  ];
  final List<String> empType = [
    "fullTime",
    "Half",
    "Day duty",
    "NtyDuty",
    "shift"
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
  final int totalSteps = 5;

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

  void setSelectedRole(String role) {
    selectedRole = role;
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

  // Get all selected employment types as a list
  List<String> getSelectedEmploymentTypes() {
    return List.from(_selectedEmploymentChips);
  }

  void setSelectedEmpType(String emp) {
    selectedEmploymentType = emp;
    notifyListeners();
  }
}
