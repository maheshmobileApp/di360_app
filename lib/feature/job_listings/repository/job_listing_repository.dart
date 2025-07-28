import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';

abstract class JobListingRepository {
   Future<List<JobsListingDetails>?> getMyJobListing(dynamic variables);
}