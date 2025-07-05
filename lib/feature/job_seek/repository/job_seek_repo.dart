import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/model/send_message_request.dart';

abstract class JobSeekRepository {
  Future<JobdList> getPopularJobs();
  Future<Map<String, dynamic>> applyJob(ApplyJobRequest request);
  Future<Map<String, dynamic>> enquire(EnquireRequest request);
  Future<Map<String, dynamic>> hireMe(HireMeRequest request);
  Future<Map<String, dynamic>> uploadTheResume(String filePath);
  Future<Map<String, dynamic>> sendMessageRequest(SendMessageRequest jobId);
  Future<Map<String, dynamic>> getJobApplyStatus(
      String jobId, String dentalProfessionalId);
}