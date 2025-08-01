import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/model/job_status_count_model.dart';

abstract class JobListingRepository {
  Future<List<JobsListingDetails>?> getMyJobListing(
      List<String>? listingStatus);
  Future<void> removeJobListing(String? id);
  Future<void> updateJobListing(String? id, String status);
  Future<JobStatusCountData> jobListingStatusCount();
}
