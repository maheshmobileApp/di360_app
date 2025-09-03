import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:di360_flutter/feature/applied_job.dart/repository/applied_job_repo_impo.dart';
import 'package:flutter/foundation.dart';


class AppliedJobViewModel extends ChangeNotifier {
  final AppliedJobRepositoryImpl repo = AppliedJobRepositoryImpl();
  bool isLoading = false;
  String? error;
  List<AppliedJob> appliedJobs = [];
   List<AppliedJob> messages = [];
  Future<void> fetchAppliedJobs({
    required String dentalProfessionalId,
  }) async {
    if (isLoading) return;

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await repo.fetchAppliedJobs(
        dentalProfessionalId: dentalProfessionalId,
      );

      appliedJobs = result?.data?.jobApplicants ?? <AppliedJob>[];
    } catch (e, stack) {
      debugPrint('Error in fetchAppliedJobs: $e\n$stack');
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    appliedJobs = [];
    error = null;
    notifyListeners();
  }
}
