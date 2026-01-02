import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class TalentRepository {
  Future<List<JobProfiles>> getTalentDetails();
  Future<bool> hireMe(HireMeRequest request);
  Future<bool> enquire(EnquiryRequest request);
  /*Future<List<JobProfile>> getJobProfileFilterData({
    required Map<String, dynamic> where,
    int limit = 10,
    int offset = 0,
  });*/
  Future<List<JobProfiles>> getJobProfileFilterData(
   dynamic variables
);
  Future<List<JobsRoleLists>> getJobProfiles();
}
