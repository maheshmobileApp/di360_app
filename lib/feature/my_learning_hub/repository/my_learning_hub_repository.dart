import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';

abstract class MyLearningHubRepository {
  Future<List<CoursesListingDetails>?> getCoursesWithMyRegistrations(
      String? saerchText, int limit, int offset);
  Future<List<CoursesListingDetails>?> getCoursesWithFilters(
      String? userId, String type, String category, String date);
}
