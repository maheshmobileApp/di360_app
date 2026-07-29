//import 'package:di360_flutter/feature/job_profile/model/job_profile.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/request_count_res.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profile_respo_impl.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_hiring_talent_list_res.dart';
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
  String? jobProfileStatus;
  String? requestType;

  void setRequestType(String val) {
    requestType = val;
    notifyListeners();
  }

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
    myEnquiryJobData = res;

    notifyListeners();
    return res;
  }

  Future<JobProfileEnquiriesResList?> getJobProfileEnquiry(
      BuildContext context, String profileId, String enquiryId) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getJobProfileEnquiry(profileId, enquiryId);
    jobPrilfeEnquiryData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
    return res;
  }

  Future updateTalentRequestStatus(BuildContext context, String id,
      String status, String professionalId) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id, "status": status};
    final res = await repo.updateTalentListing(variables);
    if (res != null) {
      scaffoldMessenger("Talent request status updated successfully");
      await getAllTalentsRequest(
          context, professionalId, status == "APPROVE" ? "REJECT" : "APPROVE");
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }

  HiringTalentList? hiringTalentList;

  Future<HiringTalentList> getAllTalentsRequest(
      BuildContext context, String professionalId, String status) async {
    final variables = {
      "where": {
        "dental_professional_id": {"_eq": professionalId},
        "hiring_status": {"_eq": status}
      },
      "limit": 20,
      "offset": 0
    };
    Loaders.circularShowLoader(context);
    final res = await repo.getAllTalentsRequest(variables);
    hiringTalentList = res;
    await getRequestCount(context);
    Loaders.circularHideLoader(context);
    notifyListeners();
    return res;
  }

  RequestCountData? requestCountData;

  Future<void> getRequestCount(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "where": {
        "dental_professional_id": {"_eq": userId}
      }
    };
    Loaders.circularShowLoader(context);
    final res = await repo.getRequestCount(variables);
    requestCountData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }
}
