import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/my_learning_hub/query/get_my_registered_courses_query.dart';
import 'package:di360_flutter/feature/my_learning_hub/query/get_my_registered_courses_with_filters.dart';
import 'package:di360_flutter/feature/my_learning_hub/repository/my_learning_hub_repository.dart';

class MyLearningHubRepoImpl extends MyLearningHubRepository {
  final HttpService http = HttpService();
  @override
  Future<List<CoursesListingDetails>?> getCoursesWithMyRegistrations(
      String? userId, String? searchText) async {
    final Map<String, dynamic> variables = {
      "where": {
        "_and": [
          {
            "course_registered_users": {
              "from_id": {"_eq": "${userId}"}
            }
          },
          {
            "course_name": {"_ilike": "%${searchText}%"}
          }
        ]
      },
      "limit": 10,
      "offset": 0
    };
    final getMyRegisteredCourses =
        await http.query(getMyRegisteredCourseQuery, variables: variables);
    final response = CoursesListingData.fromJson(getMyRegisteredCourses);
    return response.courses ?? [];
  }

  @override
  Future<List<CoursesListingDetails>?> getCoursesWithFilters(
      String? userId, String? type, String? category) async {
    final List<Map<String, dynamic>> andConditions = [
      {
        "course_registered_users": {
          "from_id": {"_eq": userId}
        }
      }
    ];

    if (type != null && type.isNotEmpty) {
      andConditions.add({
        "type": {"_eq": type}
      });
    }

    if (category != null && category.isNotEmpty) {
      andConditions.add({
        "course_category": {
          "name": {"_eq": category}
        }
      });
    }

    final Map<String, dynamic> variables = {
      "where": {
        "_and": andConditions,
      },
      "limit": 10,
      "offset": 0,
    };

    final getMyRegisteredCourses = await http
        .query(getMyRegisteredCourseWithFiltersQuery, variables: variables);

    final response = CoursesListingData.fromJson(getMyRegisteredCourses);
    return response.courses ?? [];
  }
}
