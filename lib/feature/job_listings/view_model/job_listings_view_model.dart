import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/repository/job_listing_repo_impl.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class JobListingsViewModel extends ChangeNotifier {
  final JobListingRepoImpl repo = JobListingRepoImpl();

  final Map<String, bool> _jobActiveStatus = {};
  String selectedStatus = 'All';
  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Active',
    'InActive',
    'Expired',
    'Reject',
  ];

  // Map<String, int?> get statusCountMap {
  //   return {
  //     'All':  _countJobsByStatus('All'),
  //     'Draft': _countJobsByStatus('Draft'),
  //     'Pending Approval': _countJobsByStatus('Pending Approval'),
  //     'Active': _countJobsByStatus('Active'),
  //     'InActive': _countJobsByStatus('InActive'),
  //     'Expired': _countJobsByStatus('Expired'),
  //     'Reject': _countJobsByStatus('Reject'),
  //   };
  // }

  List<String>? listingStatus = [];

  List<JobsListingDetails> myJobListingList = [];
  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'All') {
      listingStatus = [
        "DRAFT",
        "PENDING_APPROVAL",
        "ACTIVE",
        "INACTIVE",
        "EXPIRED",
        "REJECTED"
      ];
    } else if (status == 'Draft') {
      listingStatus = ['DRAFT'];
    } else if (status == 'Pending Approval') {
      listingStatus = ['PENDING_APPROVAL'];
    } else if (status == 'Active') {
      listingStatus = ["ACTIVE"];
    } else if (status == 'InActive') {
      listingStatus = ['INACTIVE'];
    } else if (status == 'Expired') {
      listingStatus = ['EXPIRED'];
    } else if (status == 'Reject') {
      listingStatus = ['REJECTED'];
    }
    getMyJobListingData(context);
    notifyListeners();
  }

  // int _countJobsByStatus(String status) {
  //   return allJobs
  //       .where((job) => job.activeStatus?.toLowerCase() == status.toLowerCase())
  //       .length;
  // }

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

  // void previewJob(BuildContext context, String? jobId) =>
  //     debugPrint("Preview job: $jobId");
  // void editJob(BuildContext context, String? jobId) =>
  //     debugPrint("Edit job: $jobId");
  // void deleteJob(BuildContext context, String? jobId) =>
  //     debugPrint("Delete job: $jobId");

  Future<void> getMyJobListingData(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getMyJobListing({
      "limit": 10,
      "offset": 0,
      "status": listingStatus?.isEmpty == true
          ? [
              "DRAFT",
              "PENDING_APPROVAL",
              "ACTIVE",
              "INACTIVE",
              "EXPIRED",
              "REJECTED"
            ]
          : listingStatus,
    });
    print(res);
    print("ffffffff${res}");
    if (res != null) {
      myJobListingList = res;

      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
