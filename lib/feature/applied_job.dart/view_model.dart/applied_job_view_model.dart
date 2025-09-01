import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:di360_flutter/feature/applied_job.dart/repository/applied_job_repo_impo.dart';
import 'package:flutter/foundation.dart';


class AppliedJobViewModel extends ChangeNotifier {
  final AppliedJobRepositoryImpl repo = AppliedJobRepositoryImpl();
  bool isLoading = false;
  String? error;
  List<AppliedJob> appliedJobs = [];

  Future<void> fetchAppliedJobs({
    required List<String> jobIds,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await repo.fetchAppliedJobs(
        jobIds: jobIds,
        limit: limit,
        offset: offset,
      );

      appliedJobs = result?.jobs ?? [];
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
