import 'package:di360_flutter/feature/forgot_password/model/forget_password_res.dart';

abstract class ForgotPasswordRepository {

  Future<ForgetPasswordData> forgotPassword(dynamic variables); 
}