import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/get_all_listing_data_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/quiz_sumbit_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/show_course_by_id_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/update_section_status_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/user_register_to_course.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/repository/market_place_course_repository.dart';

class MarketPlaceCourseRepositoryImpl implements MarketPlaceCourseRepository {
  final HttpService http = HttpService();

  @override
  Future<List<CoursesListingDetails>?> getMarketPlaceLearningHubData(
      int limit, int offset) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final communityIdList =
        await LocalStorage.getStringList(LocalStorageConst.myCommunityIds);
    final payload = {
      "limit": limit,
      "offset": offset,
      "where": {
        "_and": [
          {
            "_or": [
              {
                "_and": [
                  {
                    "created_by_id": {"_eq": userId}
                  },
                  {
                    "_or": [
                      {
                        "community_user_type": {
                          "_in": ["COMMUNITY_USER", "BOTH"]
                        }
                      },
                      {
                        "community_user_type": {"_is_null": true}
                      },
                      if (communityIdList != [] && communityIdList.isNotEmpty)
                        {
                          "community_id": {"_in": communityIdList}
                        }
                    ]
                  }
                ]
              },
              {
                "_and": [
                  {
                    "created_by_id": {"_neq": userId}
                  },
                  {
                    "_or": [
                      {
                        "community_user_type": {"_eq": "BOTH"}
                      },
                      {
                        "community_user_type": {"_is_null": true}
                      },
                      if (communityIdList != [] && communityIdList.isNotEmpty)
                        {
                          "community_id": {"_in": communityIdList}
                        }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    };

    final listingData =
        await http.query(getAllListingDataQuery, variables: payload);

    final result = CoursesListingData.fromJson(listingData);
    return result.courses ?? [];
  }

  @override
  Future<CoursesByPk?> getCourseDetails(String? courseId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final Map<String, dynamic> variables = {
      "id": "${courseId}",
      "userId": userId
    };
    final courseTypeData =
        await http.query(showCourseById, variables: variables);
    final result = CourseDetailData.fromJson(courseTypeData);
    return result.coursesByPk;
  }

  @override
  Future<dynamic> markQuizCompleted(variables) async {
    final res = await http.mutation(quizSubmitQuery, variables);
    return res;
  }

  @override
  Future<dynamic> updatedTheCourseCompletedStatus(dynamic variables) async {
    final res =
        await http.mutation(updatedTheCourseCompletedStatusQuery, variables);
    return res;
  }
  
  @override
  Future userRegisterToCourse(dynamic variables) async {
    final res = await http.mutation(userRegisterToCourseQuery, variables);
    return res;
  }
}
