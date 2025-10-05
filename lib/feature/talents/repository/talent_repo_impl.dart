import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_profile/quary/job_profile_role_quary.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/talents_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_model.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo.dart';
import '../../talents/model/job_profile.dart';


class TalentRepoImpl extends TalentRepository {
  final HttpService _http = HttpService();
  @override
  Future<List<JobProfile>> getTalentDetails() async {
    final jobsData = await _http.query(talentsRequest);
    final result = TalentsData.fromJson(jobsData);
    return result.jobProfiles;
  }
  @override
  Future<bool> hireMe(HireMeRequest request) async {
    await _http.mutation(
      hireMeMutation,
      {'hireobject': request.toJson()},
    );
    return true;
  }
  @override
  Future<bool> enquire(EnquiryRequest request) async {
    await _http.mutation(
      enquiryMutation,
      {'object': request.toJson()},
    ).then((value) => true);
    return true;
  }
  @override
  Future<List<JobProfile>> getJobProfileFilterData({
    required Map<String, dynamic> where,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final response = await _http.query(
        GetJobProfileFilterData,
        variables: {
          'where': where,
          'limit': limit,
          'offset': offset,
        },
      );
      final data = response['job_profiles'] as List<dynamic>;
      return data.map((e) => JobProfile.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching JobProfile filter data: $e");
      rethrow;
    }
  }
   @override
  Future<List<JobsRoleLists>> getJobProfiles() async {
    final response = await _http.query(getJobProfileRole);
    final roles = (response['jobs_role_list'] as List<dynamic>?)
            ?.map((e) => JobsRoleLists.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return roles;
  }
}
