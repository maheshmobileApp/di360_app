
import 'package:di360_flutter/feature/enquiries/model/enquiries_respo.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_respo_impo.dart';
import 'package:flutter/foundation.dart';

class EnquiriesViewModel extends ChangeNotifier {
  final EnquiriesRespoImpo repo = EnquiriesRespoImpo();
  bool isLoading = false;
  String? error;
  List<EnquiriesJob> appliedJobs = [];

  Future<void> fetchAppliedJobs({
    required String dentalProfessionalId,
  }) async {
    if (isLoading) return;

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await repo.fetchEnquiries(
        dentalProfessionalId: dentalProfessionalId,
      );

      appliedJobs = result?.data?.jobApplicants ?? <EnquiriesJob>[];

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
