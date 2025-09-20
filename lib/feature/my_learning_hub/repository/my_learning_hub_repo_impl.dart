import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/my_learning_hub/query/get_my_registered_courses_query.dart';
import 'package:di360_flutter/feature/my_learning_hub/repository/my_learning_hub_repository.dart';

class MyLearningHubRepoImpl extends MyLearningHubRepository {
  final HttpService http = HttpService();
  @override
  Future<List<CoursesListingDetails>?> getCoursesWithMyRegistrations(
      String? userId) async {
    final Map<String, dynamic> variables = {
      "limit": 10,
      "offset": 0,
      "from_id": "${userId}"
    };
    final getMyRegisteredCourses =
        await http.query(getMyRegisteredCourseQuery, variables: variables);
    final response = CoursesListingData.fromJson(getMyRegisteredCourses);
    return response.courses ?? [];
  }
}
