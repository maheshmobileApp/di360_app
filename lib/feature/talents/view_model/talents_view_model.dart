import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/widget/string_extensions.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/feature/talents/model/update_hiring_status_res.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
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
  List<JobProfiles> talentList = [];
  List<JobProfiles> filteredJobs = [];
  int _currentPage = 0;
  bool _hasMoreTalents = true;
  bool _isLoadingMore = false;
  bool isLoading = false;
  final int _talentLimit = 15;

  bool get hasMoreTalents => _hasMoreTalents;
  bool get isLoadingMore => _isLoadingMore;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController availabilityDateController =
      TextEditingController();
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
    "Casual",
    "Part Time",
    "Contractor",
    "Full Time"
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

  Future<void> fetchTalentProfiles(BuildContext context,
      {bool loadMore = false}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    if (loadMore && (_isLoadingMore || !_hasMoreTalents)) return;

    if (loadMore) {
      _isLoadingMore = true;
    } else {
      isLoading = true;
      _currentPage = 0;
      _hasMoreTalents = true;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();

    try {
      final variables = {
        "limit": _talentLimit,
        "offset": _currentPage * _talentLimit,
        "where": {
          "_and": [
            {
              "admin_status": {"_eq": "APPROVE"}
            },
            {
              "active_status": {"_eq": "ACTIVE"}
            }
          ]
        },
        "order_by": [
          {"created_at": "desc"}
        ],
        "loginId": userId
      };
      final result = await repo.getTalentDetails(variables);

      if (loadMore) {
        talentList.addAll(result);
      } else {
        talentList = result;
      }

      _hasMoreTalents = result.length >= _talentLimit;
      if (result.isNotEmpty) {
        _currentPage++;
      }

      if (!loadMore) {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      if (!loadMore) {
        talentList = [];
      }
    } finally {
      isLoading = false;
      if (!loadMore) {
        Loaders.circularHideLoader(context);
      }
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  Future<void> refreshTalents(BuildContext context) async {
    _isRefreshing = true;
    _currentPage = 0;
    _hasMoreTalents = true;
    notifyListeners();
    await fetchTalentsForSelectedView(context);
    _isRefreshing = false;
    notifyListeners();
  }

  Future<void> fetchTalentsForSelectedView(BuildContext context,
      {bool loadMore = false}) async {
    final hasFilters = selectedProfessions.isNotEmpty ||
        selectedEmploymentTypes.isNotEmpty ||
        selectedExperiences.isNotEmpty ||
        selectedAvailability.isNotEmpty ||
        selectedDays.isNotEmpty ||
        locationController.text.isNotEmpty;

    if (hasFilters) {
      await fetchFilteredJobs(context, loadMore: loadMore);
    } else {
      await fetchTalentProfiles(context, loadMore: loadMore);
    }
  }

  UpdateHiringStatusData? hiringStatusData;
  String? hiringStatus;
  void setHiringStatus(String status) {
    hiringStatus = status;
    notifyListeners();
  }

  Future<void> updateHiringStatus(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id, "status": "PENDING"};
    try {
      final res = await repo.updateHiringStatus(variables);
      hiringStatusData = res;
      setHiringStatus(
          hiringStatusData?.updateJobhiringsByPk?.hiringStatus ?? '');
      print("Updated hiring status: $res");
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  //get talent list by id
  List<JobProfiles>? talentListById;
  Future<void> getTalentListMutationById(
      BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    try {
      final res = await repo.getTalentListMutationById(variables);
      talentListById = res;
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> fetchFilteredJobs(BuildContext context,
      {bool loadMore = false}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    if (loadMore && (_isLoadingMore || !_hasMoreTalents)) return;

    if (loadMore) {
      _isLoadingMore = true;
    } else {
      isLoading = true;
      _currentPage = 0;
      _hasMoreTalents = true;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();

    try {
      printSelectedItems();

      List<Map<String, dynamic>> whereConditions = [
        {
          "admin_status": {"_eq": "APPROVE"}
        },
        {
          "active_status": {"_eq": "ACTIVE"}
        }
      ];

      if (locationController.text.isNotEmpty) {
        whereConditions.add({
          "_or": [
            {
              "full_name": {"_ilike": "%${locationController.text}%"}
            },
            {
              "location": {"_ilike": "%${locationController.text}%"}
            },
            {
              "city": {"_ilike": "%${locationController.text}%"}
            },
            {
              "state": {"_ilike": "%${locationController.text}%"}
            }
          ]
        });
      }

      if (selectedProfessions.isNotEmpty) {
        whereConditions.add({
          "profession_type": {"_in": selectedProfessions}
        });
      }

      if (selectedEmploymentTypes.isNotEmpty) {
        whereConditions.add({
          "work_type": {"_has_keys_any": selectedEmploymentTypes}
        });
      }

      if (selectedAvailability.isNotEmpty) {
        whereConditions.add({
          "availabilityDate": {"_has_keys_any": selectedAvailability}
        });
      }

      if (selectedDays.isNotEmpty) {
        whereConditions.add({
          "availabilityDay": {"_has_keys_any": selectedDays}
        });
      }

      if (selectedExperiences.isNotEmpty) {
        whereConditions.add({
          "Year_of_experiance": {"_eq": selectedExperiences.first}
        });
      }

      final variables = {
        "limit": _talentLimit,
        "offset": _currentPage * _talentLimit,
        "where": {"_and": whereConditions},
        "loginId": userId
      };

      if (selectedSort != null) {
        variables["order_by"] = [
          {"full_name": selectedSort == 'A to Z' ? 'asc' : 'desc'}
        ];
      } else {
        variables["order_by"] = [
          {"created_at": "desc"}
        ];
      }

      print("Talent Filter Variables $variables");

      final result = await repo.getJobProfileFilterData(variables);

      if (loadMore) {
        talentList.addAll(result);
        filteredJobs.addAll(result);
      } else {
        if (result != []) {
          talentList = result;
        }
        filteredJobs = result;
      }

      _hasMoreTalents = result.length >= _talentLimit;
      if (result.isNotEmpty) {
        _currentPage++;
      }

      print(
          "Fetched ${result.length} filtered talents, total: ${filteredJobs.length}");
    } catch (e) {
      print("Error fetching filtered talents: $e");
      if (!loadMore) {
        filteredJobs = [];
      }
    } finally {
      isLoading = false;
      if (!loadMore) {
        Loaders.circularHideLoader(context);
      }
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<bool> hireMe(HireMeRequest request) async {
    await repo.hireMe(request);
    return true;
  }

  Future<void> hireMeTalent(String id, String dentalProfessionalId) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "jobHiringsDetails": {
        "job_profiles_id": id,
        "dental_professional_id": dentalProfessionalId,
        "dental_supplier_id": type == UserRole.supplier.value ? userId : null,
        "dental_practice_id": type == UserRole.practice.value ? userId : null,
        "hiring_status": "PENDING"
      }
    };
    final res = await repo.hireMeTalent(variables);
    print("**************Hire Me Talent Response: $res");
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
    availabilityDateController.text = "";
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
    selectedDays = [];
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
