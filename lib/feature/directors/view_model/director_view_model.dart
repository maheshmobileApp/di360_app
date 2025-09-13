import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/directors/model_class/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_appointment_slots_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_team_members_res.dart';
import 'package:di360_flutter/feature/directors/respository/director_repository_impl.dart';
import 'package:di360_flutter/feature/home/model_class/get_followers_res.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DirectorViewModel extends ChangeNotifier {
  final DirectorRepositoryImpl repository = DirectorRepositoryImpl();
  final HttpService _http = HttpService();

  DirectorViewModel() {
    getBannerList();
    getDirectorCatagoryList();
  }
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController appointmentDateController =
      TextEditingController();

// Dropdown Selections
  String? selectedTeamMember;
  String? selectedService;

  final List<String> serviceList = ['Test'];

  List<QuickLinkItem> quickLinkItems = [];
 
  final Map<String, GlobalKey> sectionKeys = {
    'Basic Info': GlobalKey(),
    'Services': GlobalKey(),
    'Team': GlobalKey(),
    'Gallery': GlobalKey(),
    'Document': GlobalKey(),
    'Achievements': GlobalKey(),
    'Certifications': GlobalKey(),
    'Book Appointment': GlobalKey(),
    'Testimonials': GlobalKey(),
    'FAQ': GlobalKey(),
    'Contact Us': GlobalKey(),
  };
  bool isValidated = false;
  bool validateForm() {
    isValidated = formKey.currentState?.validate() ?? false;
    notifyListeners();
    return isValidated;
  }

  List<Directories> directorsList = [];
  List<Banners> bannerList = [];
  List<DirectoryBusinessTypes>? catagoryTypesList;
  List<dynamic> interleavedList = [];
  TextEditingController searchController = TextEditingController();
  DirectoriesByPk? directorDetails;
  List<DirectoryAppointments>? appointmentSlots = [];
  List<DirectoryTeamMember>? teamMembers = [];
  DirectoryAppointments? dayWiseTimeslots;
  GetFollowersData? getFollowersData;
  bool _removeIcon = false;
  bool get removeIcon => _removeIcon;

  String? _timeSlotSelected;

  String? get timeSlotSelected => _timeSlotSelected;

  void updateTimeSlotSelect(String value) {
    _timeSlotSelected = value;
    notifyListeners();
  }

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;
  String? supportingImg;
  dynamic supportingImageObj;

  void selectSingleCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    updateTheRemoveIcon(true);
    notifyListeners();
  }

  void scrollToSectionByLabel(String label) {
    final key = sectionKeys[label];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> getDirectorsList(BuildContext context) async {
    directorsList = [];
    Loaders.circularShowLoader(context);
    final res = await repository.getDirectors(
        _selectedCategoryId ?? '', searchController.text);
    if (res.isNotEmpty) {
      directorsList = res;
      await getBannerList();
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    await updateInterleavedList();
    notifyListeners();
  }

  Future<void> updateInterleavedList() async {
    List<dynamic> items = [];
    interleavedList = [];
    int bannerIndex = 0;

    for (int i = 0; i < directorsList.length; i += 2) {
      List<Directories> pair = [];
      pair.add(directorsList[i]);
      if (i + 1 < directorsList.length) {
        pair.add(directorsList[i + 1]);
      }
      items.add(pair);

      if (((i + 2) % 6 == 0) && bannerIndex < bannerList.length) {
        items.add(bannerList[bannerIndex]);
        bannerIndex++;
      }
    }

    interleavedList = items;
    notifyListeners();
  }

  Future<void> getBannerList() async {
    final res = await repository.getBannersList();
    if (res.isNotEmpty) {
      bannerList = res;
    }
    notifyListeners();
  }

  Future<void> getDirectorCatagoryList() async {
    final res = await repository.directoriesCatagory();
    if (res.isNotEmpty) {
      catagoryTypesList = res;
    }
    notifyListeners();
  }

  updateTheRemoveIcon(bool val) {
    _removeIcon = val;
    notifyListeners();
  }

  void clearFilter() {
    _selectedCategoryId = null;
    searchController.clear();
    updateTheRemoveIcon(false);
    getDirectorsList(navigatorKey.currentContext!);
    notifyListeners();
  }

  Future<void> GetDirectorDetails(String id) async {
    Loaders.circularShowLoader(navigatorKey.currentContext!);
    final res = await repository.directoriesDetailsQuery(id);
    if (res != null) {
      directorDetails = res;
      quickLinkItems = [
        if (directorDetails?.description != null)
          QuickLinkItem(label: 'Basic Info', icon: Icons.info),
        if (directorDetails?.directoryServices?.length != 0)
          QuickLinkItem(label: 'Services', icon: Icons.medical_services),
        if (directorDetails?.directoryTeamMembers?.length != 0)
          QuickLinkItem(label: 'Team', icon: Icons.people),
        if (directorDetails?.directoryGalleryPosts?.length != 0 &&
            directorDetails?.directoryGalleryPosts?.first.image?.length != 0)
          QuickLinkItem(label: 'Gallery', icon: Icons.photo_library),
        if (directorDetails?.directoryDocuments?.length != 0)
          QuickLinkItem(label: 'Document', icon: Icons.edit_document),
        if (directorDetails?.directoryAchievements?.length != 0)
          QuickLinkItem(label: 'Achievements', icon: Icons.emoji_events),
        if (directorDetails?.directoryCertifications?.length != 0)
          QuickLinkItem(label: 'Certifications', icon: Icons.verified),
        if (directorDetails?.directoryAppointmentSlots?.length != 0)
          QuickLinkItem(label: 'Book Appointment', icon: Icons.calendar_today),
          if (directorDetails?.directoryTestimonials?.length != 0)
        QuickLinkItem(label: 'Testimonials', icon: Icons.rate_review),
        if (directorDetails?.directoryFaqs?.length != 0)
        QuickLinkItem(label: 'FAQ', icon: Icons.insert_drive_file),
        if (directorDetails?.directoryLocations?.length != 0)
        QuickLinkItem(label: 'Contact Us', icon: Icons.location_on),
      ];
      getFollowersCount(directorDetails?.id ?? '');
      getAppointmentSlots(id);
      getTeamMembersData(id);
      Loaders.circularHideLoader(navigatorKey.currentContext!);
      navigationService.navigateTo(RouteList.directoryDetailsScreen);
    } else {
      Loaders.circularHideLoader(navigatorKey.currentContext!);
    }
    notifyListeners();
  }

  getFollowersCount(String id) async {
    try {
      var res = await _http.query(getFollowersQuery, variables: {'userId': id});
      if (res != null) {
        final result = GetFollowersData.fromJson(res);
        getFollowersData = result;
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      supportingImg = result.files.first.path;
      var value = await _http.uploadImage(supportingImg);
      supportingImageObj = value;
    }
    notifyListeners();
  }

  Future<void> getAppointmentSlots(String id) async {
    final res = await repository.appointmentsSlots(id);
    appointmentSlots = res;
    notifyListeners();
  }

  Future<void> getTeamMembersData(String id) async {
    final res = await repository.getTeamMembers(id);
    teamMembers = res;
    notifyListeners();
  }

  Future<void> bookAppointment(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final res = await repository.bookAppointmentDirector({
      "apptData": {
        "name": firstNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "appointment_date": appointmentDateController.text,
        "message": descController.text,
        "last_name": lastNameController.text,
        "directory_id": dayWiseTimeslots?.directoryId,
        "timeslot": {
          "timeSlotStart": _timeSlotSelected,
          "desable": false,
          "doctor": dayWiseTimeslots?.serviceMember?.first,
          "service": [dayWiseTimeslots?.serviceName?.first]
        },
        "directory_service_id": dayWiseTimeslots?.directoryServiceId?.first,
        "service_name": selectedService,
        "attachments": supportingImageObj,
        "status": "PENDING"
      }
    });
    if (res["insert_directory_appointments_one"] != null) {
      scaffoldMessenger('Appointment Booked Successfully');
      disposeControllers();
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  void timeSlots(String day) {
    final slots = appointmentSlots;
    for (var slot in slots!) {
      if (slot.weekdays!.contains(day)) {
        dayWiseTimeslots = slot;
      }
    }
    notifyListeners();
  }

  void disposeControllers() {
    firstNameController.clear();
    phoneController.clear();
    emailController.clear();
    appointmentDateController.clear();
    lastNameController.clear();
    descController.clear();
    selectedTeamMember = null;
    selectedService = null;
    supportingImageObj = null;
    supportingImg = null;
    notifyListeners();
  }
}

class QuickLinkItem {
  final String label;
  final IconData icon;

  QuickLinkItem({required this.label, required this.icon});
}
