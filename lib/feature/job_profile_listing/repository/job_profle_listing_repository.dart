import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_listing_respo.dart';

abstract class JobProfileListingRepository {
  Future<List<JobProfileListing>> getJobProfiles(String dentalProfessionalId);
}