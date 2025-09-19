import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:di360_flutter/feature/applied_job.dart/quary/applied_job_quary.dart';


class AppliedJobRepositoryImpl {
  final HttpService http = HttpService();

  Future<AppliedJobRespo?> fetchAppliedJobs({
    required String dentalProfessionalId,
  }) async {
    try {
      final variables = {
        "dental_professional_id": dentalProfessionalId,
      };

      final raw = await http.query(enquireJobListQuery, variables: variables);

      return AppliedJobRespo.fromJson(raw);
    } catch (e, stack) {
      print("Error fetching applied jobs: $e");
      print(stack);
      return null;
    }
  }

  Future<AppliedJobRespo?> fetchEnquireJobs({
    required String dentalProfessionalId,
  }) async {
    try {
      final variables = {
        "dental_professional_id": dentalProfessionalId,
      };

      final raw = await http.query(enquireJobListQuery, variables: variables);

      return AppliedJobRespo.fromJson(raw);
    } catch (e, stack) {
      print("Error fetching applied jobs: $e");
      print(stack);
      return null;
    }
  }

  Future<AppliedJobRespo?> fetchEnquireJobs({
    required String dentalProfessionalId,
  }) async {
    try {
      final variables = {
        "dental_professional_id": dentalProfessionalId,
      };

      final raw = await http.query(enquireJobListQuery, variables: variables);

      return AppliedJobRespo.fromJson(raw);
    } catch (e, stack) {
      print("Error fetching applied jobs: $e");
      print(stack);
      return null;
    }
  }
}
