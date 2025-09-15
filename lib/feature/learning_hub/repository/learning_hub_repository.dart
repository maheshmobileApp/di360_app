import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';

abstract class LearningHubRepository {
  Future<List<JobsRoleList>> getJobRoles();
  Future<List<JobTypes>> getEmpTypes();
  Future<dynamic> createCourseListing(dynamic variables);
  Future<List<CoursesListingDetails>?> getCoursesListing(List<String>? listingStatus);
  //Future<void> removeJobListing(String? id);
  //Future<void> updateJobListing(String? id, String status);
  
 
}
