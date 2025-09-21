//import 'package:di360_flutter/feature/job_profile/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';

abstract class JobProfileRepository {
  Future<List<JobProfile>> getJobProfiles();
   Future<void>updateJobProfile(String? id, String status);
     Future<void> removeJobProfile({required String jobProfileId});
}