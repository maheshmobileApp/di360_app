import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/repository/job_listing_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class JobListingsViewModel extends ChangeNotifier {
  final JobListingRepoImpl repo = JobListingRepoImpl();

  bool isLoading = false;
  String? errorMessage;

  final Map<String, bool> _jobActiveStatus = {};
  String selectedStatus = 'All';
  String selectedstatusesforapplicatnts = 'All';
  String? jobId;

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
    'Accepted',
    'Shortlisted',
    'Interviews',
    'Reject',
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
        'Interviews': interviewsjobapplicnatsCount,
        'Reject': rejectjobapplicnatsCount,
        'Accepted': acceptedjobapplicnatsCount,
      };

  List<String>? listingStatus = [];
  List<String> listingStatusforapplicants = [];
  String? suppliersId;
  String? practiceId;
  List<JobsListingDetails> myJobListingList = [];
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
    }
    getMyJobApplicantsgData(context, jobId ?? '');
    notifyListeners();
  }

  void changeStatus(String status, BuildContext context) {
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
      listingStatus = ["ACTIVE"];
    } else if (status == 'InActive') {
      listingStatus = ['INACTIVE'];
    } else if (status == 'Expired') {
      listingStatus = ['ACCEPTED'];
    }
    getMyJobListingData();
    notifyListeners();
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

  Future<void> getMyJobListingData() async {
    final res = await repo.getMyJobListing(listingStatus);
    fetchJobStatusCounts();
    if (res != null) {
      myJobListingList = res;
    }
    notifyListeners();
  }

  Future<void> getMyJobApplicantsgData(
      BuildContext context, String jobId) async {
    await fetchJobApplicantsCount(jobId);
    Loaders.circularShowLoader(context);
    final res = await repo.getJobApplicants(listingStatusforapplicants, jobId);
    if (res != null) {
      myApplicantsList = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularShowLoader(context);
    }
    notifyListeners();
  }

  Future<void> fetchJobStatusCounts() async {
    final res = await repo.jobListingStatusCount();
    allJobTalentCount = res.all?.aggregate?.count ?? 0;
    pendingApprovalCount = res.pending?.aggregate?.count ?? 0;
    draftTalentCount = res.draft?.aggregate?.count ?? 0;
    inActiveCount = (res.inactive?.aggregate?.count ?? 0) +
        (res.approved?.aggregate?.count ?? 0);
    expiredStatusCount = res.expired?.aggregate?.count ?? 0;
    rejectStatusCount = res.rejected?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> fetchJobApplicantsCount(String jobId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result =
          await repo.getJobApplicantsCount(jobId);

      final applied = result?.applied?.aggregate?.count ?? 0;
      final accepted = result?.accepted?.aggregate?.count ?? 0;
      final shortlisted = result?.shortlisted?.aggregate?.count ?? 0;
      final interviews = result?.interviews?.aggregate?.count ?? 0;
      final rejected = result?.rejected?.aggregate?.count ?? 0;
      allJobapplicantCount =
          applied + accepted + shortlisted + interviews + rejected;
      appliedjobapplicnatsCount = applied;
      acceptedjobapplicnatsCount = accepted;
      shortlistedjobapplicnatsCount = shortlisted;
      interviewsjobapplicnatsCount = interviews;
      rejectjobapplicnatsCount = rejected;
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
      scaffoldMessenger('JobListingData removed successfully');
      Loaders.circularHideLoader(context);
      getMyJobListingData();
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
      scaffoldMessenger('JobListingData update successfully');
      Loaders.circularHideLoader(context);
      getMyJobListingData();
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
