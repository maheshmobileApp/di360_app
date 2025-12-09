import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/support/model/get_support_request_res.dart';
import 'package:di360_flutter/feature/support/query/get_support_requests_query.dart';
import 'package:di360_flutter/feature/support/repository/support_repository.dart';

class SupportRepoImpl extends SupportRepository {
  final HttpService http = HttpService();
  @override
  Future<SupportRequestsData> getSupportRequests(variables) async {
    final res = await http.query(getSupportRequestsQuery, variables: variables);
    final data = SupportRequestsData.fromJson(res);
    return data;
  }
}
