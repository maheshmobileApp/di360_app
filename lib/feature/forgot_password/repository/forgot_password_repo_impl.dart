import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/forgot_password/query/forgot_passowrd_query.dart';
import 'package:di360_flutter/feature/forgot_password/repository/forgot_password_repository.dart';

class ForgotPasswordRepoImpl extends ForgotPasswordRepository {
  HttpService http = HttpService();
  @override
  Future<dynamic> forgotPassword(dynamic variables) async {
    final res = await http.mutation(forgotPasswordQuery, variables);
     print("****************$res");
    return res;
   
  }
}
