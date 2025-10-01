import 'dart:convert';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/course_status_count_data.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_type.dart';
import 'package:di360_flutter/feature/learning_hub/querys/add_course_query.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/querys/delete_course_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_all_listing_data_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_course_category_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_course_registered_users_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_course_status_count.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_course_type_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_courses_list_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/get_market_place_courses.dart';
import 'package:di360_flutter/feature/learning_hub/querys/show_course_by_id_query.dart';
import 'package:di360_flutter/feature/learning_hub/querys/user_register_to_course.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';
import 'package:flutter/services.dart';

class LearningHubRepoImpl extends LearningHubRepository {
  final HttpService http = HttpService();

  @override
  Future createCourseListing(dynamic variables) async {
    final res = await http.mutation(addCourseQuery, variables);
    return res;
  }

  @override
  Future<List<JobsRoleList>> getCategory() async {
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
      String? listingStatus, String? userId, String? searchText) async {
    final Map<String, dynamic> whereCondition = {};

    if (listingStatus != null &&
        listingStatus.isNotEmpty &&
        listingStatus != "All") {
      whereCondition["status"] = {"_eq": listingStatus};
    }

    if (searchText != null && searchText.isNotEmpty) {
      whereCondition["course_name"] = {"_ilike": "%${searchText}%"};
    }
    whereCondition["created_by_id"] = {"_eq": userId};

    final payload = {
      "where": whereCondition,
      "limit": 100,
      "offset": 0,
    };

    final listingData = await http.query(
      getCoursesQuery,
      variables: payload,
    );

    final result = CoursesListingData.fromJson(listingData);
    return result.courses ?? [];
  }

  /*

  {
  "where": {
    "status": { "_eq": "APPROVE" },
    "active_status": { "_eq": "ACTIVE" },
    "company_name": { "_ilike": "%smiletech%" }
  },
  "limit": 10,
  "offset": 0
}
  
   */

  @override
  Future<CourseStatusCountData> courseListingStatusCount(String? userId) async {
    final Map<String, dynamic> variables = {
      "whereAll": {
        "created_by_id": {"_eq": "${userId}"}
      },
      "whereDraft": {
        "status": {"_eq": "DRAFT"},
        "created_by_id": {"_eq": "${userId}"}
      },
      "where": {
        "created_by_id": {"_eq": "${userId}"}
      }
    };
    final response =
        await http.query(getCourseStatusCount, variables: variables);
    print("Raw response: $response");
    final result = CourseStatusCountData.fromJson(response);
    print("Parsed result: $result");

    return result;
  }

  @override
  Future<GetCourseTypes> getCourseType() async {
    final courseTypeData = await http.query(getCourseTypeQuery);
    final result = GetCourseTypes.fromJson(courseTypeData);
    return result;
  }

  @override
  Future<GetCourseCategories> getCourseCategory() async {
    final Map<String, dynamic> variables = {
      "status": "ACTIVE",
      "search": "%%",
      "limit": 30,
      "offset": 0
    };
    final courseCategoryData =
        await http.query(getCourseCategoryQuery, variables: variables);
    final result = GetCourseCategories.fromJson(courseCategoryData);
    return result;
  }

  @override
  Future<List<CoursesListingDetails>?> getCourseDetails(
      String? courseId) async {
    final Map<String, dynamic> variables = {"id": "${courseId}"};
    final courseTypeData =
        await http.query(showCourseById, variables: variables);
    final result = CoursesListingData.fromJson(courseTypeData);
    return result.courses;
  }

  @override
  Future deleteCourse(String? courseId) async {
    final deleteCourse =
        await http.mutation(deleteCourseQuery, {"id": courseId});
    return deleteCourse;
  }

  @override
  Future<List<CourseRegisteredUsers>?> getCourseRegisteredUsers(
      String? courseId) async {
    final Map<String, dynamic> variables = {
      "course_id": "${courseId}",
      "limit": 100,
      "offset": 0
    };
    final getUsersData =
        await http.query(getCourseRegisteredUsersQuery, variables: variables);
    final result = GetUsers.fromJson(getUsersData);
    return result.courseRegisteredUsers;
  }

  @override
  Future userRegisterToCourse(dynamic variables) async {
    final res = await http.mutation(userRegisterToCourseQuery, variables);
    return res;
  }

  @override
  Future<List<CoursesListingDetails>?> getAllListingData(
      String? searchText) async {
    final payload = {
      "limit": 10,
      "offset": 0,
      "where": {
        "course_name": {"_ilike": "%${searchText}%"}
      }
    };

    final listingData = await http.query(
      getAllListingDataQuery,
      variables: payload,
    );

    final result = CoursesListingData.fromJson(listingData);
    return result.courses ?? [];
  }

  @override
  Future<List<CoursesListingDetails>?> getMarketPlaceCoursesWithFilters(
      String type,
      String courseCategoryId,
      String startDate,
      String address) async {
    final List<Map<String, dynamic>> andConditions = [];

    
    

    if (type.isNotEmpty) {
      andConditions.add({
        "type": {
          "_in": [type]
        }
      });
    }

    if (courseCategoryId.isNotEmpty) {
      andConditions.add({
        "course_category_id": {
          "_in": [courseCategoryId]
        }
      });
    }

    if (startDate.isNotEmpty) {
      andConditions.add({
        "startDate": {"_eq": startDate}
      });
    }

    if (address.isNotEmpty) {
      andConditions.add({
        "address": {
          "_cast": {
            "String": {"_ilike": "%$address%"}
          }
        }
      });
    }

    final Map<String, dynamic> variables = {
      "limit": 10,
      "offset": 0,
      "where": {
        "_and": andConditions 
      }
    };

    final getMarketPlaceCourses = await http.query(
      getMarketPlaceCoursesQuery,
      variables: variables,
    );

    final response = CoursesListingData.fromJson(getMarketPlaceCourses);
    return response.courses ?? [];
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
