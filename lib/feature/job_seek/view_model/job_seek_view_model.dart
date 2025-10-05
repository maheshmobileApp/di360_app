import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/attachment.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';
import 'package:di360_flutter/feature/job_seek/model/upload_response.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo_impl.dart';
import 'package:di360_flutter/feature/job_seek/widget/string_extensions.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/utils/generated_id.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobSeekViewModel extends ChangeNotifier {
  final JobSeekRepoImpl repo = JobSeekRepoImpl();

  JobSeekViewModel() {
    // Initialize immediately with empty structure to avoid late init crash
    filterOptions = {
      'profession': [],
      'employment': [],
      'experience': List.generate(10, (i) =>
          FilterItem(name: "${i + 1} Years", id: "${i + 1}")),
      'availability': [],
    };
    // Then safely load real data
    initializeFilterOptions();
  }

  String? _enquiryData;
  Jobs? selectedJob;
  bool isJobApplied = false;
  List<Jobs> jobs = [];
  List<Jobs> filteredJobs = [];

  final TextEditingController locationController = TextEditingController();
  final TextEditingController locumDateController = TextEditingController();

  late Map<String, List<FilterItem>> filterOptions;

  List<String> selectedProfessions = [];
  List<String> selectedEmploymentTypes = [];
  List<String> selectedExperiences = [];
  List<String> selectedAvailability = [];

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

  List<DateTime> selectedLocumDatesObjects = [];
  bool showLocumDate = false;
  bool showMultiCalendar = false;
  bool isLoading = false;
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

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;
  bool _isTabLoading = false;
  bool get isTabLoading => _isTabLoading;
  bool isHidleFolatingButton = false;

  Future<void> setSelectedIndex(int index, BuildContext context) async {
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    _isTabLoading = true;
    notifyListeners();
    if (index == 0) {
      await fetchJobs(context);
    } else {
      final talentsVM = Provider.of<TalentsViewModel>(context, listen: false);
      await talentsVM.fetchTalentProfiles(context);
    }
    _isTabLoading = false;
    notifyListeners();
  }

  void toggleFloatingButtonVisibility() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userRole = UserRole.fromString(type);
    switch (userRole) {
      case UserRole.professional:
        isHidleFolatingButton = true;
        break;
      case UserRole.supplier:
      case UserRole.practice:
        isHidleFolatingButton = false;
        break;
      default:
        isHidleFolatingButton = true;
    }
    notifyListeners();
  }

  void setSelectedJob(Jobs job) {
    selectedJob = job;
  }

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  Future<void> refreshJobs(BuildContext context) async {
    _isRefreshing = true;
    notifyListeners();
    await fetchJobsForSelectedTab(context);
    _isRefreshing = false;
    notifyListeners();
  }

  Future<void> fetchJobsForSelectedTab(BuildContext context) async {
    if (_selectedTabIndex == 0) {
      await fetchFilteredJobs();
    }
  }

  Future<void> fetchFilteredJobs() async {
  isLoading = true;
  notifyListeners();

  try {
    print("Selected Professions: $selectedProfessions");
    print("Selected Employment Types: $selectedEmploymentTypes");
    print("Selected Experiences: $selectedExperiences");
    print("Selected Availability Dates: $selectedAvailability");

    final result = await repo.fetchFilteredJobs(
      selectedProfessions,
      selectedEmploymentTypes,
      selectedExperiences,
      selectedAvailability,
    );

    filteredJobs = result;
    print("Fetched ${filteredJobs.length} filtered jobs");
  } catch (e) {
    print("Error fetching filtered jobs: $e");
    filteredJobs = [];
  } finally {
    isLoading = false;
    notifyListeners();
  }
}



  Future<bool> applyJob(ApplyJobRequest applyJobRequest) async {
    applyJobRequest.jobId = selectedJob?.id ?? '';
    final generatedID = GeneratedId.generateId();
    applyJobRequest.id = generatedID;

    if (applyJobRequest.attachments.url.isNotEmpty) {
      final uploadImage =
          await repo.uploadTheResume(applyJobRequest.attachments.url);
      final response = UploadResponse.fromJson(uploadImage);
      applyJobRequest.attachments = Attachment(
        url: response.url,
        name: response.name,
        type: response.mimeType,
      );
    }

    try {
      await repo.applyJob(applyJobRequest);
      sendMessage(applyJobRequest.message, generatedID);
      return true;
    } catch (_) {
      return false;
    }
  }

  void sendMessage(String message, String applicationId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final payload = SendMessageRequest(
      jobApplicantId: applicationId,
      message: message,
      messageFrom: userId,
    );
    await repo.sendMessageRequest(payload);
  }

  void getApplyJobStatus(String jobId, String dentalProfessionalId) async {
    try {
      final result = await repo.getJobApplyStatus(jobId, dentalProfessionalId);
      isJobApplied = result.jobApplicants.any(
        (applicant) => applicant.dentalProfessionalId == dentalProfessionalId,
      );
      notifyListeners();
    } catch (e) {
      print("Error fetching job apply status: $e");
    }
  }

  void onChangeEnquireData(String data) {
    _enquiryData = data;
  }

  Future<bool> jobEnquire(String jobId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    var enquireData = EnquireRequest(
      enquiryDescription: _enquiryData ?? '',
      jobId: jobId,
      enquiryUserId: userId,
    );
    try {
      await repo.enquire(enquireData);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> fetchJobs(BuildContext context) async {
    Loaders.circularShowLoader(context);
    try {
      var jobData = await repo.getPopularJobs();
      jobs = jobData.jobs ?? [];
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> initializeFilterOptions() async {
    try {
      final roles = await repo.getJobRoles();
      final types = await repo.getJobWorkTypes();

      filterOptions['profession'] =
          roles.map((e) => FilterItem(name: e.roleName ?? '', id: e.roleName ?? '')).toList();
      filterOptions['employment'] =
          types.map((e) => FilterItem(name: e.employeeTypeName ?? '', id: e.employeeTypeName ?? '')).toList();

      notifyListeners();
    } catch (e) {
      print("Error initializing filter options: $e");
    }
  }

  List<FilterItem> getSortedProfessionOptions() {
    final list = filterOptions['profession'] ?? [];
    return applySorting(list, (item) => item.name.capitalizeFirstLetter());
  }

  List<FilterItem> getSortedEmploymentOptions() {
    final list = filterOptions['employment'] ?? [];
    return applySorting(list, (item) => item.name.capitalizeFirstLetter());
  }

  List<T> applySorting<T>(List<T> list, String Function(T) getField) {
    if (selectedSort == 'A to Z') {
      list.sort((a, b) => getField(a).toLowerCase().compareTo(getField(b).toLowerCase()));
    } else if (selectedSort == 'Z to A') {
      list.sort((a, b) => getField(b).toLowerCase().compareTo(getField(a).toLowerCase()));
    }
    return list;
  }

  void toggleSection(String section) {
    sectionVisibility[section] = !(sectionVisibility[section] ?? true);
    notifyListeners();
  }

  void selectItem(String section, int index) {
    final currentSet = selectedIndices[section] ?? {};
    if (currentSet.contains(index)) {
      currentSet.remove(index);
    } else {
      currentSet.add(index);
    }

    if (section == 'employment') {
      final id = filterOptions[section]?[index].id;
      if (id == "Locum") {
        showLocumDate = currentSet.contains(index);
        if (!showLocumDate) {
          selectedLocumDatesObjects.clear();
          locumDateController.clear();
        }
      }
    }

    selectedIndices[section] = currentSet;
    notifyListeners();
  }

  void toggleCalendarVisibility() {
    showMultiCalendar = !showMultiCalendar;
    notifyListeners();
  }

  void toggleLocumDate(DateTime date) {
    if (selectedLocumDatesObjects.any((d) => isSameDate(d, date))) {
      selectedLocumDatesObjects.removeWhere((d) => isSameDate(d, date));
    } else {
      selectedLocumDatesObjects.add(date);
    }
    updateLocumDateControllerText();
  }

  void removeLocumDate(DateTime date) {
    selectedLocumDatesObjects.removeWhere((d) => isSameDate(d, date));
    updateLocumDateControllerText();
  }

  void updateLocumDateControllerText() {
    final formatted = selectedLocumDatesObjects
        .map((d) => DateFormat('d/M/yyyy').format(d))
        .toList();
    locumDateController.text = formatted.join(" | ");
    notifyListeners();
  }

  List<String> get selectedLocumDates => selectedLocumDatesObjects
      .map((d) => DateFormat('yyyy-MM-dd').format(d))
      .toList();

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void setExperience(String value) {
    selectedExperienceDropdown = value;
    notifyListeners();
  }

  void setSort(String value) {
    selectedSort = value;
    notifyListeners();
  }

  void clearSelections() {
    selectedIndices.updateAll((key, value) => {});
    selectedExperienceDropdown = null;
    selectedSort = null;
    selectedLocumDatesObjects.clear();
    showLocumDate = false;
    locationController.clear();
    locumDateController.clear();
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
          }
        }
      }
    });

    if (selectedExperienceDropdown != null) {
      selectedExperiences.add(selectedExperienceDropdown!);
    }

    if (selectedLocumDatesObjects.isNotEmpty) {
      selectedAvailability = selectedLocumDatesObjects
          .map((d) => DateFormat('yyyy-MM-dd').format(d))
          .toList();
    }
  }
}
