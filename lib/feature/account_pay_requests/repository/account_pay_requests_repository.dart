import 'package:di360_flutter/feature/account_pay_requests/model/account_requests_res.dart';

abstract class AccountPayRequestsRepository {
  Future<AccountRequestsData> getAccountPayRequests(dynamic variables);
}
