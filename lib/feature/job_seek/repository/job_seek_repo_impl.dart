import 'dart:convert';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_filter_request.dart';
import 'package:di360_flutter/feature/job_seek/job_seek_request.dart';
import 'package:di360_flutter/feature/job_seek/model/aplly_job_applicants.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_profession_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_worktype_model.dart';
import 'package:di360_flutter/feature/job_seek/model/jobseekfilter_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo.dart';
import 'package:flutter/services.dart';


class JobSeekRepoImpl extends JobSeekRepository {
  final HttpService _http = HttpService();

  @override
  Future<JobdList> getPopularJobs() async {
    final jobsData =
        await _http.query(job_list_request);
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
Future<List<JobSeekFilterModel>> fetchFilteredJobs(
  List<String>? roles,
  List<String>? employmentTypes,
  List<String>? experienceYears,
  List<String>? availabilityDates,
) async {
  final andList = <Map<String, dynamic>>[];


  if (roles != null && roles.isNotEmpty) {
    andList.add({
      "j_role": {"_in": roles},
    });
  }

  if (employmentTypes != null && employmentTypes.isNotEmpty) {
    andList.add({
      "TypeofEmployment": {"_has_keys_any": employmentTypes},
    });
  }

  if (experienceYears != null && experienceYears.isNotEmpty) {
    andList.add({
      "years_of_experience": {"_in": experienceYears},
    });
  }

  if (availabilityDates != null && availabilityDates.isNotEmpty) {
    andList.add({
      "availability_date": {"_has_keys_any": availabilityDates},
    });
  }

  final variables = {
    "where": {
      "_and": andList,
    }
  };


  final result = await _http.query(
    getAllJobsFilterQuery,
    variables: variables,
  );

  final jobsList = result['jobs'] as List<dynamic>?;

  if (jobsList == null) return [];

  return jobsList.map((e) => JobSeekFilterModel.fromJson(e)).toList();
}


}