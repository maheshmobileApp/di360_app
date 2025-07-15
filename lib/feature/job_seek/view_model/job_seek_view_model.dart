import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/attachment.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/jobseekfilter_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';
import 'package:di360_flutter/feature/job_seek/model/upload_response.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo_impl.dart';
import 'package:di360_flutter/utils/generated_id.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobSeekViewModel extends ChangeNotifier {
  final JobSeekRepoImpl repo = JobSeekRepoImpl();

  JobSeekViewModel() {
    getJobRoles();
    getJobWorkTypes();
  }

  // ------------------ Job Data ------------------
  String? _enquiryData;
  Jobs? selectedJob;
  bool isJobApplied = false;
  List<Jobs> jobs = [];
  List<JobSeekFilterModel> filteredJobs = [];

  // ------------------ Tab & Floating Button ------------------
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  bool isHidleFolatingButton = false;

  void setSelectedIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void toggleFloatingButtonVisibility() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userRole = UserRole.fromString(type);
    isHidleFolatingButton = userRole == UserRole.professional;
    notifyListeners();
  }

  // ------------------ Apply Job ------------------
  void setSelectedJob(Jobs job) {
    selectedJob = job;
  }

  Future<bool> applyJob(ApplyJobRequest applyJobRequest) async {
    applyJobRequest.jobId = selectedJob?.id ?? '';
    final generatedID = GeneratedId.generateId();
    applyJobRequest.id = generatedID;

    final uploadImage = await repo.uploadTheResume(applyJobRequest.attachments.url);
    final response = UploadResponse.fromJson(uploadImage);

    applyJobRequest.attachments = Attachment(
      url: response.url,
      name: response.name,
      type: response.mimeType,
    );

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

  // ------------------ Filter Logic ------------------

  final TextEditingController locationController = TextEditingController();
  final TextEditingController locumDateController = TextEditingController();

  Map<String, List<FilterItem>> filterOptions = {};
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

  List<String> selectedProfessions = [];
  List<String> selectedEmploymentChips = [];
  List<String> selectedExperience = [];
  List<String> selectedLocumDates = [];

  List<String> professionOptions = [];
  List<String> employmentOptions = [];

  List<String> experienceOptions = ["0", "1–2", "3–5", "5–10", "10–15", "15–20"];
  String? selectedExperienceDropdown;

  List<String> sortOptions = ["A to Z", "Z to A"];
  String? selectedSort;

  bool showLocumDate = false;
  bool isLoading = false;

  // ------------------ INIT ------------------

  Future<void> getJobRoles() async {
    final result = await repo.getJobRoles();
    professionOptions = result.map((e) => e.roleName ?? '').toList();
    notifyListeners();
  }

  Future<void> getJobWorkTypes() async {
    final result = await repo.getJobWorkTypes();
    employmentOptions = result.map((e) => e.employeeTypeName ?? '').toList();
    notifyListeners();
  }

  Future<void> initializeFilterOptions() async {
    final roles = await repo.getJobRoles();
    final types = await repo.getJobWorkTypes();

    filterOptions = {
      'profession': roles.map((e) => FilterItem(name: e.roleName ?? '', id: e.roleName ?? '')).toList(),
      'employment': types.map((e) => FilterItem(name: e.employeeTypeName ?? '', id: e.employeeTypeName ?? '')).toList(),
      'experience': List.generate(10, (i) => FilterItem(name: "${i + 1} Years", id: "${i + 1}")),
      'availability': [],
    };

    notifyListeners();
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
    selectedIndices[section] = currentSet;
    notifyListeners();
  }

  void toggleEmploymentFilter(String option) {
    if (selectedEmploymentChips.contains(option)) {
      selectedEmploymentChips.remove(option);
      if (option == "Locum") {
        showLocumDate = false;
        locumDateController.clear();
        selectedLocumDates.clear();
      }
    } else {
      selectedEmploymentChips.add(option);
      if (option == "Locum") {
        showLocumDate = true;
      }
    }
    notifyListeners();
  }

  void toggleProfession(String profession) {
    if (selectedProfessions.contains(profession)) {
      selectedProfessions.remove(profession);
    } else {
      selectedProfessions.add(profession);
    }
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

  // ------------------ Locum Multi-Date Picker ------------------

  bool showMultiCalendar = false;
  List<DateTime> selectedLocumDatesObjects = [];

  void toggleCalendarVisibility() {
    showMultiCalendar = !showMultiCalendar;
    notifyListeners();
  }

  void toggleLocumDate(DateTime date) {
    if (selectedLocumDatesObjects.any((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day)) {
      selectedLocumDatesObjects.removeWhere((d) =>
          d.year == date.year && d.month == date.month && d.day == date.day);
    } else {
      selectedLocumDatesObjects.add(date);
    }

    selectedLocumDates = selectedLocumDatesObjects
        .map((d) => DateFormat('d/M/yyyy').format(d))
        .toList();

    locumDateController.text = selectedLocumDates.join(" | ");
    notifyListeners();
  }

  void removeLocumDate(DateTime date) {
    selectedLocumDatesObjects.removeWhere((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);

    selectedLocumDates = selectedLocumDatesObjects
        .map((d) => DateFormat('d/M/yyyy').format(d))
        .toList();

    locumDateController.text = selectedLocumDates.join(" | ");
    notifyListeners();
  }

  void updateLocumDateControllerText() {
    locumDateController.text = selectedLocumDates.join(" | ");
    notifyListeners();
  }

  // ------------------ Filter Apply Logic ------------------

  void collectSelectedFilterIds() {
    selectedProfessions.clear();
    selectedEmploymentChips.clear();
    selectedExperience.clear();

    selectedIndices.forEach((section, indices) {
      final items = filterOptions[section];
      if (items != null) {
        for (final i in indices) {
          if (i < items.length) {
            final id = items[i].id;
            if (section == 'profession') {
              selectedProfessions.add(id);
            } else if (section == 'employment') {
              selectedEmploymentChips.add(id);
            } else if (section == 'experience') {
              selectedExperience.add(id);
            }
          }
        }
      }
    });
  }

  Future<void> applyFilters() async {
    collectSelectedFilterIds();

    isLoading = true;
    notifyListeners();

    final result = await repo.fetchFilteredJobs(
      selectedProfessions,
      selectedEmploymentChips,
      selectedExperience,
      selectedLocumDates,
      null,
    );

    filteredJobs = result;
    isLoading = false;
    notifyListeners();
  }

  void clearSelections() {
    selectedIndices.updateAll((key, value) => {});
    selectedProfessions.clear();
    selectedEmploymentChips.clear();
    selectedExperience.clear();
    selectedSort = null;
    selectedLocumDates.clear();
    selectedLocumDatesObjects.clear();
    showLocumDate = false;
    locationController.clear();
    locumDateController.clear();
    notifyListeners();
  }

  void printSelectedItems() {
    debugPrint("Selected Filters:");
    selectedIndices.forEach((section, indices) {
      final items = filterOptions[section];
      if (items != null) {
        final selected = indices.map((i) => items[i].name).toList();
        debugPrint("$section: $selected");
      }
    });
    debugPrint("Locum Dates: $selectedLocumDates");
  }
}

// Safe Filter Item model
class FilterItem {
  final String name;
  final String id;

  FilterItem({required this.name, required this.id});
}
