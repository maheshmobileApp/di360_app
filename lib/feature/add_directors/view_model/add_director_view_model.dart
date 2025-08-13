import 'dart:io';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/achievement_model.dart';
import 'package:di360_flutter/feature/add_directors/model/appoinments_model.dart';
import 'package:di360_flutter/feature/add_directors/model/certificate_model.dart';
import 'package:di360_flutter/feature/add_directors/model/document_model.dart';
import 'package:di360_flutter/feature/add_directors/model/gallery_model.dart';
import 'package:di360_flutter/feature/add_directors/model/service_model.dart';
import 'package:di360_flutter/feature/add_directors/model/social_links_model.dart';
import 'package:di360_flutter/feature/add_directors/model/team_members_model.dart';
import 'package:di360_flutter/feature/add_directors/model/timings_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDirectorViewModel extends ChangeNotifier with ValidationMixins {

  final TextEditingController MobileNumberController = TextEditingController();
  final TextEditingController CompanyNameController = TextEditingController();
  final TextEditingController ABNNumberController = TextEditingController();
  final TextEditingController AdreessController = TextEditingController();
  final TextEditingController CertificateNameController = TextEditingController();
  final TextEditingController ServiceNameController = TextEditingController();
  final TextEditingController AchievementNameController = TextEditingController(); 
  final TextEditingController DocumentNameController = TextEditingController();
  final TextEditingController TeamMemberNameController =  TextEditingController();
  final TextEditingController TeamMemberDesignationController =  TextEditingController();
  final TextEditingController TeamMemberPhoneNumberController =  TextEditingController();   
  final TextEditingController TeamMemberEmailIDController =  TextEditingController(); 
  final TextEditingController SocialAccountsController = TextEditingController();
  final TextEditingController  SelectTimeController = TextEditingController();
  final TextEditingController  SelectServiceStartTimeController = TextEditingController();
  final TextEditingController  SelectServiceEndTimeController = TextEditingController();
  final TextEditingController  SelecteBreakStartTimeController = TextEditingController();
  final TextEditingController  SelectBreakEndTimeController = TextEditingController();
  final TextEditingController  SelectServiceTimeminController= TextEditingController(); 
  //
  // Static data
  final List<String> teamMemberList = ['All Team Member', 'George'];
  final List<String> serviceList = ['1','2','4','5','6',];
  final List<String> DaysList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final List<String> AccountList = ['Facebook', 'Instagram', 'LinkedIn'];
  final List<String> BusineestypeList = [
    "Contractor",
    "Temporary Contractor",
    "Locum",
    "Full Time",
    "Part Time",
    "Casual"
  ];
  //
  //Foam valodation
  final GlobalKey<FormState> location = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(9, (_) => GlobalKey<FormState>()); 
  final List<int> stepsWithValidation = [0];
  final List<String> steps = [
    'Basic',
    'Services',
    'Certificates',
    'Achievements',
    'OurTeam',
    'Gallery',
    'Appointments',
    'Faqs',
    'Testimonials',
  ];
  final List<ServiceModel> Services = [];
  final List<CertificateModel> Certificates = [];
  final List< DocumentModel>Documents=[];
  final List<AchievementModel>Achievements=[];
  final List<TeamMembersModel>TeamMembers=[];
  final List<GalleryModel>Gallerys=[];
  final List<AppoinmentsModel>Appoinments=[];
  final List<TimingsModel>Timings=[];
  final List<SocialLinksModel>SocialLinks=[];
  final PageController pageController = PageController();
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => steps.length;

// Files
  File? logoFile;
  File? bannerFile;
  File? serviefile;
  File? certificateFile;
  File? achievementFile;
  File? documentFile;
  File? userFile;
  File? galleryFile;
//
  String? selectedTeamMember;
  String? selectedService;
  String? selectedDays;
  String? selectedAccount;
  String? selectedBusineestype;
  String shortDescription = "";
  DateTime? ServiceTimeDate;
  DateTime? ServiceStartTimeDate;
  DateTime? ServiceEndTimeDate;
  DateTime? BreakStartTimeDate;
  DateTime? BreakEndTimeDate;
  DateTime? SelectTime;

  bool Service = false;
  void toggleService(bool value) {
    Service = value;
    notifyListeners();
  }

  bool Appointments = false;
  void toggleAppointments(bool value) {
    Appointments = value;
    notifyListeners();
  }

  bool AllDay = false;
  void toggleAllDay(bool value) {
    AllDay = value;
    notifyListeners();
  }

  bool OurTeam = false;
  void toggleOurTeam(bool value) {
    OurTeam = value;
    notifyListeners();
  }

 bool validateCurrentStep() {
    if (_currentStep != 0) return true;
    return formKeys[0].currentState?.validate() ?? false;
  }
  void setSelectedBusineestype(String emp) {
    selectedBusineestype = emp;
    notifyListeners();
  }
  void setServiceTimeDate(DateTime date) {
    ServiceTimeDate = date;
    notifyListeners();
  }
  void setServiceStartTimeDate(DateTime date) {
    ServiceStartTimeDate = date;
    notifyListeners();
  }

  void setServiceEndTimeDate(DateTime date) {
    ServiceEndTimeDate = date;
    notifyListeners();
  }

  void setBreakStartTimeDate(DateTime date) {
    BreakStartTimeDate = date;
    notifyListeners();
  }

  void setBreakEndTimeDate(DateTime date) {
    BreakEndTimeDate = date;
    notifyListeners();
  }
 void setSelectedTime(DateTime date) {
    SelectTime = date;
    notifyListeners();
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

  //imagepickers...
  Future<void> pickLogoImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      logoFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickBannerImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      bannerFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickServicerImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      serviefile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickCertificateImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      certificateFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickAchievementImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      achievementFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickDocumentsImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      documentFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickUserImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      documentFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickGalleryImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      galleryFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  void addService() {
    Services.add(ServiceModel(
      name: ServiceNameController.text,
      appointment: Service,
      description: shortDescription,
      imageFile: serviefile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    shortDescription = "";
    notifyListeners();
  }
void addCertificates() {
   Certificates.add(CertificateModel(
      name:CertificateNameController.text,
      imageFile:certificateFile,
    ));
   CertificateNameController.clear();
   certificateFile = null;
    notifyListeners();
  }
  void addDocument() {
    Documents.add(DocumentModel(
      name: DocumentNameController.text,
      imageFile: documentFile,
    ));
    ServiceNameController.clear();
     documentFile = null;
    notifyListeners();
  }
  void addAchievement() {
    Achievements.add( AchievementModel(
      name: AchievementNameController.text,
      imageFile: achievementFile,
    ));
   AchievementNameController.clear();
   achievementFile = null;
    notifyListeners();
  }
  /*void addTeamMember() {
    TeamMembers.add(TeamMembersModel(
      name: TeamMemberNameController.text,
      appointment: Service,
      imageFile: serviefile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    shortDescription = "";
    notifyListeners();
  }
  void addGallery() {
    services.add(ServiceModel(
      name:CertificateNameController.text,
      imageFile:certificateFile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    shortDescription = "";
    notifyListeners();
  }
   void addAppointments() {
    services.add(ServiceModel(
      name: ServiceNameController.text,
      appointment: Service,
      description: shortDescription,
      imageFile: serviefile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    shortDescription = "";
    notifyListeners();
  }
  void addTimings() {
    services.add(ServiceModel(
      name: ServiceNameController.text,
      appointment: Service,
      description: shortDescription,
      imageFile: serviefile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    shortDescription = "";
    notifyListeners();
  }
  void addSocialLinks() {
    services.add(ServiceModel(
      name: ServiceNameController.text,
      appointment: Service,
      description: shortDescription,
      imageFile: serviefile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    shortDescription = "";
    notifyListeners();
  }*/
 

  @override
  void dispose() {
    MobileNumberController.dispose();
    CompanyNameController.dispose();
    ABNNumberController.dispose();
    CertificateNameController.dispose();
    ServiceNameController.dispose();
    AchievementNameController.dispose();
    DocumentNameController.dispose();
    TeamMemberNameController.dispose();
    TeamMemberDesignationController.dispose();
    TeamMemberPhoneNumberController.dispose();
    TeamMemberEmailIDController.dispose();
    SocialAccountsController.dispose();
    SelectTimeController.dispose();
    SelectServiceStartTimeController.dispose();
    SelectServiceEndTimeController.dispose();
    SelecteBreakStartTimeController.dispose();
    SelectBreakEndTimeController.dispose();
     SelectServiceTimeminController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
 
