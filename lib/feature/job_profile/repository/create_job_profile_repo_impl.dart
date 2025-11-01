import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_profile/quary/job_profile_quary.dart';
import 'package:di360_flutter/feature/job_profile/quary/job_profile_role_quary.dart';
import 'package:di360_flutter/feature/job_profile/repository/create_job_profile_repository.dart';

class CreateJobProfileRepoImpl extends CreateJobProfileRepository {
  final HttpService http = HttpService();

  @override
  Future<dynamic> createJobProfileListing(dynamic variables) async {
    final res = await http.mutation(addJobProfileQuery, variables);
    print("varibles: $variables");
    return res;
  }

  @override
  Future<List<JobsRoleLists>> getJobProfiles() async {
    final response = await http.query(getJobProfileRole);
    final roles = (response['jobs_role_list'] as List<dynamic>?)
            ?.map((e) => JobsRoleLists.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return roles;
  }
}
