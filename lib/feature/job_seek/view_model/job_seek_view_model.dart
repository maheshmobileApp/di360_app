import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/attachment.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';
import 'package:di360_flutter/feature/job_seek/model/upload_response.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo.dart';

import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo_impl.dart';
import 'package:di360_flutter/utils/generated_id.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class JobSeekViewModel extends ChangeNotifier {
  final JobSeekRepository repo = JobSeekRepoImpl(); // 👈 Create repo here
  String? _enquiryData;
  Jobs? selectedJob;
  bool isJobApplied = false;
  List<Jobs> jobs = [];
  JobSeekViewModel() {
    fetchJobs();
  }
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  bool isHidleFolatingButton = false;
  void toggleFloatingButtonVisibility() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userRole = UserRole.fromString(type);
    switch (userRole) {
      case UserRole.professional:
        // professional will only see JOb ( cant see talents) no floating
        isHidleFolatingButton = true; // Dental Professional
        break;
      case UserRole.supplier:
        isHidleFolatingButton = false; // Dental Business Owner
        break;
      case UserRole.practice:
        isHidleFolatingButton = false; // Dental Practice Owner
        break;
      default:
        isHidleFolatingButton = true; //
    }
    //Dental Professional
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
    } catch (e) {
      return false;
    }

  }

  void setSelectedJob(Jobs job) {
    selectedJob = job;
  }

  Future<bool> applyJob(ApplyJobRequest applyJobRequest) async {
    ApplyJobRequest payload = applyJobRequest;
    payload.jobId = selectedJob?.id ?? '';
    final generatedID = GeneratedId.generateId();
    payload.id = generatedID;
    final uploadImage = await repo.uploadTheResume(payload.attachments.url);
    final response = UploadResponse.fromJson(uploadImage);
    Attachment attachment = Attachment(
      url: response.url,
      name: response.name,
      type: response.mimeType,
    );
    payload.attachments = attachment;
    try {
      await repo.applyJob(payload);
      sendMessage(applyJobRequest.message, generatedID);
      return true;
    } catch (e) {
      return false;
    }
  }

  void sendMessage(String message, String applicationId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final payload = SendMessageRequest(
        jobApplicantId: applicationId, message: message, messageFrom: userId);
    await repo.sendMessageRequest(payload);
  }

  void getApplyJobStatus(String jobId, String dentalProfessionalId) async {
    try {
      final result = await repo.getJobApplyStatus(jobId, dentalProfessionalId);
      if (result.jobApplicants.isNotEmpty) {
        final myApplicationStatus = result.jobApplicants.where((applicant) {
          return applicant.dentalProfessionalId == dentalProfessionalId;
        }).toList();
        if (myApplicationStatus.isNotEmpty) {
          isJobApplied = true;
          notifyListeners();
        } else {
          isJobApplied = false;
          notifyListeners();
        }
        // Handle the result as needed
      }
    } catch (e) {
      // Handle error
      print("Error fetching job apply status: $e");
    }
  }
}
