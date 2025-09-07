import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_respo.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/job_profile_quary.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profle_repository.dart';



class JobProfileRepoImpl implements JobProfileRepository {
  final HttpService http = HttpService();
  @override
  Future<List<JobProfileListing>> getJobProfiles(String dentalProfessionalId) async {
      final response = await http.query(
        jobProfileListing,
        variables: {
          "dental_professional_id": dentalProfessionalId,
        },
      );
      final result = JobProfileResponse.fromJson(response);
      return result.jobProfiles ?? []; 
    
  }
}
