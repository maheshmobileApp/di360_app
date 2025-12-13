import 'package:di360_flutter/feature/support/model/get_support_messages_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_request_reasons_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_requests_res.dart';

abstract class SupportRepository {
  Future<SupportRequestsData> getSupportRequests(dynamic variables);
  Future<GetSupportRequestReasonData> getSupportRequestsReasons(
      dynamic variables);
  Future<dynamic> sendSupportRequest(dynamic variables);
  Future<dynamic> insertMessage(dynamic variables);
  Future<SupportMessagesData> getSupportMessages(dynamic variables);
}
