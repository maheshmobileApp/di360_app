import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/forgot_password/model/forget_password_res.dart';
import 'package:di360_flutter/feature/forgot_password/query/forgot_passowrd_query.dart';
import 'package:di360_flutter/feature/forgot_password/repository/forgot_password_repository.dart';

class ForgotPasswordRepoImpl extends ForgotPasswordRepository {
  HttpService http = HttpService();
  @override
  Future<ForgetPasswordData> forgotPassword(dynamic variables) async {
    final res = await http.mutation(forgotPasswordQuery, variables, isTokenRequired: false);
    return ForgetPasswordData.fromJson(res);
   
  }
}
