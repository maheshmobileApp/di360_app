//import 'package:di360_flutter/feature/job_profile/model/job_profile.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profile_respo_impl.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

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
  List<JobProfiles> allJobProfiles = [];
  String? jobProfileId;
  bool editProfileEnable = false;

  bool isLoading = false;

  Future<void> fetchJobProfiles(BuildContext context) async {
    isLoading = true;
    final response = await repo.getJobProfiles();
    allJobProfiles = response ?? [];
    if (allJobProfiles.isNotEmpty) {
      setJobProfileId(allJobProfiles.first.id ?? "");
      getMyEnquiryJobData(context, id: allJobProfiles.first.id ?? "");
    }
    /*try {
      final response = await repo.getJobProfiles();
      allJobProfiles = response;
      setJobProfileId(response.first.id ?? "");

      if (allJobProfiles.isNotEmpty) {
        selectedStatus = allJobProfiles.first.adminStatus?.toUpperCase() ?? '';
      }
    } catch (e) {
      allJobProfiles = [];
      selectedStatus = null;
    }*/
    isLoading = false;
    notifyListeners();
  }

  void setJobProfileId(String value) {
    jobProfileId = value;
    notifyListeners();
  }

  void setEditProfileEnable(bool value) {
    editProfileEnable = value;
    notifyListeners();
  }

  /*List<JobProfile> get filteredProfiles {
    if (selectedStatus == null) return allJobProfiles;
    return allJobProfiles
        .where((job) => (job.adminStatus ?? '').toUpperCase() == selectedStatus)
        .toList();
  }*/

  String displayName(String status) {
    return statusDisplayNames[status.toUpperCase()] ?? status;
  }

  Future<void> updateJobProfileStatus(
      BuildContext context, String? id, String status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.updateJobProfile(id, status);
    if (!context.mounted) return;
    if (res != null) {
      scaffoldMessenger('Job is updated successfully');
      await fetchJobProfiles(context);
    } else {
      scaffoldMessenger('Failed to update JobListingData');
    }
    if (context.mounted) {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> removeJobsProfileData(BuildContext context,
      {required String jobProfileId}) async {
    Loaders.circularShowLoader(context);
    final res = await repo.removeJobProfile(jobProfileId: jobProfileId);
    if (res != null) {
      await fetchJobProfiles(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Profile is removed successfully');
    } else {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Failed to remove JobListingData');
    }

    notifyListeners();
  }

  JobProfileEnquiriesResList? myEnquiryJobData;
  JobProfileEnquiriesResList? jobPrilfeEnquiryData;

  Future<JobProfileEnquiriesResList?> getMyEnquiryJobData(BuildContext context,
      {required String id}) async {
    final res = await repo.getMyEnquiryJobData(id);
    if (res != null) {
      myEnquiryJobData = res;
    } else {}

    notifyListeners();
    return res;
  }

  Future<JobProfileEnquiriesResList?> getJobProfileEnquiry(
      BuildContext context, String profileId, String enquiryId) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getJobProfileEnquiry(profileId, enquiryId);
    if (res != null) {
      jobPrilfeEnquiryData = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }
}
