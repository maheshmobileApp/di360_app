import 'package:di360_flutter/feature/job_seek/model/job_model.dart';

abstract class JobSeekRepository {
  Future<JobdList> getPopularJobs();
}