import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';

class LearningHubRepoImpl extends LearningHubRepository {
  final HttpService http = HttpService();
  
  @override
  Future createCourseListing(variables) {
    // TODO: implement createCourseListing
    throw UnimplementedError();
  }

  @override
  Future<List<JobTypes>> getEmpTypes() {
    // TODO: implement getEmpTypes
    throw UnimplementedError();
  }

  @override
  Future<List<JobsRoleList>> getJobRoles() {
    // TODO: implement getJobRoles
    throw UnimplementedError();
  }
}
