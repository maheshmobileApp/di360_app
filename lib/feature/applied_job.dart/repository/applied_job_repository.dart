import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';

abstract class AppliedJobRepository {
  Future<AppliedJobRespo?> fetchAppliedJobs({
    required List<String> jobIds,
    int limit = 10,
    int offset = 0,
  });
}
