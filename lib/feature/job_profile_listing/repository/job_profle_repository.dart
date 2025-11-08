//import 'package:di360_flutter/feature/job_profile/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class JobProfileRepository {
  Future<List<JobProfiles>> getJobProfiles();
   Future<void>updateJobProfile(String? id, String status);
     Future<void> removeJobProfile({required String jobProfileId});
}