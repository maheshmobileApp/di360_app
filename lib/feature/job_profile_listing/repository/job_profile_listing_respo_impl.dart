import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_listing_respo.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/job_profile_listing_quary.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profle_listing_repository.dart';



class JobProfileListingRepoImpl implements JobProfileListingRepository {
  final HttpService http = HttpService();
  @override
  Future<List<JobProfileListing>> getJobProfiles(String dentalProfessionalId) async {
      final response = await http.query(
        jobProfileListing,
        variables: {
          "dental_professional_id": dentalProfessionalId,
        },
      );
      final result = JobProfileListingResponse.fromJson(response);
      return result.jobProfiles ?? []; 
    
  }
}
