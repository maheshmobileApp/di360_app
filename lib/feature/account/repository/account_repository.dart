import 'package:di360_flutter/feature/account/account_model/account_model.dart';

abstract class AccountRepository {
  Future<List<AccountSection>> getAccountSections();
}