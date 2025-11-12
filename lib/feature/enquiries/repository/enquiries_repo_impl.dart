import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/query/enquiries_list_query.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repository.dart';

class EnquiriesRepoImpl extends EnquiriesRepository {
  final http = HttpService();

  @override
  Future<EnquiriesListResData> getMyEnquiryJobData(String enquiryId) async {
    final variables = {
      "limit": 5,
      "offset": 0,
      "where": {
        "enquiry_userid": {"_eq": "a8bcb5cc-5bee-4513-864d-43b0223f6b2f"}
      }
    };
    final res = await http.query(enquiriesListQuery, variables: variables);
    final output = EnquiriesListResData.fromJson(res);
    return output;
  }
}
