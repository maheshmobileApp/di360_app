import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:di360_flutter/feature/applied_job.dart/repository/applied_job_repo_impo.dart';
import 'package:flutter/foundation.dart';


class AppliedJobViewModel extends ChangeNotifier {
  final AppliedJobRepositoryImpl repo = AppliedJobRepositoryImpl();
  bool isLoading = false;
  String? error;
  List<AppliedJob> appliedJobs = [];
   List<AppliedJob> messages = [];
  Future<void> fetchAppliedJobs() async {
    if (isLoading) return;

    try {
      isLoading = true;
      error = null;
      notifyListeners();


      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      final result = await repo.fetchAppliedJobs(
        dentalProfessionalId: userId,
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
