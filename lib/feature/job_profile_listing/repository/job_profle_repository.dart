import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_respo.dart';

abstract class JobProfileRepository {
  Future<List<JobProfileListing>> getJobProfiles(String dentalProfessionalId);
}