import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/querys/get_followers_query.dart';
import 'package:di360_flutter/feature/home/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HttpService _http = HttpService();

  @override
  Future getFollowerCount() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    var res =
        await _http.query(getFollowersQuery, variables: {'userId': userId});
    return res;
  }
}
