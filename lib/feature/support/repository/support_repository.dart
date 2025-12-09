import 'package:di360_flutter/feature/support/model/get_support_request_res.dart';

abstract class SupportRepository {
  Future<SupportRequestsData> getSupportRequests(dynamic variables);
}
