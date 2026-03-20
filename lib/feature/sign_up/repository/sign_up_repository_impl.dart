import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/sign_up/repository/sign_up_repository.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final http = HttpService();

  @override
  Future<dynamic> getSubscription() async {
    final response = await http.get(ApiConst.subscriptionsEndPoint);
    return response;
  }
}
