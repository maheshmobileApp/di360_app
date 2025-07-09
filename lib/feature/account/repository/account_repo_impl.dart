import 'dart:convert';
import 'package:flutter/services.dart';
import '../account_model/account_model.dart';
import 'account_repository.dart';

class AccountRepoImpl extends AccountRepository {
  @override
  Future<List<AccountSection>> getAccountSections() async {
    final response = await rootBundle.loadString('assets/account.json');
    final data = json.decode(response);
    final model = GetAccountSectionsModel.fromJson(data);
    return model.data ?? [];
  }
}