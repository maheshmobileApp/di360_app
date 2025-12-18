import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/support/model/get_support_messages_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_request_reasons_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_requests_res.dart';
import 'package:di360_flutter/feature/support/query/get_support_messages_res.dart';
import 'package:di360_flutter/feature/support/query/get_support_request_query.dart';
import 'package:di360_flutter/feature/support/query/get_support_request_reasons_query.dart';
import 'package:di360_flutter/feature/support/query/insert_message_query.dart';
import 'package:di360_flutter/feature/support/query/send_support_request.dart';
import 'package:di360_flutter/feature/support/repository/support_repository.dart';

class SupportRepoImpl extends SupportRepository {
  final HttpService http = HttpService();
  @override
  Future<SupportRequestsData> getSupportRequests(variables) async {
    final res = await http.query(getSupportRequestsQuery, variables: variables);
    final data = SupportRequestsData.fromJson(res);
    return data;
  }

  @override
  Future<GetSupportRequestReasonData> getSupportRequestsReasons(variables)  async {
    final res = await http.query(getSupportRequestReasonsQuery);
    final data = GetSupportRequestReasonData.fromJson(res ?? {});
    return data;
  }
  
  @override
  Future sendSupportRequest(variables) async {
    final res = await http.mutation(sendSupportRequestQuery,variables);
    return res;
  }
  
  @override
  Future insertMessage(variables) async {
    final res = await http.mutation(insertMessageQuery,variables);
    return res;
  }

  @override
  Future<SupportMessagesData> getSupportMessages(variables)  async {
    final res = await http.query(getSupportMessagesQuery, variables: variables);
    final data = SupportMessagesData.fromJson(res ?? {});
    return data;
  }

}