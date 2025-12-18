import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listing_applicants_messge_respo.dart';
import 'package:di360_flutter/feature/job_listings/repository/job_listing_repo_impl.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class JobListingsViewModel extends ChangeNotifier {
  final JobListingRepoImpl repo = JobListingRepoImpl();

  bool isLoading = false;
  String? errorMessage;
  final TextEditingController messageController = TextEditingController();
  final TextEditingController enquiryController = TextEditingController();
  final Map<String, bool> _jobActiveStatus = {};
  String selectedStatus = 'All';
  String selectedstatusesforapplicatnts = 'All';
  String? jobId;
  Jobs? jobDataById;
  bool editMessage = false;

  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Active',
    'InActive',
    'Expired',
    'Reject',
  ];

  final List<String> statusesforapplicatnts = [
    'All',
    'Applied',
    'Shortlisted',
    'Organize Interview',
    'Accepted',
    'Declined',
    'Enquiry'
  ];

  int? allJobTalentCount = 0;
  int? draftTalentCount = 0;
  int? pendingApprovalCount = 0;
  int? activeCount = 0;
  int? inActiveCount = 0;
  int? expiredStatusCount = 0;
  int? rejectStatusCount = 0;

  // Job Applicants Counts
  int? allJobapplicantCount = 0;
  int? appliedjobapplicnatsCount = 0;
  int? acceptedjobapplicnatsCount = 0;
  int? shortlistedjobapplicnatsCount = 0;
  int? interviewsjobapplicnatsCount = 0;
  int? rejectjobapplicnatsCount = 0;
  int? declinedjobapplicnatsCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': allJobTalentCount,
        'Draft': draftTalentCount,
        'Pending Approval': pendingApprovalCount,
        'Active': activeCount,
        'InActive': inActiveCount,
        'Expired': expiredStatusCount,
        'Reject': rejectStatusCount,
      };

  Map<String, int?> get statusCountMapforapplicatnts => {
        'All': allJobapplicantCount,
        'Applied': appliedjobapplicnatsCount,
        'Shortlisted': shortlistedjobapplicnatsCount,
        'Organize Interview': interviewsjobapplicnatsCount,
        'Accepted': acceptedjobapplicnatsCount,
        'Declined': declinedjobapplicnatsCount,
        'Enquiry': 0
      };

  List<String>? listingStatus = [];
  List<String> listingStatusforapplicants = [
    "APPLIED",
    "INTERVIEWS",
    "ACCEPTED",
    "REJECT",
    "SHORTLISTED",
    "DECLINED"
  ];
  List<JobApplicantMessage> messages = [];
  String? suppliersId;
  String? practiceId;
  List<Jobs> myJobListingList = [];
  List<JobApplicants> myApplicantsList = [];

  void changeStatusforapplicatnts(String status, BuildContext context) {
    selectedstatusesforapplicatnts = status;
    if (status == 'All') {
      listingStatusforapplicants = [
        "APPLIED",
        "INTERVIEWS",
        "ACCEPTED",
        "REJECT",
        "SHORTLISTED",
        "DECLINED"
      ];
    } else if (status == 'Applied') {
      listingStatusforapplicants = ['APPLIED'];
    } else if (status == 'Shortlisted') {
      listingStatusforapplicants = ['SHORTLISTED'];
    } else if (status == 'Interviews') {
      listingStatusforapplicants = ["INTERVIEWS"];
    } else if (status == 'Reject') {
      listingStatusforapplicants = ['REJECT'];
    } else if (status == 'Accepted') {
      listingStatusforapplicants = ['ACCEPTED'];
    } else if (status == 'Declined') {
      listingStatusforapplicants = ['DECLINED'];
    }
    getMyJobApplicantsgData(context, jobId ?? '');
    notifyListeners();
  }

  void changeStatus(String status, BuildContext context) async {
    Loaders.circularShowLoader(context);

    selectedStatus = status;
    if (status == 'All') {
      listingStatus = [
        "APPROVE",
        "PENDING",
        "INACTIVE",
        "EXPIRED",
        "REJECT",
        "DRAFT"
      ];
    } else if (status == 'Draft') {
      listingStatus = ['DRAFT'];
    } else if (status == 'Pending Approval') {
      listingStatus = ['PENDING'];
    } else if (status == 'Active') {
      listingStatus = ["APPROVE"];
    } else if (status == 'InActive') {
      listingStatus = ['INACTIVE'];
    } else if (status == 'Expired') {
      listingStatus = ['EXPIRED'];
    } else if (status == 'Reject') {
      listingStatus = ['REJECT'];
    }

    await getMyJobListingData(context);
    Loaders.circularHideLoader(context);

    notifyListeners();
    //INACTIVE
  }

  void updateSelectedStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }

  bool isJobActive(String? jobId) {
    if (jobId == null) return true;
    return _jobActiveStatus[jobId] ?? true;
  }

  void toggleJobStatus(String? jobId) {
    if (jobId == null) return;
    final currentStatus = _jobActiveStatus[jobId] ?? true;
    _jobActiveStatus[jobId] = !currentStatus;
    notifyListeners();
  }

  void setEditMessage(bool value) {
    editMessage = value;
    notifyListeners();
  }

  Future<void> getMyJobListingData(BuildContext context) async {
    await fetchJobStatusCounts();
    //Loaders.circularShowLoader(context);

    final res = await repo.getMyJobListing(listingStatus);
    if (res != null) {
      myJobListingList = res;
      //Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getMyJobApplicantsgData(
      BuildContext context, String jobId) async {
    await fetchJobApplicantsCount(jobId);
    //Loaders.circularShowLoader(context);
    final res = await repo.getJobApplicants(listingStatusforapplicants, jobId);
    if (res != null) {
      myApplicantsList = res;
      //Loaders.circularHideLoader(context);
    } else {
      //Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> fetchJobStatusCounts() async {
    final res = await repo.jobListingStatusCount();
    allJobTalentCount = res.all?.aggregate?.count ?? 0;
    pendingApprovalCount = res.pending?.aggregate?.count ?? 0;
    draftTalentCount = res.draft?.aggregate?.count ?? 0;
    inActiveCount = res.inactive?.aggregate?.count ?? 0;
    activeCount = res.approved?.aggregate?.count ?? 0;
    expiredStatusCount = res.expired?.aggregate?.count ?? 0;
    rejectStatusCount = res.rejected?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> getEditJobIDData(BuildContext context, String jobId) async {
    final res = await repo.getEditJobIDData(jobId);
    jobDataById = res;
    notifyListeners();
  }

  Future<void> fetchJobApplicantsCount(String jobId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await repo.getJobApplicantsCount(jobId);

      final applied = result?.applied?.aggregate?.count ?? 0;
      final accepted = result?.accepted?.aggregate?.count ?? 0;
      final shortlisted = result?.shortlisted?.aggregate?.count ?? 0;
      final interviews = result?.interviews?.aggregate?.count ?? 0;
      final rejected = result?.rejected?.aggregate?.count ?? 0;
      final declined = result?.declined?.aggregate?.count ?? 0;

      allJobapplicantCount =
          applied + accepted + shortlisted + interviews + rejected + declined;
      appliedjobapplicnatsCount = applied;
      acceptedjobapplicnatsCount = accepted;
      shortlistedjobapplicnatsCount = shortlisted;
      interviewsjobapplicnatsCount = interviews;
      rejectjobapplicnatsCount = rejected;
      declinedjobapplicnatsCount = declined;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeJobsListingData(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.removeJobListing(id);
    if (res != null) {
      await getMyJobListingData(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Job is removed successfully');
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateJobListingStatus(
      BuildContext context, String? id, String status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.updateJobListing(id, status);
    if (res != null) {
      await getMyJobListingData(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('JobListingData update successfully');
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateJobApplicantStatus(
      BuildContext context, String? id, String status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.updateJobAggrateStatus({"id": id, "status": status});
    if (id == null || id.isEmpty) {
      scaffoldMessenger("Invalid id: $id");
      Loaders.circularHideLoader(context);
      return;
    }
    print(res);
    if (res != null) {
      String message;
      switch (status.toUpperCase()) {
        case 'ACCEPTED':
          message = 'Applicant accepted successfully';
          break;
        case 'REJECTED':
          message = 'Applicant rejected successfully';
          break;
        case 'SHORTLISTED':
          message = 'Applicant shortlisted successfully';
          break;
        case 'INTERVIEWS':
          message = 'Interview organized successfully';
          break;
        default:
          message = 'Applicant status updated successfully';
      }
      scaffoldMessenger(message);
      Loaders.circularHideLoader(context);

      getMyJobApplicantsgData(context, jobId ?? '');
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> fetchApplicantMessages(String jobId) async {
    try {
      isLoading = true;

      final res = await repo.fetchApplicantMessages(jobId);
      if (res.messages != null) {
        messages = res.messages!;
        print("******************messages fetched ${messages}");
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteapplicantMessage(BuildContext context, String Id,
      String applicantId, bool deletedStatus) async {
        print("******************deleteapplicantMessage called");
    try {
      isLoading = true;

      final res = await repo.deleteApplicantMessage(Id, deletedStatus);
      print("res $res");
      await fetchApplicantMessages(applicantId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String newmessage = "";
  String editMessageId = "";

  void setEditMessageDetails(String id, String message) {
    editMessageId = id;
    newmessage = message;
    notifyListeners();
  }

  Future<void> updateApplicantMessage(
      BuildContext context, String applicantId) async {
    try {
      isLoading = true;

      final res = await repo.updateApplicantMessage(
          editMessageId, messageController.text);
      if (res != null) {
        setEditMessage(false);
        await fetchApplicantMessages(applicantId);
        scaffoldMessenger("Message updated successfully");
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendApplicantMessage(
      BuildContext context, String applicantId, String message,
       String? typeName) async {
    if (message.isEmpty) {
      scaffoldMessenger("Message cannot be empty");
      return;
    }

    try {
      Loaders.circularShowLoader(context);
      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

      final res = await repo.sendApplicantMessage({
        "job_applicant_id": applicantId,
        "message": message,
        "message_from": userId,
      }, typeName ?? "");

      if (res != null) {
        scaffoldMessenger("Message sent successfully");
        messageController.clear();
        /*messages.add(
          JobApplicantMessage(
            id: res, // backend ID
            jobApplicantId: applicantId,
            message: message,
            messageFrom: "me", // mark current user
            createdAt: DateTime.now().toIso8601String(),
          ),
        );*/
        fetchApplicantMessages(applicantId);
      } else {
        scaffoldMessenger("Failed to send message");
      }
    } catch (e) {
      scaffoldMessenger("Error: $e");
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    enquiryController.dispose();

    super.dispose();
  }
}



/*

Job Status


active_status
status 
 */