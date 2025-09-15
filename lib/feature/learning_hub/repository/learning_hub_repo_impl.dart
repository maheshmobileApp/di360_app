import 'dart:convert';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/course_listing_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/querys/add_course_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_courses_list_query.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';
import 'package:flutter/services.dart';

class LearningHubRepoImpl extends LearningHubRepository {
  final HttpService http = HttpService();

  @override
  Future createCourseListing(dynamic variables)  async{
   final res = await http.mutation(addCourseQuery, variables);
    return res;
  }
  

  @override
  Future<List<JobsRoleList>> getJobRoles() async {
    final response = await rootBundle.loadString('assets/roles.json');
    final data = json.decode(response);
    final model = GetJobRolesModel.fromJson(data);
    return model.data?.jobsRoleList ?? [];
  }

  @override
  Future<List<JobTypes>> getEmpTypes() async {
    final response = await rootBundle.loadString('assets/job_type.json');
    final data = json.decode(response);
    final model = GetEmpTypesModel.fromJson(data);
    return model.data?.jobTypes ?? [];
  }

  @override
  Future<List<CoursesListingDetails>?> getCoursesListing(
      List<String>? listingStatus) async {
    final listingData = await http.query(getCoursesQuery, variables: {
      "where": {
        "status": {"_eq": "APPROVE"},
        "active_status": {"_eq": "ACTIVE"},
        "company_name": {"_ilike": "%smiletech%"}
      },
      "limit": 10,
      "offset": 0
    });
    final result = CoursesListingData.fromJson(listingData);
    return result.courses ?? [];
  }
  
  /*@override
  Future<dynamic> removeJobListing(String? id) async {
    final jobListingData = await http.mutation(deleteJobListing, {"id": id});
    return jobListingData;
  }

  @override
  Future<dynamic> updateJobListing(String? id, String status) async {
    final jobListingStatusData =
        await http.mutation(updateJobListingStatus, {"id": id, "status": status});
    return jobListingStatusData;
  }*/
}
