import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/get_all_listing_data_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/get_profile_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/quiz_sumbit_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/show_course_by_id_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/update_section_status_query.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/querys/user_register_to_course.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/repository/market_place_course_repository.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class MarketPlaceCourseRepositoryImpl implements MarketPlaceCourseRepository {
  final HttpService http = HttpService();

  @override
  Future<List<CoursesListingDetails>?> getMarketPlaceLearningHubData(
      int limit, int offset, String searchText) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final communityIdList =
        await LocalStorage.getStringList(LocalStorageConst.myCommunityIds);
    final payload = {
      "limit": limit,
      "offset": offset,
      "where": {
        "_and": [
          if (searchText.isNotEmpty)
            {
              "_or": [
                {
                  "company_name": {"_ilike": "%$searchText%"}
                },
                {
                  "course_name": {"_ilike": "%$searchText%"}
                },
                {
                  "presented_by_name": {"_ilike": "%$searchText%"}
                }
              ]
            },
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
    if (listingData is Map && listingData.containsKey('_error')) return [];
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
    if (courseTypeData is Map && courseTypeData.containsKey('_error'))
      return null;
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

  @override
  Future<dynamic> getProfileData() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await http.query(
        type == UserRole.supplier.value
            ? getSupplierProfile
            : type == UserRole.professional.value
                ? getProfessionalProfile
                : getPracticeProfile,
        variables: {"id": userId});
    if (res is Map && res.containsKey('_error')) return null;
    return res;
  }
}
