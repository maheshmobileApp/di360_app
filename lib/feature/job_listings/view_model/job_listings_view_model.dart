import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:flutter/material.dart';

class JobListingsViewModel extends ChangeNotifier {
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
  List<Jobs> allJobs = [];
  void setJobs(List<Jobs> jobs) {
    allJobs = jobs;
    notifyListeners();
  }
  List<Jobs> get filteredJobs {
    if (selectedStatus == 'All') return allJobs;
    return allJobs
        .where((job) =>
            job.activeStatus?.toLowerCase() == selectedStatus.toLowerCase())
        .toList();
  }
  Map<String, int?> get statusCountMap {
    return {
      'All': allJobs.length,
      'Draft': _countJobsByStatus('Draft'),
      'Pending Approval': _countJobsByStatus('Pending Approval'),
      'Active': _countJobsByStatus('Active'),
      'InActive': _countJobsByStatus('InActive'),
      'Expired': _countJobsByStatus('Expired'),
      'Reject': _countJobsByStatus('Reject'),
    };
  }

  int _countJobsByStatus(String status) {
    return allJobs
        .where((job) =>
            job.activeStatus?.toLowerCase() == status.toLowerCase())
        .length;
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
  void previewJob(BuildContext context, String? jobId) =>
      debugPrint("Preview job: $jobId");
  void editJob(BuildContext context, String? jobId) =>
      debugPrint("Edit job: $jobId");
  void deleteJob(BuildContext context, String? jobId) =>
      debugPrint("Delete job: $jobId");
}
