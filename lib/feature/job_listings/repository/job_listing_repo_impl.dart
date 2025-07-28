import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/quary/get_job_listing_quary.dart';
import 'package:di360_flutter/feature/job_listings/repository/job_listing_repository.dart';

class JobListingRepoImpl extends JobListingRepository {
  final HttpService http = HttpService();

  @override
  Future<List<JobsListingDetails>?> getMyJobListing(variables) async {
    final listingData =
        await http.query(getJobListingQuary, variables: variables);
    final result = JobListing.fromJson(listingData);
    return result.jobs ?? [];
  }
}
