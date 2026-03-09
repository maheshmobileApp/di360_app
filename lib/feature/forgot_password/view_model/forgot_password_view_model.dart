import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/forgot_password/repository/forgot_password_repo_impl.dart';
import 'package:di360_flutter/feature/forgot_password/repository/forgot_password_repository.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordRepository repo = ForgotPasswordRepoImpl();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> forgotPassword(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final variables = {
      "details": {"email": emailController.text}
    };

    final res = await repo.forgotPassword(variables);
    if (res != null && res is Map) {
      if (res['_error'] != null) {
        scaffoldMessenger(res['_error'].toString());
      } else if (res['forget_password'] != null) {
        showSignupSuccessDialog(context, emailController.text, () {
          navigationService.navigateTo(RouteList.login);
        },
            title: "Sent Successfully",
            subTitle: ". Please click on the link to Reset your Password.");
      } else {
        scaffoldMessenger('Password reset link sent to your email');
        navigationService.goBack();
      }
    }
    Loaders.circularHideLoader(context);
  }
}
