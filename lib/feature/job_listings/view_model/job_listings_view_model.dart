import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/repository/job_listing_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class JobListingsViewModel extends ChangeNotifier {
  final JobListingRepoImpl repo = JobListingRepoImpl();

  JobListingsViewModel() {
    fetchJobStatusCounts();
  }
  final Map<String, bool> _jobActiveStatus = {};
  String selectedStatus = 'All';
   String selectedstatusesforapplicatnts = 'All';

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
    'Interviews',
    
  ];

  int? allJobTalentCount = 0;
  int? draftTalentCount = 0;
  int? pendingApprovalCount = 0;
  int? activeCount = 0;
  int? inActiveCount = 0;
  int? expiredStatusCount = 0;
  int? rejectStatusCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': allJobTalentCount,
        'Draft': draftTalentCount,
        'Pending Approval': pendingApprovalCount,
        'Active': activeCount,
        'InActive': inActiveCount,
        'Expired': expiredStatusCount,
        'Reject': rejectStatusCount,
      };
  final Map<String,int> statusCountMapforapplicatnts =
  {
   'All':10,
    'Applied':2,
    'Shortlisted':2,
    'Interviews':5,
  };

  List<String>? listingStatus = [];
  String? suppliersId;
  String? practiceId;
  List<JobsListingDetails> myJobListingList = [];

  void  changeStatusforapplicatnts(String status,
  BuildContext context)
  {
  selectedstatusesforapplicatnts=status;
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
      listingStatus = ['EXPIRED'];
    } else if (status == 'Reject') {
      listingStatus = ['REJECTED'];
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
    // print(res);
    if (res != null) {
      myJobListingList = res;
      // Loaders.circularHideLoader(navigatorKey.currentContext!);
    } else {
      // Loaders.circularHideLoader(navigatorKey.currentContext!);
    }
    notifyListeners();
  }

  Future<void> fetchJobStatusCounts() async {
    final res = await repo.jobListingStatusCount();
    allJobTalentCount = ((res.all?.aggregate?.count ?? 0));
    pendingApprovalCount = res.pending?.aggregate?.count;
    draftTalentCount = res.draft?.aggregate?.count;
    inActiveCount = ((res.inactive?.aggregate?.count ?? 0) +
        (res.approved?.aggregate?.count ?? 0));
    expiredStatusCount = res.expired?.aggregate?.count;
    rejectStatusCount = res.rejected?.aggregate?.count;
    notifyListeners();
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
