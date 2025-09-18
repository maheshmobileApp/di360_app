

import 'package:di360_flutter/core/http_service.dart';
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
  
 
}
