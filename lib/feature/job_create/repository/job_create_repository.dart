import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';

abstract class JobCreateRepository {
  Future<List<JobsRoleList>> getJobRoles();
  Future<List<JobTypes>> getEmpTypes();
  Future<dynamic> createJobListing(dynamic variables);
  Future<dynamic> updateJobListing(dynamic variables);
}
