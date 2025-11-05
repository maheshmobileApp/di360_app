import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';


abstract class CreateJobProfileRepository {
  Future<dynamic> createJobProfileListing(dynamic variables);
  Future<dynamic> updateJobProfileListing(dynamic variables);
  Future<List<JobsRoleLists>> getJobProfiles();
  
}

