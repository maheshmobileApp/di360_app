import 'package:di360_flutter/feature/job_listings/model/get_job_applicants_count_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listing_applicants_messge_respo.dart';
//import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/model/job_status_count_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';

abstract class JobListingRepository {
  Future<List<Jobs>?> getMyJobListing(List<String>? listingStatus);
  Future<void> removeJobListing(String? id);
  Future<void> updateJobListing(String? id, String status);
  Future<JobStatusCountData> jobListingStatusCount();
  Future<List<JobApplicants>?> getJobApplicants(
      List<String>? listingStatusforapplicants, String jobId);
  Future<GetJobApllicantsCountData?> getJobApplicantsCount(String jobId);
  Future<void> updateJobAggrateStatus(dynamic variables);
  Future<JobListingApplicantsMessageResponse> fetchApplicantMessages(
      String jobId);
  Future<String?> sendApplicantMessage(Map<String, dynamic> variables,String typeName);
  Future<Jobs> getEditJobIDData(String jobId);
  Future<dynamic> deleteApplicantMessage(String Id, bool deleteStatus);
  Future<dynamic> updateApplicantMessage(String Id, String message);
}
