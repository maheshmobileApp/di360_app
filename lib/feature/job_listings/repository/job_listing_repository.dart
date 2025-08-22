import 'package:di360_flutter/feature/job_listings/model/get_job_applicants_count_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/model/job_status_count_model.dart';

abstract class JobListingRepository {
  Future<List<JobsListingDetails>?> getMyJobListing(
      List<String>? listingStatus);
  Future<void> removeJobListing(String? id);
  Future<void> updateJobListing(String? id, String status);
  Future<JobStatusCountData> jobListingStatusCount();
  Future<List< JobApplicants>?> getJobApplicants(
      List<String>? listingStatusforapplicants,String jobId );
  Future<GetJobApllicantsCountData?> getJobApplicantsCount(String jobId);

}
