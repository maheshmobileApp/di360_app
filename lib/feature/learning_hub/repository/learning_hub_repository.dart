import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/course_status_count_data.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_type.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';

abstract class LearningHubRepository {
  Future<List<JobsRoleList>> getCategory();
  Future<List<JobTypes>> getEmpTypes();
  Future<dynamic> createCourseListing(dynamic variables);
  Future<List<CoursesListingDetails>?> getCoursesListing(
      String? listingStatus, String? userId, String? searchText);
  Future<List<CoursesListingDetails>?> getCourseDetails(String? courseId);
  Future<CourseStatusCountData> courseListingStatusCount(String? userId);
  Future<GetCourseTypes> getCourseType();
  Future<GetCourseCategories> getCourseCategory();
  Future<dynamic> deleteCourse(String? courseId);
  Future<List<CourseRegisteredUsers>?> getCourseRegisteredUsers(
      String? courseId);
  Future<dynamic> userRegisterToCourse(dynamic variables);
  Future<List<CoursesListingDetails>?> getAllListingData(String? searchText);
  Future<List<CoursesListingDetails>?> getMarketPlaceCoursesWithFilters(
      String type, String courseCategoryId,String startDate,String address);
}
