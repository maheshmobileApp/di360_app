import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_respo.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profile_respo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';

class JobProfileListingViewModel extends ChangeNotifier {
  final JobProfileRepoImpl repo = JobProfileRepoImpl();

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

  String? dentalProfessionalId; 

  Future<void> fetchJobProfiles() async {
    isLoading = true;
    notifyListeners();
    try {
      dentalProfessionalId ??=
          await LocalStorage.getStringVal(LocalStorageConst.userId);
      if (dentalProfessionalId == null || dentalProfessionalId!.isEmpty) {
        allJobProfiles = [];
        isLoading = false;
        notifyListeners();
        return;
      }
      final response = await repo.getJobProfiles(dentalProfessionalId!);
      allJobProfiles = response ?? [];
      if (allJobProfiles.isNotEmpty) {
        selectedStatus =
            allJobProfiles.first.adminStatus?.toUpperCase() ?? 'DRAFT';
      }
    } catch (e) {
      allJobProfiles = [];
      selectedStatus = null;
    }

    isLoading = false;
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

Future<void> updateJobProfileStatus(
    BuildContext context, String? id, String status) async {
  Loaders.circularShowLoader(context);
  final res = await repo.updateJobProfile(id, status);
  if (!context.mounted) return; 
  if (res != null) {
    scaffoldMessenger('JobListingData updated successfully');
    await fetchJobProfiles();
  } else {
    scaffoldMessenger('Failed to update JobListingData');
  }
  if (context.mounted) {
    Loaders.circularHideLoader(context);
  }
  notifyListeners();
}
}
