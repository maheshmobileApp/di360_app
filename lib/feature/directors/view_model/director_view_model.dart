import 'dart:io';

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

  // Static Dropdown Lists
  final List<String> teamMemberList = ['All Team Member', 'George'];
  final List<String> serviceList = ['124356'];

  final List<QuickLinkItem> quickLinkItems = [
    QuickLinkItem(label: 'Basic Info', icon: Icons.info),
    QuickLinkItem(label: 'Services', icon: Icons.medical_services),
    QuickLinkItem(label: 'Team', icon: Icons.people),
    QuickLinkItem(label: 'Gallery', icon: Icons.photo_library),
    QuickLinkItem(label: 'Document', icon: Icons.edit_document),
    QuickLinkItem(label: 'Achievements', icon: Icons.emoji_events),
    QuickLinkItem(label: 'Certifications', icon: Icons.verified),
    QuickLinkItem(label: 'Book Appointment', icon: Icons.calendar_today),
    QuickLinkItem(label: 'Testimonials', icon: Icons.rate_review),
    QuickLinkItem(label: 'FAQ', icon: Icons.insert_drive_file),
    QuickLinkItem(label: 'Contact Us', icon: Icons.location_on),
  ];
  // sectionKeys
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
  final List<File> _selectedFiles = [];

  List<File> get selectedFiles => _selectedFiles;
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
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      _selectedFiles.addAll(result.paths.map((path) => File(path!)));
      notifyListeners();
    }
  }

  void removeFile(int index) {
    _selectedFiles.removeAt(index);
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
    firstNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    appointmentDateController.dispose();
  }
}

class QuickLinkItem {
  final String label;
  final IconData icon;

  QuickLinkItem({required this.label, required this.icon});
}
