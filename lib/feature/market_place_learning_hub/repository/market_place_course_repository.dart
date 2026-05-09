import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';

abstract class MarketPlaceCourseRepository {
  Future<List<CoursesListingDetails>?> getMarketPlaceLearningHubData(
      int limit, int offset);
  Future<CoursesByPk?> getCourseDetails(String? courseId);
  Future<dynamic> markQuizCompleted(dynamic variables);
  Future<dynamic> updatedTheCourseCompletedStatus(dynamic variables);
  Future<dynamic> userRegisterToCourse(dynamic variables);
}
