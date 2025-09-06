import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_listing_respo.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profile_listing_respo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class JobProfileListingViewModel extends ChangeNotifier {
  final JobProfileListingRepoImpl repo = JobProfileListingRepoImpl();

  final List<String> statuses = [
    'DRAFT',
    'PENDING',
    'ACTIVE',
    'INACTIVE',
    'REJECTED',
  ];

  final Map<String, String> statusDisplayNames = {
    'DRAFT': 'Draft',
    'PENDING': 'Pending Approval',
    'ACTIVE': 'Active',
    'INACTIVE': 'Inactive',
    'REJECTED': 'Rejected',
  };

  String? selectedStatus;
  List<JobProfileListing> allJobProfiles = [];
  bool isLoading = false;

  Future<void> fetchJobProfiles(String dentalProfessionalId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repo.getJobProfiles(dentalProfessionalId);
      allJobProfiles = response ?? [];
      if (allJobProfiles.isNotEmpty) {
        selectedStatus = allJobProfiles.first.adminStatus?.toUpperCase() ?? 'DRAFT';
      }
    } catch (e) {
      allJobProfiles = [];
      selectedStatus = null;
    }

    isLoading = false;
    notifyListeners();
  }

  void changeStatus(String status) {
    selectedStatus = status.toUpperCase();
    notifyListeners();
  }

  List<JobProfileListing> get filteredProfiles {
    if (selectedStatus == null) return allJobProfiles;

    return allJobProfiles
        .where((job) =>
            (job.adminStatus ?? '').toUpperCase() == selectedStatus)
        .toList();
  }

  String displayName(String status) {
    return statusDisplayNames[status.toUpperCase()] ?? status;

  }
}

