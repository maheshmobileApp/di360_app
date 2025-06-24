

import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo.dart';


class JobSeekRepoImpl extends JobSeekRepository {
  List<Jobs> jobList = [];
  final HttpService _http = HttpService();

  @override
  Future<JobdList> getPopularJobs() async {
    final jobsData = await _http.query(job_list_request);
    return JobdList.fromJson(jobsData);
  }
}
