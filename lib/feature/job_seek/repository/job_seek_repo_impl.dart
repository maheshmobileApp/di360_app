import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_profession_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_worktype_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_request.dart';
import 'package:di360_flutter/feature/job_seek/model/aplly_job_applicants.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_profession_respon.dart';
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

  @override
  Future<List<JobSeekFilterProfessionRespon>> getJobFilterProfessions() async {
    try {
      final data = await _http.query(getAllEmployeeTypeListQuery);
      final roleList = data['jobs_role_list'];

      if (roleList == null || roleList is! List) {
        throw Exception("jobs_role_list is null or not a list");
      }

      final result = JobSeekFilterProfessionListResponse.fromJson(data);
      return result.jobsRoleList;
    } catch (e, st) {
      print("Error fetching professions: $e");
      print(st);
      return [];
    }
  }

  @override
  Future<List<JobsRoleList>> getJobFilterWorktypes() async {
    try {
      final data = await _http.query(getAllJobsRoleListQuery);
      final result = JobRoleData.fromJson(data);
      return result.jobsRoleList ?? [];
    } catch (e, st) {
      print("Error fetching work types: $e");
      print(st);
      return [];
    }
  }
}
