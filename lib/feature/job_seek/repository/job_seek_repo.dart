import 'package:di360_flutter/feature/job_seek/model/aplly_job_applicants.dart';
import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_profession_respon.dart';
import 'package:di360_flutter/feature/job_seek/model/job_seek_filter_worktype_respon.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';

abstract class JobSeekRepository {
    
  Future<JobdList> getPopularJobs();
  Future<Map<String, dynamic>> applyJob(ApplyJobRequest request);
  Future<Map<String, dynamic>> enquire(EnquireRequest request);
  Future<Map<String, dynamic>> hireMe(HireMeRequest request);
  Future<Map<String, dynamic>> uploadTheResume(String filePath);
  Future<Map<String, dynamic>> sendMessageRequest(SendMessageRequest request);
  Future<JobApplicantsResponse> getJobApplyStatus(String jobId, String dentalProfessionalId);
  Future<List<JobSeekFilterProfessionRespon>> getJobFilterProfessions();
  Future<List<JobsRoleList>> getJobFilterWorktypes();
  
}
