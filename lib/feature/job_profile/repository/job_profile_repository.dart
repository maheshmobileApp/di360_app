
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
abstract class JobProfileRepository{
  Future<List<JobsRoleList>> getJobRoles();
}