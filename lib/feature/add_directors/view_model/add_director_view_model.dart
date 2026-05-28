import 'dart:io';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/email_phone_visiable_enums.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDirectoryViewModel extends ChangeNotifier with ValidationMixins {
  final AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();
  HttpService _http = HttpService();

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
  TextEditingController businessEmailCntr = TextEditingController();
  TextEditingController businessPhoneCntr = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();

  double? latitude;
  double? longitude;

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
  List<File>? galleryFiles;
  File? partnerImgFile;

  List<String>? serverGalleryFiles;
  void setServerGalleryFiles(List<String>? value) {
    serverGalleryFiles = value;
    notifyListeners();
  }

  void setGalleryFiles(List<File>? value) {
    galleryFiles = value;
    notifyListeners();
  }

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
      notifyListeners();
    }
  }

  void removeTeamMemberList(String teamMember) {
    _selectedTeamMemberList.remove(teamMember);
    notifyListeners();
  }

  void clearTeamMemberList() {
    _selectedTeamMemberList.clear();
    notifyListeners();
  }

  void addServicesList(String services) {
    if (!_selectedServiceList.contains(services)) {
      _selectedServiceList.add(services);
      notifyListeners();
    }
  }

  void removeServicesList(String services) {
    _selectedServiceList.remove(services);
    notifyListeners();
  }

  void clearServicesList() {
    _selectedServiceList.clear();
    notifyListeners();
  }

  void addDaysList(String days) {
    if (!_selectedDaysList.contains(days)) {
      _selectedDaysList.add(days);
      notifyListeners();
    }
  }

  void removeDaysList(String days) {
    _selectedDaysList.remove(days);
    notifyListeners();
  }

  void clearDaysList() {
    _selectedDaysList.clear();
    notifyListeners();
  }

  String? _emailVisibility;

  String? get emailVisibility => _emailVisibility;

  void setEmailVisibility(String? value) {
    _emailVisibility = value;
    notifyListeners();
  }

  String? _phoneVisibility;

  String? get phoneVisibility => _phoneVisibility;

  void setPhoneVisibility(String? value) {
    _phoneVisibility = value;
    notifyListeners();
  }

  String? selectedPhoneCode = "AU (+61)";
  void setPhoneCode(String value) {
    selectedPhoneCode = value;
    notifyListeners();
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
      assignBasicInfoData(navigatorKey.currentContext!);
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
        await editVM.getAppointments(this);
        Loaders.circularHideLoader(context);
        type == UserRole.professional.value
            ? getBasicInfoData.isNotEmpty
                ? navigationService
                    .navigateTo(RouteList.professionDirectorScreen)
                : navigationService
                    .navigateTo(RouteList.professionAddDirectorView)
            : getBasicInfoData.isNotEmpty
                ? navigationService.navigateTo(RouteList.myDirectorScreen)
                : navigationService.navigateTo(RouteList.adddirectorview);
        assignBasicInfoData(context);
      } else {
        _currentStep = 0;
        clearBasicInfoData();
        assignBasicInfoData(context);
        Loaders.circularHideLoader(context);
        type == UserRole.professional.value
            ? navigationService.navigateTo(RouteList.professionAddDirectorView)
            : navigationService.navigateTo(RouteList.adddirectorview);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      clearBasicInfoData();
      final type = await LocalStorage.getStringVal(LocalStorageConst.type);
      type == UserRole.professional.value
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

  void assignBasicInfoData(BuildContext context) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final professVM = context.read<ProfessionalAddDirectorVm>();
    if (type == UserRole.professional.value)
      professVM.assignTheProfessBasic(context);
    if (getBasicInfoData.isEmpty) {
      type == UserRole.supplier.value
          ? assignSupplierViewProfileData(context)
          : assignPracticeViewProfileData(context);
      return;
    }
    final basic = getBasicInfoData.first;
    CompanyNameController.text = basic.companyName ?? '';
    nameController.text = basic.name ?? '';
    emailController.text = basic.email ?? '';
    ABNNumberController.text = basic.abnAcn ?? '';
    businessEmailCntr.text = basic.businessEmail ?? '';
    businessPhoneCntr.text = basic.mobileNumber ?? '';
    final phone = basic.phone ?? "";
    if (phone.startsWith('+61')) {
      selectedPhoneCode = 'AU (+61)';
      MobileNumberController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      selectedPhoneCode = 'NZ (+64)';
      MobileNumberController.text = phone.substring(3);
    } else {
      selectedPhoneCode = 'AU (+61)';
      MobileNumberController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    alternateNumberController.text = basic.altPhone ?? '';
    addressController.text = basic.address ?? '';
    final allCategories = directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.name == basic.professionType,
      orElse: () => null,
    );
    if (businessType != null) {
      setSelectedBusineestype(businessType);
    }
    final document = parse(basic.description ?? '');
    final String parsedString = document.body?.text ?? "";
    descController.text = parsedString;
    setEmailVisibility(
        VisibilityType.fromEnumName(basic.emailVisibility)?.displayName);
    setPhoneVisibility(
        VisibilityType.fromEnumName(basic.phoneVisibility)?.displayName);
    notifyListeners();
  }

  assignSupplierViewProfileData(BuildContext context) async {
    final viewProfileVM = context.read<ViewProfileViewModel>();
    await viewProfileVM.getTheViewProfileData();
    final data = viewProfileVM.supplierViewProfileData;

    final phone = data?.phone ?? "";
    if (phone.startsWith('+61')) {
      selectedPhoneCode = 'AU (+61)';
      MobileNumberController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      selectedPhoneCode = 'NZ (+64)';
      MobileNumberController.text = phone.substring(3);
    } else {
      selectedPhoneCode = 'AU (+61)';
      MobileNumberController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    final allCategories = directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.name == data?.professiontype?.name,
      orElse: () => null,
    );
    if (businessType != null) {
      setSelectedBusineestype(businessType);
    }
    CompanyNameController.text = data?.businessName ?? '';
    nameController.text = data?.name ?? '';
    emailController.text = data?.email ?? '';
    ABNNumberController.text = data?.abnNumber ?? '';
    alternateNumberController.text = data?.altPhone ?? '';
    addressController.text = data?.address ?? '';
    notifyListeners();
  }

  assignPracticeViewProfileData(BuildContext context) async {
    final viewProfileVM = context.read<ViewProfileViewModel>();
    await viewProfileVM.getTheViewProfileData();
    final data = viewProfileVM.practiceViewProfileData;

    final phone = data?.phone ?? "";
    if (phone.startsWith('+61')) {
      selectedPhoneCode = 'AU (+61)';
      MobileNumberController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      selectedPhoneCode = 'NZ (+64)';
      MobileNumberController.text = phone.substring(3);
    } else {
      selectedPhoneCode = 'AU (+61)';
      MobileNumberController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
    final allCategories = directoryBusinessTypes
        .expand((bt) => bt.directoryCategories ?? [])
        .toList();
    final businessType = allCategories.firstWhere(
      (cat) => cat.name == data?.professiontype?.name,
      orElse: () => null,
    );
    if (businessType != null) {
      setSelectedBusineestype(businessType);
    }
    CompanyNameController.text = data?.businessName ?? '';
    nameController.text = data?.name ?? '';
    emailController.text = data?.email ?? '';
    ABNNumberController.text = data?.abnNumber ?? '';
    alternateNumberController.text = data?.altPhone ?? '';
    addressController.text = data?.address ?? '';
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
    businessEmailCntr.clear();
    businessPhoneCntr.clear();
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
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    var logo = logoFile?.path != null && logoFile!.path.isNotEmpty
        ? await addDirectorRepositoryImpl.http.uploadImage(logoFile!.path)
        : null;
    var banner = bannerFile?.path != null && bannerFile!.path.isNotEmpty
        ? await addDirectorRepositoryImpl.http.uploadImage(bannerFile!.path)
        : null;
    final res = await addDirectorRepositoryImpl.addBasicInfo({
      "dirObj": {
        "company_name": CompanyNameController.text,
        "description": descController.text,
        "directory_category_id": selectedBusineestype?.id,
        "dental_practice_id": type == UserRole.practice.value ? userId : null,
        "dental_professional_id":
            type == UserRole.professional.value ? userId : null,
        "dental_supplier_id": type == UserRole.supplier.value ? userId : null,
        "type": type,
        "banner_image": banner,
        "logo": logo,
        "email": emailController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "address": addressController.text,
        // "alt_phone": alternateNumberController.text,
        "emergency_phone": null,
        "latitude": latitude,
        "longitude": longitude,
        "name": nameController.text,
        "business_email":
            businessEmailCntr.text.isEmpty ? null : businessEmailCntr.text,
        "mobile_number": businessPhoneCntr.text,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "phone_visibility":
            VisibilityType.fromDisplayName(phoneVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "email_visibility":
            VisibilityType.fromDisplayName(emailVisibility)?.name ??
                VisibilityType.PRIVATE.name
      }
    });
    if (res != null) {
      await getDirectories();
      Loaders.circularHideLoader(context);
      await LocalStorage.setBoolValue(
          LocalStorageConst.directoryComplete, true);
      await LocalStorage.setBoolValue(
          LocalStorageConst.firstNavigationDirectory, true);
      scaffoldMessenger('BasicInfo added successfully');
      await updateViewProfileData();
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateBasicInfo(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final communityId =
        await await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    var logo = logoFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);
    var banner = bannerFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(bannerFile?.path);
    Map<String, dynamic> requestData = {
      "id": getBasicInfoData.first.id,
    };
    if (type == UserRole.supplier.value) {
      requestData["changes"] = {
        "company_name": CompanyNameController.text,
        "business_name": CompanyNameController.text,
        "description": descController.text,
        "banner_image":
            banner == null ? getBasicInfoData.first.bannerImage : banner,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "directory_category_id": selectedBusineestype?.id,
        "logo": logo == null ? getBasicInfoData.first.logo : logo,
        "alt_phone": alternateNumberController.text,
        "name": nameController.text,
        "abn_acn": ABNNumberController.text,
        "address": addressController.text,
        "type": type,
        "dental_supplier_id": userId,
        "latitude": getBasicInfoData.first.latitude,
        "longitude": getBasicInfoData.first.longitude,
        "phone": '$phoneCode${MobileNumberController.text}',
        "email": emailController.text,
        "business_email":
            businessEmailCntr.text.isEmpty ? null : businessEmailCntr.text,
        "mobile_number": businessPhoneCntr.text,
        "phone_visibility":
            VisibilityType.fromDisplayName(phoneVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "email_visibility":
            VisibilityType.fromDisplayName(emailVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "community_status": "NO",
        "community_id": communityId
      };
    } else if (type == UserRole.practice.value) {
      requestData["changes"] = {
        "name": nameController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "email": emailController.text,
        "address": addressController.text,
        "type": type,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "description": descController.text,
        "banner_image":
            banner == null ? getBasicInfoData.first.bannerImage : banner,
        "phone_visibility":
            VisibilityType.fromDisplayName(phoneVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "email_visibility":
            VisibilityType.fromDisplayName(emailVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "mobile_number": businessPhoneCntr.text,
        "company_name": CompanyNameController.text,
        "business_name": CompanyNameController.text,
        "business_email":
            businessEmailCntr.text.isEmpty ? null : businessEmailCntr.text,
        "logo": logo == null ? getBasicInfoData.first.logo : logo,
        "abn_acn": ABNNumberController.text,
        "dental_practice_id": userId
      };
    } else {
      requestData["changes"] = {
        "name": nameController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "email": emailController.text,
        "address": addressController.text,
        "type": type,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "description": descController.text,
        "banner_image":
            banner == null ? getBasicInfoData.first.bannerImage : banner,
        "phone_visibility":
            VisibilityType.fromDisplayName(phoneVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "email_visibility":
            VisibilityType.fromDisplayName(emailVisibility)?.name ??
                VisibilityType.PRIVATE.name,
        "alt_phone": null,
        "profile_image": {
          "url": "assets/images/social/male_avatar.png",
          "type": "STATIC"
        },
        "university_school": null,
        "designation": null,
        "hobbies": null,
        "special_interests": []
      };
    }

    final res = await addDirectorRepositoryImpl.updateBasicInfo(requestData);
    if (res != null) {
      await LocalStorage.setBoolValue(
          LocalStorageConst.directoryComplete, true);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated Basic Information successfully');
      await updateRecord();
      await updateClient();
      await LocalStorage.setStringVal(
          LocalStorageConst.professionId, selectedBusineestype?.id ?? "");
      await updateViewProfileData();
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateViewProfileData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    await addDirectorRepositoryImpl.updateViewProfileData({
      "id": userId,
      "changes": {
        "name": nameController.text,
        "address": addressController.text,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "business_email":
            businessEmailCntr.text.isEmpty ? null : businessEmailCntr.text,
        "business_name": CompanyNameController.text,
        "mobile_number": businessPhoneCntr.text,
        "logo": getBasicInfoData.isNotEmpty
            ? getBasicInfoData.first.logo?.toJson()
            : null,
        "abn_number": ABNNumberController.text,
      }
    });
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
        certificateFile?.path != null && certificateFile!.path.isNotEmpty
            ? await addDirectorRepositoryImpl.http
                .uploadImage(certificateFile!.path)
            : null;
    if (attachments == null) {
      scaffoldMessenger('Attachement not upload again select');
      Loaders.circularHideLoader(context);
      return;
    }
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
    var attachments = documentFile?.path != null &&
            documentFile!.path.isNotEmpty
        ? await addDirectorRepositoryImpl.http.uploadImage(documentFile!.path)
        : null;
    if (attachments == null) {
      scaffoldMessenger('Attachement not upload again select');
      Loaders.circularHideLoader(context);
      return;
    }
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
        achievementFile?.path != null && achievementFile!.path.isNotEmpty
            ? await addDirectorRepositoryImpl.http
                .uploadImage(achievementFile!.path)
            : null;
    if (attachments == null) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Attachement not upload again select');
      return;
    }
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
    var attachments = teamMemberFile?.path != null &&
            teamMemberFile!.path.isNotEmpty
        ? await addDirectorRepositoryImpl.http.uploadImage(teamMemberFile!.path)
        : null;
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

  List<CourseBannerImage> galleryImgList = [];
  bool editMode = false;
  void setEditMode(bool value) {
    editMode = value;
    notifyListeners();
  }

  Future<void> validateGalleryImages() async {
    if (editMode) {
      galleryImgList = await uploadFiles(
        galleryFiles,
        (file, res) => CourseBannerImage(
          name: file.path.split('/').last,
          url: res['url'],
          type: res['type'] ?? "image/jpeg",
          size: res['size'] ?? file.lengthSync(),
        ),
      );
      final newUrls =
          galleryImgList.map((img) => img.url).whereType<String>().toList();
      if (serverGalleryFiles == null) {
        serverGalleryFiles = newUrls;
      } else {
        serverGalleryFiles = [...serverGalleryFiles!, ...newUrls];
      }
      galleryImgList = serverGalleryFiles!
          .map(
            (url) => CourseBannerImage(
              name: url.split('/').last,
              url: url,
              type: "image/jpeg", // you can adjust if you have type info
              size: 0, // since we don’t know original file size
            ),
          )
          .toList();
    } else {
      // Otherwise upload the new images
      galleryImgList = await uploadFiles(
        galleryFiles,
        (file, res) => CourseBannerImage(
          name: file.path.split('/').last,
          url: res['url'],
          type: res['type'] ?? "image/jpeg",
          size: res['size'] ?? file.lengthSync(),
        ),
      );
    }

    notifyListeners();
  }

  Future<List<T>> uploadFiles<T>(
    List<File>? files,
    T Function(File, Map<String, dynamic>) builder,
  ) async {
    if (files == null || files.isEmpty) return [];

    final List<T> uploaded = [];

    for (var file in files) {
      final response = await _http.uploadImage(file.path);

      uploaded.add(builder(file, response));
    }
    return uploaded;
  }

  void addGallery(BuildContext context) async {
    Loaders.circularShowLoader(context);
    var attachments = galleryFile?.path != null && galleryFile!.path.isNotEmpty
        ? await addDirectorRepositoryImpl.http.uploadImage(galleryFile!.path)
        : null;
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
      getDirectories();
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
        "media_name": selectedAccount?.toLowerCase(),
        "media_link": socialAccountsurlCntr.text,
        "directory_id": getBasicInfoData.first.id,
        "status": "SOCIAL"
      }
    });
    if (result != null) {
      await getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Social urls added successfully');
      NavigationService().goBack();
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
      await getDirectories();
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
      await getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Testimonial added successfully');
      navigationService.goBack();
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

  Future<void> updateRecord() async {
    print("**************update record calling");
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    var logo = logoFile == null
        ? null
        : await addDirectorRepositoryImpl.http.uploadImage(logoFile?.path);

    Map<String, dynamic> requestData = {"id": userId};
    if (type == UserRole.supplier.value || type == UserRole.practice.value) {
      requestData["changes"] = {
        "name": nameController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "address": addressController.text,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "business_email":
            businessEmailCntr.text.isEmpty ? null : businessEmailCntr.text,
        "business_name": CompanyNameController.text,
        "mobile_number": "",
        "logo": logo == null ? getBasicInfoData.first.logo : logo,
        "abn_number": ABNNumberController.text,
      };
    } else {
      requestData["changes"] = {
        "name": nameController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "address": addressController.text,
        "profession_type": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "profile_image": {
          "url": "assets/images/social/male_avatar.png",
          "type": "STATIC"
        }
      };
    }

    print("**************$requestData");

    final res = await addDirectorRepositoryImpl.updateRecord(requestData);
    if (res != null) {
      print(res);
    }
  }

  Future<void> updateClient() async {
    print("**************update client calling");
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    Map<String, dynamic> requestData = {"id": userId};
    if (type == UserRole.practice.value || type == UserRole.supplier.value) {
      requestData["changes"] = {
        "type": type,
        "name": nameController.text,
        "email": emailController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "professionType": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
        "business_name": CompanyNameController.text,
      };
    }
    {
      requestData["changes"] = {
        "type": type,
        "name": nameController.text,
        "email": emailController.text,
        "phone": '$phoneCode${MobileNumberController.text}',
        "professionType": selectedBusineestype?.name,
        "professiontype": selectedBusineestype,
      };
    }
    final res = await addDirectorRepositoryImpl.updateClient(requestData);
    if (res != null) {
      print(res);
    }
  }

  Future<void> clearAllDirectorData() async {
    getBasicInfoData = [];
    MobileNumberController.clear();
    CompanyNameController.clear();
    nameController.clear();
    emailController.clear();
    descController.clear();
    alternateNumberController.clear();
    ABNNumberController.clear();
    addressController.clear();
    certificateNameController.clear();
    serviceNameController.clear();
    serviceDescController.clear();
    achievementNameController.clear();
    documentNameController.clear();
    teamNameCntr.clear();
    teamDesignationCntr.clear();
    teamNumberCntr.clear();
    teamEmailIDCntr.clear();
    teamLocationCntr.clear();
    questionCntr.clear();
    answerCntr.clear();
    messageCntr.clear();
    testiNameCntr.clear();
    socialAccountsurlCntr.clear();
    SelectTimeController.clear();
    roleCntr.clear();
    selectWeekCntr.clear();
    serviceStartTimeCntr.clear();
    serviceEndTimeCntr.clear();
    breakStartTimeCntr.clear();
    breakEndTimeCntr.clear();
    serviceTimemInCntr.clear();
    partnerNameCntr.clear();
    descriptionCntr.clear();
    latitude = null;
    longitude = null;
    dayWiseTimeSlots.clear();
    _currentStep = 0;
    selectedShowPromotion = "All Users";
    logoFile = null;
    bannerFile = null;
    serviefile = null;
    certificateFile = null;
    achievementFile = null;
    documentFile = null;
    teamMemberFile = null;
    testimonialsFile = null;
    testimonialsPicFile = null;
    galleryFile = null;
    partnerImgFile = null;
    selectedDays = null;
    selectedAccount = null;
    selectedBusineestype = null;
    _selectedTeamMemberList.clear();
    _selectedServiceList.clear();
    _selectedDaysList.clear();
    _emailVisibility = null;
    _phoneVisibility = null;
    selectedPhoneCode = "AU (+61)";
    serviceShowApmt = false;
    isEditService = false;
    appointmentShowVal = false;
    ourTeamShowVal = false;
    notifyListeners();
  }
}
