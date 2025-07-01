import 'package:di360_flutter/feature/job_seek/model/apply_job_request.dart';
import 'package:di360_flutter/feature/job_seek/model/enquire_request.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';

abstract class JobSeekRepository {
  Future<JobdList> getPopularJobs();
  Future<Map<String, dynamic>> applyJob(ApplyJobRequest request);
  Future<Map<String, dynamic>> enquire(EnquireRequest request);
  Future<Map<String, dynamic>> hireMe(HireMeRequest request);

}