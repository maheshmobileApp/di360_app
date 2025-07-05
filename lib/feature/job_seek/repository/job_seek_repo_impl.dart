

import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_request.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo.dart';


class JobSeekRepoImpl extends JobSeekRepository {
  final HttpService _http = HttpService();

  @override
  Future<JobdList> getPopularJobs() async {
    final jobsData = await _http.query(job_list_request);
    return JobdList.fromJson(jobsData);
  }

  @override
  Future<Map<String, dynamic>> applyJob(ApplyJobRequest request) {
    return _http.mutation(
      applyJobMutation,
      {'applyJobobject': request.toJson()},
    );
  }

  @override
  Future<Map<String, dynamic>> enquire(EnquireRequest request) {
    return _http.mutation(
      enquiryMutation,
      {'object': request.toJson()},
    );
  }

  @override
  Future<Map<String, dynamic>> hireMe(HireMeRequest request) {
    return _http.mutation(
      hireMeMutation,
      {'object': request.toJson()},
    );
  }
  
  @override
  Future<Map<String, dynamic>> uploadTheResume(String filePath) async {
    var value = await _http.uploadImage(filePath);
    return value;
  }

  @override
  Future<Map<String, dynamic>> sendMessageRequest(SendMessageRequest request) {
    return _http.mutation(
      sendMessageMutation,
      {'object': request.toJson()},
    );
  }

  
}
