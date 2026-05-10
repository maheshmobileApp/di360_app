import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/my_learning_hub/query/get_my_registered_courses_query.dart';
import 'package:di360_flutter/feature/my_learning_hub/repository/my_learning_hub_repository.dart';

class MyLearningHubRepoImpl extends MyLearningHubRepository {
  final HttpService http = HttpService();
  @override
  Future<List<CoursesListingDetails>?> getCoursesWithMyRegistrations(
      String? searchText,
      int limit,
      int offset,
      String type,
      String category,
      String date) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final Map<String, dynamic> variables = {
      "where": {
        "_and": [
          {
            "course_registered_users": {
              "from_id": {"_eq": userId}
            }
          },
          if (searchText?.isNotEmpty == true)
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
          if (type.isNotEmpty)
            {
              "type": {"_eq": type}
            },
          if (category.isNotEmpty)
            {
              "course_category": {
                "name": {"_eq": category}
              }
            },
          if (date.isNotEmpty && date != "null")
            {
              "_and": [
                {
                  "startDate": {"_lte": date}
                },
                {
                  "endDate": {"_gte": date}
                }
              ]
            }
        ]
      },
      "limit": limit,
      "offset": offset,
      "loginId": userId
    };

    final getMyRegisteredCourses =
        await http.query(getMyRegisteredCourseQuery, variables: variables);
    final response = CoursesListingData.fromJson(getMyRegisteredCourses);
    return response.courses ?? [];
  }

  @override
  Future<dynamic> certificateDownload(dynamic variables) {
    final url = "${HttpService.dioUrl}/api/v1/course/certificate-download";
    return http.downloadFile(url, variables);
  }
}
