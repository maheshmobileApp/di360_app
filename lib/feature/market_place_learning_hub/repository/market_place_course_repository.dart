import 'package:di360_flutter/feature/market_place_learning_hub/model_class/check_course_res.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_booking_res.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/promo_code_res.dart';

abstract class MarketPlaceCourseRepository {
  Future<List<CoursesListingDetails>?> getMarketPlaceLearningHubData(
      int limit, int offset, String searchText,
      {List<String>? types,
      List<String>? courseCategory,
      bool? isCommunityLearningHub,
      String? communityId});
  Future<CoursesByPk?> getCourseDetails(String? courseId);
  Future<dynamic> markQuizCompleted(dynamic variables);
  Future<dynamic> updatedTheCourseCompletedStatus(dynamic variables);
  Future<dynamic> userRegisterToCourse(dynamic variables);
  Future<dynamic> getProfileData();
  Future<CheckCourseRes> checkCourse(dynamic variables);
  Future<CourseBookingRes> courseBooking(dynamic variables);
  Future<dynamic> cancelCourse(dynamic variables, String id);
  Future<PromoCodeRes> applyPromoCode(dynamic variables);
}
