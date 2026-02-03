import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_profile/model/update_job_profile_res.dart';


abstract class CreateJobProfileRepository {
  Future<dynamic> createJobProfileListing(dynamic variables);
  Future<UpdateJobProfileData> updateJobProfileListing(dynamic variables);
  Future<List<JobsRoleLists>> getJobProfiles();
  
}

