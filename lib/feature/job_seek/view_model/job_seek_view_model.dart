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
  JobSeekViewModel() {
    fetchJobs();
  }
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  // void setSelectedIndex(int index) {
  //   if (_selectedTabIndex != index) {
  //     _selectedTabIndex = index;
  //     notifyListeners();
  //   }
  // }

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
  // Dummy Data

  List<Jobs> jobs = [];
  Future<void> fetchJobs() async {
    var jobData = await repo.getPopularJobs();
    jobs = jobData.jobs ?? [];
    notifyListeners();
  }

  void onChangeEnquireData(String data) {
    _enquiryData = data;
  }

  void jobEnquire(String jobId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    var enquireData = EnquireRequest(
      enquiryDescription: _enquiryData ?? '',
      jobId: jobId,
      enquiryUserId: userId,
    );
    final equire = await repo.enquire(enquireData);
    print(equire);
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
}

/*

flutter: {insert_job_applicants_one: {id: 09ae35b8-1437-46b3-a18c-3b3895e324e6, __typename: job_applicants}}


{status: success, 
extension: application/octet-stream,
 file_id: 8410c543-6f46-420c-b7a6-76e7805b8845,
  mime_type: application/octet-stream, 
  name: Text Widget.pptx.pdf,
   size: 812570,
    directory: project, 
    isPublic: true,
     url: https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/8410c543-6f46-420c-b7a6-76e7805b8845}
 */