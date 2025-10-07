import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/widget/string_extensions.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import '../../talents/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TalentsViewModel extends ChangeNotifier {
  final TalentRepoImpl repo = TalentRepoImpl();
  TalentsViewModel() {
    initializeFilterOptions();
  }
  String? enquiryData;
  int? _expandedIndex;
  int? get expandedIndex => _expandedIndex;
  bool isShowBottomeActions = false;
  List<JobProfile> talentList = [];
  List<JobProfile> filteredJobs = [];
  final TextEditingController locationController = TextEditingController();
  final TextEditingController availabilityDateController = TextEditingController();  
  late Map<String, List<FilterItem>> filterOptions;
  List<String> selectedProfessions = [];
  List<String> selectedEmploymentTypes = [];
  List<String> selectedExperiences = [];
  List<String> selectedAvailability = [];
  List<String> selectedDays = [];
  List<DateTime> availabilityDates = [];
  Map<String, Set<int>> selectedIndices = {
    'profession': {},
    'employment': {},
    'experience': {},
    'availability': {},
  };
  Map<String, bool> sectionVisibility = {
    'profession': true,
    'employment': true,
    'experience': true,
    'availability': true,
  };
  String? selectedExperienceDropdown;
  String? selectedSort;
  final List<String> sortOptions = ['A to Z', 'Z to A'];
  List<String> experienceOptions = [
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
  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final List<String> employmentTypeList = [
    "Contractor",
    "Temporary Contractor",
    "Locum",
    "Full Time",
    "Part Time",
    "Casual"
  ];
  final List<String> jobRoles = [
    "Surgeon",
    "Dentist",
    "Dental Hygienist",
    "Dental Prosthetist",
    "Dental Specialist",
  ];
  void toggleIndex(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = null;
    } else {
      _expandedIndex = index;
    }
    notifyListeners();
  }

  isShowBottomeActionss(String professionalId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    isShowBottomeActions = userId == professionalId;
    notifyListeners();
  }

  Future<void> initializeFilterOptions() async {
    filterOptions = {
      'profession': jobRoles
          .map((e) => FilterItem(
                name: e,
                id: e,
              ))
          .toList(),
      'employment': employmentTypeList
          .map((e) => FilterItem(
                name: e,
                id: e,
              ))
          .toList(),
      'experience': experienceOptions
          .map((e) => FilterItem(
                name: "$e Years",
                id: e,
              ))
          .toList(),
      'availability': weekDays
          .map((e) => FilterItem(
                name: e,
                id: e,
              ))
          .toList(),
    };
    notifyListeners();
  }
  Future<void> fetchTalentProfiles(BuildContext context) async {
    Loaders.circularShowLoader(context);
    try {
      talentList = await repo.getTalentDetails();
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> fetchFilteredJobs(BuildContext context) async {
    Loaders.circularShowLoader(context);
    try {
      printSelectedItems();
      final result = await repo.getJobProfileFilterData(
        where: {
          'status': {'_eq': 'active'},
        },
        limit: 20,
        offset: 0,
      );
      filteredJobs = result;
      print("Fetched ${filteredJobs.length} filtered talents");
    } catch (e) {
      print("Error fetching filtered talents: $e");
      filteredJobs = [];
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<bool> hireMe(HireMeRequest request) async {
    await repo.hireMe(request);
    return true;
  }

  Future<bool> enquire(EnquiryRequest request) async {
    await repo.enquire(request);
    return true;
  }

  void onChangeEnquireData(String data) {
    enquiryData = data;
  }

  List<FilterItem> getSortedProfessionOptions() {
    final list = filterOptions['profession'] ?? [];
    return applySorting(list, (item) => item.name.capitalizeFirstLetter());
  }

  List<FilterItem> getSortedEmploymentOptions() {
    final list = filterOptions['employment'] ?? [];
    return applySorting(list, (item) => item.name.capitalizeFirstLetter());
  }

  List<FilterItem> getSortedDaysOptions() {
    final list = filterOptions['availability'] ?? [];
    return applySorting(list, (item) => item.name.capitalizeFirstLetter());
  }

  List<T> applySorting<T>(List<T> list, String Function(T) getField) {
    if (selectedSort == 'A to Z') {
      list.sort((a, b) =>
          getField(a).toLowerCase().compareTo(getField(b).toLowerCase()));
    } else if (selectedSort == 'Z to A') {
      list.sort((a, b) =>
          getField(b).toLowerCase().compareTo(getField(a).toLowerCase()));
    }
    return list;
  }

  void selectItem(String section, int index) {
    final currentSet = selectedIndices[section] ?? {};
    if (currentSet.contains(index)) {
      currentSet.remove(index);
    } else {
      currentSet.add(index);
    }
    selectedIndices[section] = currentSet;
    notifyListeners();
  }

  void setExperience(String value) {
    selectedExperienceDropdown = value;
    notifyListeners();
  }

  void setSort(String value) {
    selectedSort = value;
    notifyListeners();
  }

  //__________DATE PICKER LOGIC______________________//
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
    if (availabilityDates.isEmpty) {
      availabilityDateController.clear();
    } else {
      final formatted = availabilityDates
          .map((d) => DateFormat('MMM d, yyyy').format(d))
          .toList();
      availabilityDateController.text = formatted.join(", ");
    }
    notifyListeners();
  }

  bool isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
  //_____________Filter Section Methods_________________//
  void clearSelections() {
    selectedIndices.updateAll((key, value) => {});
    selectedExperienceDropdown = null;
    selectedSort = null;
    availabilityDates.clear();
    selectedDays.clear();
    locationController.clear();
    notifyListeners();
  }

  void printSelectedItems() {
    selectedProfessions = [];
    selectedEmploymentTypes = [];
    selectedExperiences = [];
    selectedAvailability = [];
    selectedIndices.forEach((section, indices) {
      final items = filterOptions[section];
      if (items != null && indices.isNotEmpty) {
        for (final i in indices) {
          final id = items[i].id;
          if (section == "profession") {
            selectedProfessions.add(id);
          } else if (section == "employment") {
            selectedEmploymentTypes.add(id);
          } else if (section == "availability") {
            selectedDays.add(id);
          }
        }
      }
    });
    if (selectedExperienceDropdown != null) {
      selectedExperiences.add(selectedExperienceDropdown!);
    }
    if (availabilityDates.isNotEmpty) {
      selectedAvailability = availabilityDates
          .map((d) => DateFormat('yyyy-MM-dd').format(d))
          .toList();
    }

    print("Professions: $selectedProfessions");
    print("Employment: $selectedEmploymentTypes");
    print("Experiences: $selectedExperiences");
    print("Availability Dates: $selectedAvailability");
    print("Days: $selectedDays");
  }
}
