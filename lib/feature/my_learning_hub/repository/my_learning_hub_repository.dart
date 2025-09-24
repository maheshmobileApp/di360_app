import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';

abstract class MyLearningHubRepository {
  Future<List<CoursesListingDetails>?> getCoursesWithMyRegistrations(String? userId, String? saerchText);
  Future<List<CoursesListingDetails>?> getCoursesWithFilters(String? userId, String type, String category);
}
