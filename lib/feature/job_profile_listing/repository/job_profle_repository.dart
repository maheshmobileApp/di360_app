import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class JobProfileRepository {
  Future<List<JobProfiles>> getJobProfiles();
  Future<void> updateJobProfile(String? id, String status);
  Future<void> removeJobProfile({required String jobProfileId});
  Future<JobProfileEnquiriesResList> getMyEnquiryJobData(String jobProfileId);
  Future<void> getJobProfileEnquiry(String profileId, String enquiryId);
}
