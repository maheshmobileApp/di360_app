

import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/talents_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_model.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo.dart';


class TalentRepoImpl extends TalentRepository {
  final HttpService _http = HttpService();
  @override
  Future<List<JobProfile>> getTalentDetails() async {
    final jobsData = await _http.query(talentsRequest);
    final result = TalentsData.fromJson(jobsData);
    return result.jobProfiles;
  }
}
