import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/attachment.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
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
  String? _enquiryData;
  Jobs? selectedJob;
  bool isJobApplied = false;
  List<Jobs> jobs = [];

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  bool isHidleFolatingButton = false;

  void toggleFloatingButtonVisibility() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userRole = UserRole.fromString(type);
    isHidleFolatingButton = userRole == UserRole.professional;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> fetchJobs() async {
    var jobData = await repo.getPopularJobs();
    jobs = jobData.jobs ?? [];
    notifyListeners();
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

  final TextEditingController locationController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController locumDateController = TextEditingController();

  Map<String, List<FilterOption>> filterOptions = {
    "Location": [FilterOption(name: "Hyderabad"), FilterOption(name: "Bangalore")],
    "Type": [FilterOption(name: "Full-time"), FilterOption(name: "Part-time")],
  };

  Map<String, List<int>> selectedIndices = {};
  Map<String, bool> sectionVisibility = {};

  void initializeFilters() {
    for (var key in filterOptions.keys) {
      selectedIndices[key] = [];
      sectionVisibility[key] = true;
    }
  }

  void toggleSection(String section) {
    sectionVisibility[section] = !(sectionVisibility[section] ?? true);
    notifyListeners();
  }

  void selectItem(String section, int index) {
    if (selectedIndices[section]?.contains(index) ?? false) {
      selectedIndices[section]?.remove(index);
    } else {
      selectedIndices[section]?.add(index);
    }
    notifyListeners();
  }

  void clearSelections() {
    for (var key in selectedIndices.keys) {
      selectedIndices[key]?.clear();
    }
    selectedEmploymentChips.clear();
    selectedProfessions.clear();
    selectedExperience = null;
    selectedSort = null;
    locationController.clear();
    searchController.clear();
    locumDateController.clear();
    showLocumDate = false;
    notifyListeners();
  }

  void printSelectedItems() {
    debugPrint("Selected Filters:");
    filterOptions.forEach((key, items) {
      final selected = selectedIndices[key]?.map((i) => items[i].name).toList();
      debugPrint("$key: $selected");
    });
    debugPrint("Employment Chips: $selectedEmploymentChips");
    debugPrint("Professions: $selectedProfessions");
    debugPrint("Experience: $selectedExperience");
    debugPrint("Sort: $selectedSort");
    debugPrint("Locum Date: ${locumDateController.text}");
  }

  bool showLocumDate = false;

  void toggleEmploymentFilter(String option) {
    if (selectedEmploymentChips.contains(option)) {
      selectedEmploymentChips.remove(option);
      if (option == "Locum") {
        showLocumDate = false;
        locumDateController.clear();
      }
    } else {
      selectedEmploymentChips.add(option);
      if (option == "Locum") {
        showLocumDate = true;
      }
    }
    notifyListeners();
  }

  List<String> employmentOptions = [];
  List<String> selectedEmploymentChips = [];
  List<String> professionOptions = [];
  List<String> selectedProfessions = [];
  List<String> experienceOptions = ["0", "1–2", "3–5", "5–10", "10–15", "15–20"];
  String? selectedExperience;

  List<String> sortOptions = ["A to Z", "Z to A"];
  String? selectedSort;

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
  void toggleProfession(String profession) {
    if (selectedProfessions.contains(profession)) {
      selectedProfessions.remove(profession);
    } else {
      selectedProfessions.add(profession);
    }
    notifyListeners();
  }

  void setExperience(String value) {
    selectedExperience = value;
    notifyListeners();
  }

  void setSort(String value) {
    selectedSort = value;
    notifyListeners();
  }

  void pickCustomDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      locumDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners();
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
}

class FilterOption {
  final String name;
  FilterOption({required this.name});
}
