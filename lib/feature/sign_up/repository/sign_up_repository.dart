import 'package:di360_flutter/feature/sign_up/model_class/check_mail_res.dart';

abstract class SignUpRepository {
  Future<dynamic> getSubscription ();
  Future<CheckMailData> checkMail(dynamic variables);
}
