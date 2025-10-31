import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_profile/quary/job_profile_role_quary.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/feature/talents/talents_request.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo.dart';
import '../../talents/model/job_profile.dart';

class TalentRepoImpl extends TalentRepository {
  final HttpService _http = HttpService();
  @override
  Future<List<JobProfiles>> getTalentDetails() async {
    final jobsData = await _http.query(talentsRequest);
    final result = TalentsResData.fromJson(jobsData);
    return result.jobProfiles ?? [];
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
  Future<List<JobProfiles>> getJobProfileFilterData(
    List<String>? professions,
    List<String>? employmentTypes,
    List<String>? experience, // changed from List<String> to String
    List<String>? availabilityDates,
    List<String>? availabilityDays,
  ) async {
    try {
      final Map<String, dynamic> whereConditions = {};

      /*if (professions != null && professions.isNotEmpty) {
        whereConditions["j_role"] = {"_in": professions};
      }*/

      if (employmentTypes != null && employmentTypes.isNotEmpty) {
        whereConditions["work_type"] = {"_contains": employmentTypes};
      }

      if (experience != null && experience.isNotEmpty) {
        whereConditions["Year_of_experiance"] = {"_eq": experience[0]};
      }

      if (availabilityDates != null && availabilityDates.isNotEmpty) {
        whereConditions["availabilityDate"] = {"_contains": availabilityDates};
      }

      if (availabilityDays != null && availabilityDays.isNotEmpty) {
        whereConditions["availabilityDay"] = {"_contains": availabilityDays};
      }

      final variables = {
        "where": whereConditions,
      };

      print("Filter Variables: $variables");

      final result =
          await _http.query(GetJobProfileFilterData, variables: variables);
      print("result is : $result");
      final response = TalentsResData.fromJson(result);
      final printResponse = response.jobProfiles ?? [];
      print("filtered list ${printResponse}}");

      return response.jobProfiles ?? [];
    } catch (e) {
      print("Error in fetchFilteredJobs repo: $e");
      return [];
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
