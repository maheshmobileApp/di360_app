import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
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
  TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController ABNNumberController = TextEditingController();
  final TextEditingController AdreessController = TextEditingController();
  TextEditingController certificateNameController = TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController serviceDescController = TextEditingController();
  TextEditingController achievementNameController = TextEditingController();
  final TextEditingController documentNameController = TextEditingController();
  final TextEditingController teamNameCntr = TextEditingController();
  final TextEditingController teamDesignationCntr = TextEditingController();
  final TextEditingController teamNumberCntr = TextEditingController();
  final TextEditingController teamEmailIDCntr = TextEditingController();
  final TextEditingController teamLocationCntr = TextEditingController();
  TextEditingController questionCntr = TextEditingController();
  TextEditingController answerCntr = TextEditingController();
  TextEditingController messageCntr = TextEditingController();
  TextEditingController testiNameCntr = TextEditingController();
  TextEditingController socialAccountsurlCntr = TextEditingController();
  final TextEditingController SelectTimeController = TextEditingController();
  TextEditingController roleCntr = TextEditingController();
  TextEditingController selectWeekCntr = TextEditingController();
  TextEditingController serviceStartTimeCntr = TextEditingController();
  TextEditingController serviceEndTimeCntr = TextEditingController();
  TextEditingController SelecteBreakStartTimeController =
      TextEditingController();
  TextEditingController SelectBreakEndTimeController = TextEditingController();
  TextEditingController SelectServiceTimeminController =
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
  final List<String> AccountList = [
    'Facebook',
    'Twitter',
    'Instagram',
    'LinkedIn',
    'Web url'
  ];
  final GlobalKey<FormState> location = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(11, (_) => GlobalKey<FormState>());
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
    'OtherInformation',
  ];

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
  final List<FAQsModel> faqsList = [];
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
  File? testimonialsFile;
  File? testimonialsPicFile;
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
      navigationService.navigateTo(RouteList.adddirectorview);
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

  Future<void> addBasicInfo(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    var logo = await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);
    var banner =
        await addDirectorRepositoryImpl.http.uploadImage(bannerFile?.path);
    final res = await addDirectorRepositoryImpl.addBasicInfo({
      "dirObj": {
        "company_name": CompanyNameController.text,
        "description": descController.text,
        "directory_category_id": selectedBusineestype?.id,
        "dental_practice_id": type == 'PRACTICE' ? userId : null,
        "dental_professional_id": type == 'PROFESSIONAL' ? userId : null,
        "dental_supplier_id": type == 'SUPPLIER' ? userId : null,
        "type": type,
        "banner_image": banner,
        "logo": logo,
        "email": emailController.text,
        "phone": MobileNumberController.text,
        "address": AdreessController.text,
        "alt_phone": alternateNumberController.text,
        "emergency_phone": null,
        "latitude": '',
        "longitude": '',
        "pincode": '',
        "name": nameController.text,
        "profession_type": selectedBusineestype?.name
      }
    });
    if (res != null) {
      getDirectories(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('BasicInfo added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateBasicInfo(BuildContext context) async {
    Loaders.circularShowLoader(context);

    var logo = logoFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);
    var banner = bannerFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(bannerFile?.path);
    final res = await addDirectorRepositoryImpl.updateBasicInfo({
      "id": getBasicInfoData.first.id,
      "updateInfo": {
        "company_name": CompanyNameController.text,
        "description": descController.text,
        "banner_image":
            banner == null ? getBasicInfoData.first.bannerImage : banner,
        "profession_type": selectedBusineestype?.name,
        "directory_category_id": selectedBusineestype?.id,
        "logo": logo == null ? getBasicInfoData.first.logo : logo,
        "alt_phone": alternateNumberController.text,
        "name": nameController.text,
        "abn_acn": ABNNumberController.text,
        "address": AdreessController.text,
        "latitude": getBasicInfoData.first.latitude,
        "longitude": getBasicInfoData.first.longitude,
        "pincode": '',
        "phone": MobileNumberController.text,
        "email": emailController.text
      }
    });
    if (res != null) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Update BasicInfo added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> addService(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final result = await addDirectorRepositoryImpl.addServices({
      "servicesObj": {
        "name": serviceNameController.text,
        "description": serviceDescController.text,
        "show_in_appointments": serviceShowApmt == true ? 'Yes' : 'No',
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

  void addGallery(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var attachments =
        await addDirectorRepositoryImpl.http.uploadImage(galleryFile?.path);
    final result = await addDirectorRepositoryImpl.addGallery({
      "galleryObj": {
        "image": [attachments],
        "directory_id": getBasicInfoData.first.id
      }
    });
    if (result != null) {
      Gallerys.add(GalleryModel(imageFile: galleryFile));
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Gallery added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    galleryFile = null;
    notifyListeners();
  }

  void addLocations(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final result = await addDirectorRepositoryImpl.addLocation({
      "locationObj": {
        "directory_id": getBasicInfoData.first.id,
        "week_name": selectWeekCntr.text,
        "clinic_time":
            "${serviceStartTimeCntr.text} - ${serviceEndTimeCntr.text}",
        "status": "TIME"
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Business time added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    selectWeekCntr.clear();
    selectedDays = null;
    serviceStartTimeCntr.clear();
    serviceEndTimeCntr.clear();
    notifyListeners();
  }

  void addSocialUrls(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final result = await addDirectorRepositoryImpl.addLocation({
      "locationObj": {
        "media_name": selectedAccount,
        "media_link": socialAccountsurlCntr.text,
        "directory_id": getBasicInfoData.first.id,
        "status": "SOCIAL"
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Social urls added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    selectedAccount = null;
    socialAccountsurlCntr.clear();
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

  Future<void> addFAQs(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.addFaqs({
      "faqsObj": {
        "question": questionCntr.text,
        "answer": answerCntr.text,
        "directory_id": getBasicInfoData.first.id
      }
    });
    if (res != null) {
      faqsList
          .add(FAQsModel(question: questionCntr.text, answer: answerCntr.text));
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Faqs added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    questionCntr.clear();
    answerCntr.clear();
    notifyListeners();
  }

  Future<void> addTestimonials(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var prfImg = await addDirectorRepositoryImpl.http
        .uploadImage(testimonialsFile?.path);
    dynamic msgPic;
    if (testimonialsPicFile != null) {
      msgPic = await addDirectorRepositoryImpl.http
          .uploadImage(testimonialsPicFile?.path);
    }
    final res = await addDirectorRepositoryImpl.addTestimonials({
      "testiObj": {
        "name": testiNameCntr.text,
        "role": roleCntr.text,
        "message": messageCntr.text,
        "profile_image": prfImg,
        "msg_pic": msgPic,
        "directory_id": getBasicInfoData.first.id
      }
    });
    if (res != null) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Testimonial added successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    testiNameCntr.clear();
    roleCntr.clear();
    messageCntr.clear();
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
      AccountName: socialAccountsurlCntr.text,
    ));
    socialAccountsurlCntr.clear();
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
    socialAccountsurlCntr.text = socialLink.AccountName;
  }

  void updateSocialLinks(int index) {
    SocialLinks[index] = SocialLinksModel(
      AccountName: socialAccountsurlCntr.text,
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

  Future<void> pickTestimonialImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      testimonialsFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickTestimonialPicture(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      testimonialsPicFile = File(pickedFile.path);
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
    socialAccountsurlCntr.dispose();
    SelectTimeController.dispose();
    serviceStartTimeCntr.dispose();
    serviceEndTimeCntr.dispose();
    SelecteBreakStartTimeController.dispose();
    SelectBreakEndTimeController.dispose();
    SelectServiceTimeminController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
