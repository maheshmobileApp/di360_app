

import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_profession_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_worktype_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_request.dart';
import 'package:di360_flutter/feature/job_seek/model/aplly_job_applicants.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_profession_respon.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_response.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_worktype_respon.dart';
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
    return await _http.uploadImage(filePath);
  }

  @override
  Future<Map<String, dynamic>> sendMessageRequest(
      SendMessageRequest request) async {
    return await _http.mutation(
      sendMessageMutation,
      {'object': request.toJson()},
    );
  }

  @override
  Future<JobApplicantsResponse> getJobApplyStatus(
      String jobId, String dentalProfessionalId) async {
    final jobApplyStatus = await _http.query(
      jobApplyStatusQuery,
      variables: {
        'job_id': jobId,
        'dental_professional_id': dentalProfessionalId,
      },
    );
    return JobApplicantsResponse.fromJson(jobApplyStatus);
  }

  // ✅ Fetch Job Role List (Professions)
  @override
  Future<List<JobSeekFilterProfessionRespon>> getJobFilterProfessions() async {
    final data = await _http.query(getAllJobsRoleListQuery);
    final result = JobSeekFilterProfessionListResponse.fromJson(data);
    return result.jobsRoleList;
  }

  // ✅ Fetch Work Types List (Employment Types)
  @override
  Future<List<JobSeekFilterWorktypeRespon>> getJobFilterWorktypes() async {
    final data = await _http.query(getAllEmployeeTypeListQuery);
    final result = JobSeekFilterWorktypeListResponse.fromJson(data);
    return result.jobTypes;
  }

  // ✅ Fetch Filtered Jobs List (Job Results)
  @override
  Future<List<JobSeekFilterResponse>> getFilteredJobs(Map<String, dynamic> variables) async {
    final data = await _http.query(
      getAllJobsFilterQuery,
      variables: variables,
    );
    final result = GetJobSeekFilterRes.fromJson(data);
    return result.data?.jobs ?? [];
  }
}

