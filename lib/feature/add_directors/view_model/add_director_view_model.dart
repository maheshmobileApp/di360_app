import 'dart:io';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDirectoryViewModel extends ChangeNotifier with ValidationMixins {
  final AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();

  AddDirectoryViewModel() {
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
  final TextEditingController addressController = TextEditingController();
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
  TextEditingController breakStartTimeCntr = TextEditingController();
  TextEditingController breakEndTimeCntr = TextEditingController();
  TextEditingController serviceTimemInCntr = TextEditingController();

  TextEditingController partnerNameCntr = TextEditingController();
  TextEditingController descriptionCntr = TextEditingController();

  final GlobalKey<FormState> location = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(12, (_) => GlobalKey<FormState>());

  final List<int> stepsWithValidation = [0];
  List<DirectoryBusinessTypes> directoryBusinessTypes = [];
  List<String> dayWiseTimeSlots = [];

  // Navigation
  final PageController pageController = PageController();
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => ConstantData.steps.length;
  String selectedShowPromotion = "All Users";

  void setSelectedShowPromotion(String value) {
    selectedShowPromotion = value;
    notifyListeners();
  }

  updateCurrentStep() {
    _currentStep = 0;
    notifyListeners();
  }

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
  File? partnerImgFile;
  //
  // Selected dropdowns
  String? selectedDays;
  String? selectedAccount;
  DirectoryCategories? selectedBusineestype;
  List<GetDirectories> getBasicInfoData = [];

  final List<String> _selectedTeamMemberList = [];
  List<String> get selectedTeamMemberList =>
      List.unmodifiable(_selectedTeamMemberList);
  final List<String> _selectedServiceList = [];
  List<String> get selectedServiceList =>
      List.unmodifiable(_selectedServiceList);
  final List<String> _selectedDaysList = [];
  List<String> get selectedDaysList => List.unmodifiable(_selectedDaysList);

  void addTeamMemberList(String teamMember) {
    if (!_selectedTeamMemberList.contains(teamMember)) {
      _selectedTeamMemberList.add(teamMember);
    }
  }

  void removeTeamMemberList(String teamMember) {
    _selectedTeamMemberList.remove(teamMember);
  }

  void clearTeamMemberList() {
    _selectedTeamMemberList.clear();
  }

  void addServicesList(String services) {
    if (!_selectedServiceList.contains(services)) {
      _selectedServiceList.add(services);
    }
  }

  void removeServicesList(String services) {
    _selectedServiceList.remove(services);
  }

  void clearServicesList() {
    _selectedServiceList.clear();
  }

  void addDaysList(String days) {
    if (!_selectedDaysList.contains(days)) {
      _selectedDaysList.add(days);
    }
  }

  void removeDaysList(String days) {
    _selectedDaysList.remove(days);
  }

  void clearDaysList() {
    _selectedDaysList.clear();
  }

  // Toggles
  bool serviceShowApmt = false;
  bool isEditService = false;
  bool appointmentShowVal = false;
  bool ourTeamShowVal = false;

  void toggleService(bool value) {
    serviceShowApmt = value;
    notifyListeners();
  }

  void updateIsEditService(bool value) {
    isEditService = value;
    notifyListeners();
  }

  void toggleAppointments(bool value) {
    appointmentShowVal = value;
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

  Future<void> fetchTheDirectorData(BuildContext context) async {
    try {
      Loaders.circularShowLoader(context);
      final editVM = context.read<EditDeleteDirectorViewModel>();
      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      final type = await LocalStorage.getStringVal(LocalStorageConst.type);
      final res = await addDirectorRepositoryImpl.getDirectoriesData();
      
      if (res.isNotEmpty) {
        await getBusinessTypes();
        _currentStep = 0;
        getBasicInfoData = res;
        await context.read<DirectoryViewModel>().getFollowersCount(userId);
        await editVM.getAppointments(context);
        Loaders.circularHideLoader(context);
        type == 'PROFESSIONAL'
            ? getBasicInfoData.isNotEmpty
                ? navigationService.navigateTo(RouteList.professionDirectorScreen)
                : navigationService
                    .navigateTo(RouteList.professionAddDirectorView)
            : getBasicInfoData.isNotEmpty
                ? navigationService.navigateTo(RouteList.myDirectorScreen)
                : navigationService.navigateTo(RouteList.adddirectorview);
        assignBasicInfoData(context);
      } else {
        clearBasicInfoData();
        Loaders.circularHideLoader(context);
        type == 'PROFESSIONAL'
            ? navigationService.navigateTo(RouteList.professionAddDirectorView)
            : navigationService.navigateTo(RouteList.adddirectorview);
      }
    } catch (e) {
      print('Error in fetchTheDirectorData: $e');
      Loaders.circularHideLoader(context);
      clearBasicInfoData();
      final type = await LocalStorage.getStringVal(LocalStorageConst.type);
      type == 'PROFESSIONAL'
          ? navigationService.navigateTo(RouteList.professionAddDirectorView)
          : navigationService.navigateTo(RouteList.adddirectorview);
    }
    notifyListeners();
  }

  Future<void> getDirectories() async {
    try {
      final res = await addDirectorRepositoryImpl.getDirectoriesData();
      if (res.isNotEmpty) {
        getBasicInfoData = res;
        assignBasicInfoData(navigatorKey.currentContext!);
      }
    } catch (e) {
      print('Error in getDirectories: $e');
    }
    notifyListeners();
  }

  void assignBasicInfoData(BuildContext context) {
    final professVM = context.read<ProfessionalAddDirectorVm>();
    professVM.assignTheProfessBasic(context);
    final basic = getBasicInfoData.first;
    CompanyNameController.text = basic.companyName ?? '';
    nameController.text = basic.name ?? '';
    emailController.text = basic.email ?? '';
    ABNNumberController.text = basic.abnAcn ?? '';
    MobileNumberController.text = basic.phone ?? '';
    alternateNumberController.text = basic.altPhone ?? '';
    addressController.text = basic.address ?? '';
    final allCategories = directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.id == basic.directoryCategoryId,
      orElse: () => null,
    );
    if (businessType != null) {
      setSelectedBusineestype(businessType);
    }
    final document = parse(basic.description ?? '');
    final String parsedString = document.body?.text ?? "";
    descController.text = parsedString;
    notifyListeners();
  }

  void clearBasicInfoData() {
    CompanyNameController.clear();
    nameController.clear();
    emailController.clear();
    ABNNumberController.clear();
    MobileNumberController.clear();
    alternateNumberController.clear();
    addressController.clear();
    selectedBusineestype = null;
    descController.clear();
    notifyListeners();
  }

  void setSelectedBusineestype(DirectoryCategories emp) {
    selectedBusineestype = emp;
    notifyListeners();
  }

  DateTime? _parseTimeString(BuildContext context, String timeStr) {
    if (timeStr.trim().isEmpty) return null;
    try {
      final locale = Localizations.localeOf(context).toString();
      final parsed = DateFormat.jm(locale).parse(timeStr);
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
    } catch (_) {
      try {
        final parsed = DateFormat('HH:mm').parse(timeStr);
        final now = DateTime.now();
        return DateTime(
            now.year, now.month, now.day, parsed.hour, parsed.minute);
      } catch (_) {
        return null;
      }
    }
  }

  void generateTimeSlots(BuildContext context, {int interval = 30}) {
    final start = _parseTimeString(context, serviceStartTimeCntr.text);
    final end = _parseTimeString(context, serviceEndTimeCntr.text);
    final breakStart = _parseTimeString(context, breakStartTimeCntr.text);
    final breakEnd = _parseTimeString(context, breakEndTimeCntr.text);

    if (start == null || end == null) {
      dayWiseTimeSlots = [];
      serviceTimemInCntr.text = '';
      notifyListeners();
      return;
    }

    DateTime actualEnd = end;
    if (!actualEnd.isAfter(start)) {
      actualEnd = actualEnd.add(const Duration(days: 1));
    }

    int totalMinutes = actualEnd.difference(start).inMinutes;

    if (breakStart != null && breakEnd != null) {
      DateTime actualBreakEnd = breakEnd;
      if (!actualBreakEnd.isAfter(breakStart)) {
        actualBreakEnd = actualBreakEnd.add(const Duration(days: 1));
      }

      if (breakStart.isAfter(start) && actualBreakEnd.isBefore(actualEnd)) {
        totalMinutes -= actualBreakEnd.difference(breakStart).inMinutes;
      }
    }

    final formatter = DateFormat('HH:mm');
    final slots = <String>[];

    DateTime current = start;
    while (current.isBefore(actualEnd)) {
      final next = current.add(Duration(minutes: interval));
      if (next.isAfter(actualEnd)) break;
      slots.add("${formatter.format(current)}-${formatter.format(next)}");
      current = next;
    }

    dayWiseTimeSlots = slots;
    serviceTimemInCntr.text = totalMinutes.toString();
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
        "address": addressController.text,
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
      getDirectories();
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
        "address": addressController.text,
        "latitude": getBasicInfoData.first.latitude,
        "longitude": getBasicInfoData.first.longitude,
        "pincode": '',
        "phone": MobileNumberController.text,
        "email": emailController.text
      }
    });
    if (res != null) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated Basic Information successfully');
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
      getDirectories();
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
      getDirectories();
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
      getDirectories();
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
      getDirectories();
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
        "show_in_our_team": ourTeamShowVal == true ? "yes" : 'No',
        "show_in_appointments": appointmentShowVal == true ? "yes" : 'No'
      }
    });
    if (result['insert_directory_team_members_one'] != null) {
      getDirectories();
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
      getDirectories();
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
      getDirectories();
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
    dynamic prfImg;
    if (testimonialsFile != null) {
      prfImg = await addDirectorRepositoryImpl.http
          .uploadImage(testimonialsFile!.path);
    }
    dynamic msgPic;
    if (testimonialsPicFile != null) {
      msgPic = await addDirectorRepositoryImpl.http
          .uploadImage(testimonialsPicFile!.path);
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
      getDirectories();
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

  Future<void> pickPartnerImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      partnerImgFile = File(pickedFile.path);
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
}
