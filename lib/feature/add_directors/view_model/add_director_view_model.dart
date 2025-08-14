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
//controller....
  final TextEditingController MobileNumberController = TextEditingController();
  final TextEditingController CompanyNameController = TextEditingController();
  final TextEditingController ABNNumberController = TextEditingController();
  final TextEditingController AdreessController = TextEditingController();
  final TextEditingController CertificateNameController =
      TextEditingController();
  final TextEditingController ServiceNameController = TextEditingController();
  final TextEditingController ServiceDescriptionController =
      TextEditingController();
  final TextEditingController AchievementNameController =
      TextEditingController();
  final TextEditingController DocumentNameController = TextEditingController();
  final TextEditingController TeamMemberNameController =
      TextEditingController();
  final TextEditingController TeamMemberDesignationController =
      TextEditingController();
  final TextEditingController TeamMemberPhoneNumberController =
      TextEditingController();
  final TextEditingController TeamMemberEmailIDController =
      TextEditingController();
  final TextEditingController SocialAccountsController =
      TextEditingController();
  final TextEditingController SelectTimeController = TextEditingController();
  final TextEditingController SelectServiceStartTimeController =
      TextEditingController();
  final TextEditingController SelectServiceEndTimeController =
      TextEditingController();
  final TextEditingController SelecteBreakStartTimeController =
      TextEditingController();
  final TextEditingController SelectBreakEndTimeController =
      TextEditingController();
  final TextEditingController SelectServiceTimeminController =
      TextEditingController();

  //
  // Static lists
  final List<String> teamMemberList = ['All Team Member', 'George'];
  final List<String> serviceList = [
    '1',
    '2',
    '4',
    '5',
    '6',
  ];
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
      List.generate(10, (_) => GlobalKey<FormState>());
  final List<int> stepsWithValidation = [0];
  final List<String> steps = [
    'Basic',
    'Services',
    'Certificates',
    'Achievements',
    'Documents',
    'OurTeam',
    'Gallery',
    'Appointments',
    'Faqs',
    'Testimonials',
  ];
  //
  // Models
  final List<ServiceModel> Services = [];
  final List<CertificateModel> Certificates = [];
  final List<DocumentModel> Documents = [];
  final List<AchievementModel> Achievements = [];
  final List<TeamMembersModel> TeamMembers = [];
  final List<GalleryModel> Gallerys = [];
  final List<AppoinmentsModel> Appoinments = [];
  final List<TimingsModel> Timings = [];
  final List<SocialLinksModel> SocialLinks = [];
  //
  // Navigation
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
  // Selected dropdowns
  String? selectedTeamMember;
  String? selectedTeamService;
  String? selectedDays;
  String? selectedAccount;
  String? selectedBusineestype;
  ServiceModel? selectedService;
  TeamMembersModel?selectedteamember;
  AppoinmentsModel ?selectedAppoinment;
  TimingsModel ?selectedTimigs;
  SocialLinksModel ?selectedSocialLinks;

  //
  // Other fields
  DateTime? ServiceTimeDate;
  DateTime? ServiceStartTimeDate;
  DateTime? ServiceEndTimeDate;
  DateTime? BreakStartTimeDate;
  DateTime? BreakEndTimeDate;
  DateTime? SelectTime;
  //
  // Toggles
  bool Service = false;
  bool Appointments = false;
  bool AllDay = false;
  bool OurTeam = false;

  void toggleService(bool value) {
    Service = value;
    notifyListeners();
  }

  void toggleAppointments(bool value) {
    Appointments = value;
    notifyListeners();
  }

  void toggleAllDay(bool value) {
    AllDay = value;
    notifyListeners();
  }

  void toggleOurTeam(bool value) {
    OurTeam = value;
    notifyListeners();
  }

  bool validateCurrentStep() {
    if (_currentStep != 0) return true;
    return formKeys[0].currentState?.validate() ?? false;
  }

  //
  // Step navigation
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

  //
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

  //
  // Add methods
  void addService() {
    Services.add(ServiceModel(
      name: ServiceNameController.text,
      appointment: Service,
      description: ServiceDescriptionController.text,
      imageFile: serviefile,
    ));
    ServiceNameController.clear();
    Service = true;
    serviefile = null;
    ServiceDescriptionController.clear();
    notifyListeners();
  }
  void addCertificates() {
    Certificates.add(CertificateModel(
      name: CertificateNameController.text,
      imageFile: certificateFile,
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
    Achievements.add(AchievementModel(
      name: AchievementNameController.text,
      imageFile: achievementFile,
    ));
    AchievementNameController.clear();
    achievementFile = null;
    notifyListeners();
  }
  void addTeamMember() {
    TeamMembers.add(TeamMembersModel(
      name: TeamMemberNameController.text,
      Designation: TeamMemberDesignationController.text,
      PhoneNumber: TeamMemberDesignationController.text,
      EmailID: TeamMemberEmailIDController.text,
      appointment: Appointments,
      ourTeam: OurTeam,
      imageFile: userFile,
    ));
    TeamMemberNameController.clear();
    TeamMemberDesignationController.clear();
    TeamMemberDesignationController.clear();
    TeamMemberEmailIDController.clear();
    Appointments = true;
    OurTeam = true;
    userFile = null;
    notifyListeners();
  }
  void addGallery() {
    Gallerys.add(GalleryModel(
      imageFile: galleryFile,
    ));
    galleryFile = null;
    notifyListeners();
  }
  void addAppointments() {
  Appoinments.add(
    AppoinmentsModel(
      teamMemberName: selectedTeamMember,
      services: selectedTeamService,
      selectADay: selectedDays,
      serviceTime: ServiceTimeDate,
      serviceStartTime: ServiceStartTimeDate,
      serviceEndTime: ServiceEndTimeDate,
      breakStartTime: BreakStartTimeDate,
      breakEndTime: BreakEndTimeDate,
    ),
  );
  notifyListeners();
}
void addTimings() {
  Timings.add(TimingsModel(
       SelectadTime: SelectTime,
       ServiceStarTime: ServiceStartTimeDate,
      ServiceEndTime: ServiceEndTimeDate,
      AllDay: true,
    ));
    notifyListeners();
  }
  void addSocialLinks() {
    SocialLinks.add(SocialLinksModel(
     AccountName: SocialAccountsController.text,
    ));
    SocialAccountsController.clear();
    notifyListeners();
  }
  //
  // Load & update methods
  void loadServiceData(ServiceModel service) {
    ServiceNameController.text = service.name;
    ServiceDescriptionController.text = service.description;
    Service = service.appointment;
    serviefile = service.imageFile;
  }
  void updateService(int index) {
    Services[index] = ServiceModel(
      name: ServiceNameController.text,
      description: ServiceDescriptionController.text,
      appointment: Service,
      imageFile: serviefile,
    );
    notifyListeners();
  }
  void loadTeamData(TeamMembersModel TeamMembers) {
    TeamMemberNameController.text = TeamMembers.name;
    TeamMemberDesignationController.text = TeamMembers.Designation;
    TeamMemberPhoneNumberController.text = TeamMembers.PhoneNumber;
    TeamMemberEmailIDController.text = TeamMembers.EmailID;
    Appointments = TeamMembers.appointment;
    OurTeam = TeamMembers.ourTeam;
    userFile = TeamMembers.imageFile;
  }
  void updateTeam(int index) {
    TeamMembers[index] = TeamMembersModel(
      name: TeamMemberNameController.text,
      Designation: TeamMemberDesignationController.text,
      PhoneNumber: TeamMemberPhoneNumberController.text,
      EmailID: TeamMemberEmailIDController.text,
      appointment: Appointments,
      ourTeam: OurTeam,
      imageFile: userFile,
    );
    notifyListeners();
  }
void loadAppointmentData(AppoinmentsModel appointment) {
  selectedTeamMember = appointment.teamMemberName;
  selectedTeamService = appointment.services;
  selectedDays = appointment.selectADay;
  ServiceTimeDate = appointment.serviceTime;
  ServiceStartTimeDate = appointment.serviceStartTime;
  ServiceEndTimeDate = appointment.serviceEndTime;
  BreakStartTimeDate = appointment.breakStartTime;
  BreakEndTimeDate = appointment.breakEndTime;
}

void updateAppointment(int index) {
  Appoinments[index] = AppoinmentsModel(
    teamMemberName: selectedTeamMember ?? '',
    services: selectedTeamService ?? '',
    selectADay: selectedDays ?? '',
    serviceTime: ServiceTimeDate,
    serviceStartTime: ServiceStartTimeDate,
    serviceEndTime: ServiceEndTimeDate,
    breakStartTime: BreakStartTimeDate,
    breakEndTime: BreakEndTimeDate,
  );

  notifyListeners();
}

void loadTimingsData(TimingsModel timing) {
  ServiceTimeDate = timing.SelectadTime;
  ServiceStartTimeDate = timing.ServiceStarTime;
  ServiceEndTimeDate = timing.ServiceEndTime;
 AllDay = timing.AllDay;
}

void updateTimings(int index) {
  Timings[index] = TimingsModel(
    SelectadTime: ServiceTimeDate,
    ServiceStarTime: ServiceStartTimeDate,
    ServiceEndTime: ServiceEndTimeDate,
    AllDay: AllDay,
   
  );
  notifyListeners();
}
void loadSocialLinksData(SocialLinksModel socialLink) {
  SocialAccountsController.text = socialLink.AccountName;
}
void updateSocialLinks(int index) {
  SocialLinks[index] = SocialLinksModel(
    AccountName: SocialAccountsController.text,
  );
  notifyListeners();
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

  @override
  void dispose() {
    MobileNumberController.dispose();
    CompanyNameController.dispose();
    ABNNumberController.dispose();
    CertificateNameController.dispose();
    ServiceNameController.dispose();
    ServiceDescriptionController.dispose();
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
