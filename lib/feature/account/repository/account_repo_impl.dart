

import 'dart:convert';
import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repository.dart';
import 'package:flutter/services.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<List<ProfileSection>> getProfileSections() async {
    final String response = await rootBundle.loadString('assets/account.json');
    final data = json.decode(response);
    return (data['data'] as List)
        .map((item) => ProfileSection.fromJson(item))
        .toList();
  }
}
