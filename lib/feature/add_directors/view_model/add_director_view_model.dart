import 'dart:io';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/achievement_model.dart';
import 'package:di360_flutter/feature/add_directors/model/appoinments_model.dart';
import 'package:di360_flutter/feature/add_directors/model/certificate_model.dart';
import 'package:di360_flutter/feature/add_directors/model/document_model.dart';
import 'package:di360_flutter/feature/add_directors/model/gallery_model.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/model/service_model.dart';
import 'package:di360_flutter/feature/add_directors/model/social_links_model.dart';
import 'package:di360_flutter/feature/add_directors/model/team_members_model.dart';
import 'package:di360_flutter/feature/add_directors/model/timings_model.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';

class AddDirectorViewModel extends ChangeNotifier with ValidationMixins {
  final AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();

  AddDirectorViewModel() {
    getBusinessTypes();
  }
//controller....
  final TextEditingController MobileNumberController = TextEditingController();
  final TextEditingController CompanyNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController alternateNumberController =
      TextEditingController();
  final TextEditingController ABNNumberController = TextEditingController();
  final TextEditingController AdreessController = TextEditingController();
  final TextEditingController certificateNameController =
      TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController serviceDescController = TextEditingController();
  final TextEditingController achievementNameController =
      TextEditingController();
  final TextEditingController documentNameController = TextEditingController();
  final TextEditingController teamNameCntr = TextEditingController();
  final TextEditingController teamDesignationCntr = TextEditingController();
  final TextEditingController teamNumberCntr = TextEditingController();
  final TextEditingController teamEmailIDCntr = TextEditingController();
  final TextEditingController teamLocationCntr = TextEditingController();
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
  final List<ServiceModel> servicesList = [];
  final List<CertificateModel> certificateList = [];
  final List<DocumentModel> documentsList = [];
  final List<AchievementModel> achievementsList = [];
  final List<TeamMembersModel> TeamMembers = [];
  final List<GalleryModel> Gallerys = [];
  final List<AppoinmentsModel> Appoinments = [];
  final List<TimingsModel> Timings = [];
  final List<SocialLinksModel> SocialLinks = [];
  List<DirectoryBusinessTypes> directoryBusinessTypes = [];

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
  File? teamMemberFile;
  File? galleryFile;
  //
  // Selected dropdowns
  String? selectedTeamMember;
  String? selectedTeamService;
  String? selectedDays;
  String? selectedAccount;
  DirectoryCategories? selectedBusineestype;
  List<GetDirectories> getBasicInfoData = [];
  ServiceModel? selectedService;
  CertificateModel? selectedCertificate;
  AchievementModel? selectedAchievement;
  DocumentModel? selectedDocument;
  GalleryModel? selectedGallery;
  TeamMembersModel? selectedteamember;
  AppoinmentsModel? selectedAppoinment;
  TimingsModel? selectedTimigs;
  SocialLinksModel? selectedSocialLinks;

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
  bool serviceShowApmt = false;
  bool appointmentShowVal = false;
  bool AllDay = false;
  bool ourTeamShowVal = false;

  void toggleService(bool value) {
    serviceShowApmt = value;
    notifyListeners();
  }

  void toggleAppointments(bool value) {
    appointmentShowVal = value;
    notifyListeners();
  }

  void toggleAllDay(bool value) {
    AllDay = value;
    notifyListeners();
  }

  void toggleOurTeam(bool value) {
    ourTeamShowVal = value;
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

  Future<void> getBusinessTypes() async {
    final result = await addDirectorRepositoryImpl.getBusinessTypes();
    if (result?.directoryBusinessTypes != null) {
      directoryBusinessTypes = result?.directoryBusinessTypes ?? [];
    }
    notifyListeners();
  }

  Future<void> getDirectories(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.getDirectoriesData();
    if (res.isNotEmpty) {
      getBasicInfoData = res;
      assignBasicInfoData();
      Loaders.circularHideLoader(context);
      navigationService.navigateTo(RouteList.adddirectorview);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  void assignBasicInfoData() {
    final basic = getBasicInfoData.first;
    CompanyNameController.text = basic.companyName ?? '';
    nameController.text = basic.name ?? '';
    emailController.text = basic.email ?? '';
    ABNNumberController.text = basic.abnAcn ?? '';
    MobileNumberController.text = basic.phone ?? '';
    alternateNumberController.text = basic.altPhone ?? '';
    AdreessController.text = basic.address ?? '';
    final document = parse(basic.description ?? '');
    final String parsedString = document.body?.text ?? "";
    descController.text = parsedString;
    notifyListeners();
  }

  void setSelectedBusineestype(DirectoryCategories emp) {
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

  Future<void> addService(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final result = await addDirectorRepositoryImpl.addServices({
      "servicesObj": {
        "name": serviceNameController.text,
        "description": serviceDescController.text,
        "show_in_appointments": serviceShowApmt,
        "directory_id": getBasicInfoData.first.id
      }
    });
    if (result['insert_directory_services_one'] != null) {
      servicesList.add(ServiceModel(
          name: serviceNameController.text,
          appointment: serviceShowApmt,
          description: serviceDescController.text,
          imageFile: serviefile));
      scaffoldMessenger('Service added successfully');
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    serviceNameController.clear();
    serviceShowApmt = serviceShowApmt;
    serviefile = null;
    serviceDescController.clear();
    notifyListeners();
  }

  void addCertificates(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var attachments =
        await addDirectorRepositoryImpl.http.uploadImage(certificateFile?.path);
    final result = await addDirectorRepositoryImpl.addCertificates({
      "certiObj": {
        "directory_id": getBasicInfoData.first.id,
        "attachments": attachments,
        "title": certificateNameController.text
      }
    });
    if (result['insert_directory_certifications_one'] != null) {
      certificateList.add(CertificateModel(
        name: certificateNameController.text,
        imageFile: certificateFile,
      ));
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Certificates added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    certificateNameController.clear();
    certificateFile = null;
    notifyListeners();
  }

  Future<void> addDocument(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var attachments =
        await addDirectorRepositoryImpl.http.uploadImage(documentFile?.path);
    final result = await addDirectorRepositoryImpl.addDocu({
      "docsObj": {
        "directory_id": getBasicInfoData.first.id,
        "attachment": attachments,
        "name": documentNameController.text
      }
    });
    if (result['insert_directory_documents_one'] != null) {
      documentsList.add(DocumentModel(
          name: documentNameController.text, imageFile: documentFile));
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Document added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    documentNameController.clear();
    documentFile = null;
    notifyListeners();
  }

  void addAchievement(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var attachments =
        await addDirectorRepositoryImpl.http.uploadImage(achievementFile?.path);
    final result = await addDirectorRepositoryImpl.addAchieve({
      "achObj": {
        "directory_id": getBasicInfoData.first.id,
        "attachments": attachments,
        "title": achievementNameController.text
      }
    });
    if (result['insert_directory_achievements_one'] != null) {
      achievementsList.add(AchievementModel(
        name: achievementNameController.text,
        imageFile: achievementFile,
      ));
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Achievements added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    achievementNameController.clear();
    achievementFile = null;
    notifyListeners();
  }

  Future<void> addTeamMember(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var attachments =
        await addDirectorRepositoryImpl.http.uploadImage(teamMemberFile?.path);
    final result = await addDirectorRepositoryImpl.addTeamMembers({
      "ourTeamObj": {
        "directory_id": getBasicInfoData.first.id,
        "name": teamNameCntr.text,
        "specialization": teamDesignationCntr.text,
        "image": attachments,
        "email": teamEmailIDCntr.text,
        "phone": teamNumberCntr.text,
        "location": teamLocationCntr.text,
        "show_in_our_team": appointmentShowVal == true ? "yes" : 'No',
        "show_in_appointments": ourTeamShowVal == true ? "yes" : 'No'
      }
    });
    if (result['insert_directory_team_members_one'] != null) {
      TeamMembers.add(TeamMembersModel(
        name: teamNameCntr.text,
        Designation: teamDesignationCntr.text,
        PhoneNumber: teamNumberCntr.text,
        EmailID: teamEmailIDCntr.text,
        appointment: appointmentShowVal,
        ourTeam: ourTeamShowVal,
        imageFile: teamMemberFile,
      ));
      Loaders.circularHideLoader(context);
      scaffoldMessenger('TeamMember added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    teamNameCntr.clear();
    teamDesignationCntr.clear();
    teamNumberCntr.clear();
    teamEmailIDCntr.clear();
    appointmentShowVal = appointmentShowVal;
    ourTeamShowVal = appointmentShowVal;
    teamMemberFile = null;
    teamLocationCntr.clear();
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
    serviceNameController.text = service.name;
    serviceDescController.text = service.description;
    serviceShowApmt = service.appointment;
    serviefile = service.imageFile;
  }

  void updateService(int index) {
    servicesList[index] = ServiceModel(
      name: serviceNameController.text,
      description: serviceDescController.text,
      appointment: serviceShowApmt,
      imageFile: serviefile,
    );
    notifyListeners();
  }

  //certificated..
  void loadCertificatesData(CertificateModel certificates) {
    certificateNameController.text = certificates.name;
    certificateFile = certificates.imageFile;
  }

  void updateCertificates(int index) {
    certificateList[index] = CertificateModel(
      name: certificateNameController.text,
      imageFile: certificateFile,
    );
    notifyListeners();
  }

  //achievement
  void loadAchievementData(AchievementModel achievement) {
    achievementNameController.text = achievement.name;
    achievementFile = achievement.imageFile;
  }

  void updateAchievement(int index) {
    achievementsList[index] = AchievementModel(
      name: achievementNameController.text,
      imageFile: achievementFile,
    );
    notifyListeners();
  }

  //documetn
  void loadDocumentData(DocumentModel document) {
    documentNameController.text = document.name;
    documentFile = document.imageFile;
  }

  void updateDocument(int index) {
    documentsList[index] = DocumentModel(
        name: documentNameController.text, imageFile: documentFile);
    notifyListeners();
  }

  //gallerys
  void loadGalleryData(GalleryModel gallerys) {
    galleryFile = gallerys.imageFile;
  }

  void updateGallery(int index) {
    Gallerys[index] = GalleryModel(imageFile: galleryFile);
    notifyListeners();
  }

  void loadTeamData(TeamMembersModel TeamMembers) {
    teamNameCntr.text = TeamMembers.name;
    teamDesignationCntr.text = TeamMembers.Designation;
    teamNumberCntr.text = TeamMembers.PhoneNumber;
    teamEmailIDCntr.text = TeamMembers.EmailID;
    appointmentShowVal = TeamMembers.appointment;
    ourTeamShowVal = TeamMembers.ourTeam;
    teamMemberFile = TeamMembers.imageFile;
  }

  void updateTeam(int index) {
    TeamMembers[index] = TeamMembersModel(
      name: teamNameCntr.text,
      Designation: teamDesignationCntr.text,
      PhoneNumber: teamNumberCntr.text,
      EmailID: teamEmailIDCntr.text,
      appointment: appointmentShowVal,
      ourTeam: ourTeamShowVal,
      imageFile: teamMemberFile,
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

  Future<void> pickDocumentsImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      documentFile = File(result.files.first.path ?? '');
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickUserImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      teamMemberFile = File(pickedFile.path);
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
    certificateNameController.dispose();
    serviceNameController.dispose();
    serviceDescController.dispose();
    achievementNameController.dispose();
    documentNameController.dispose();
    teamNameCntr.dispose();
    teamDesignationCntr.dispose();
    teamNumberCntr.dispose();
    teamEmailIDCntr.dispose();
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
