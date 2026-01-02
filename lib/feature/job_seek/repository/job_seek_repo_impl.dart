import 'dart:convert';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_request.dart';
import 'package:di360_flutter/feature/job_seek/model/aplly_job_applicants.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_profession_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_worktype_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo.dart';
import 'package:flutter/services.dart';

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
  Future<List<JobsRoleList>> getJobRoles() async {
    try {
      final response = await rootBundle.loadString('assets/getprofession.json');
      final data = json.decode(response);
      final model = JobSeekFilterProfessionModel.fromJson(data);
      return model.data?.jobsRoleList ?? [];
    } catch (e) {
      throw Exception('Failed to load job roles from local asset: $e');
    }
  }

  @override
  Future<List<JobTypes>> getJobWorkTypes() async {
    try {
      final response = await rootBundle.loadString('assets/getworktype.json');
      final data = json.decode(response);
      final model = JobSeekFilterWorktypeModel.fromJson(data);
      return model.data?.jobTypes ?? [];
    } catch (e) {
      throw Exception('Failed to load work types from local asset: $e');
    }
  }

  @override
  Future<List<Jobs>> fetchFilteredJobs(dynamic variables) async {
    try {
      print("*******************Filter Variables: $variables");
      final result =
          await _http.query(getAllJobsFilterQuery, variables: variables);
      final jobsJson = result['jobs'] as List<dynamic>? ?? [];
      print("{jobs: $jobsJson}");
      print("Fetched ${jobsJson.length} filtered jobs");
      final response = jobsJson.map((e) => Jobs.fromJson(e)).toList();
      print("Filtered Jobs $response");
      return response;
    } catch (e) {
      print("Error in fetchFilteredJobs repo: $e");
      return [];
    }
  }
}
 /*final List<Map<String, dynamic>> andConditions = [];
      if (professions != null && professions.isNotEmpty) {
        andConditions.add({
          "j_role": {"_in": professions}
        });
      }
      if (employmentTypes != null && employmentTypes.isNotEmpty) {
        andConditions.add({
          "TypeofEmployment": {"_overlap": employmentTypes}
        });
      }
      if (experiences != null && experiences.isNotEmpty) {
        andConditions.add({
          "years_of_experience": {"_in": experiences}
        });
      }
      if (availability != null && availability.isNotEmpty) {
        andConditions.add({
          "availability_date": {"_overlap": availability}
        });
      }
      andConditions.add({
        "status": {"_eq": "APPROVE"}
      });
      final variables = {
        "where": {
          "_and": andConditions,
        },
        "limit": 10,
        "offset": 0
      };*/