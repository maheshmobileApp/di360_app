import 'package:di360_flutter/feature/job_seek/model/aplly_job_applicants.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_profession_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_worktype_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';

abstract class JobSeekRepository {
    
  Future<JobdList> getPopularJobs();
  Future<Map<String, dynamic>> applyJob(ApplyJobRequest request);
  Future<Map<String, dynamic>> enquire(EnquireRequest request);
  Future<Map<String, dynamic>> hireMe(HireMeRequest request);
  Future<Map<String, dynamic>> uploadTheResume(String filePath);
  Future<Map<String, dynamic>> sendMessageRequest(SendMessageRequest request);
  Future<JobApplicantsResponse> getJobApplyStatus(String jobId, String dentalProfessionalId);
  Future<List<JobsRoleList>> getJobRoles();
  Future<List<JobTypes>> getJobWorkTypes();
  Future<List<Jobs>> fetchFilteredJobs(
  List<String> professions,
  List<String> employmentTypes,
  List<String> experiences,
  List<String> availability,
  String? location
);


 //Future<List<JobSeekResponseModel>> fetchFilteredJobs(JobSeekFilterModel filter)
 
}
