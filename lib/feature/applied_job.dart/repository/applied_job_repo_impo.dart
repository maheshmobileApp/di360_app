import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:di360_flutter/feature/applied_job.dart/quary/applied_job_quary.dart';


class AppliedJobRepositoryImpl {
  final HttpService http = HttpService();

  Future<AppliedJobRespo?> fetchAppliedJobs({
    required List<String> jobIds,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final variables = {
        "id": jobIds,
        "limit": limit,
        "offset": offset,
      };

      final raw = await http.query(appliedJobQuery, variables: variables);

      final root = raw['data'] as Map<String, dynamic>;

      return AppliedJobRespo.fromJson(root);
    } catch (e, stack) {
      print(" Error fetching applied jobs: $e");
      print(stack);
      return null;
    }
  }
}
