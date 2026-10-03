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

    try {
      final variables = {
        "details": {
          "email": emailController.text,
          "type": null,
        },
      };

      final res = await repo.forgotPassword(variables);

      if (res.forgetPassword?.status == "success") {
        final message =
            "Reset password link has been sent to your mail, PLease verify to reset the password";

        showSignupSuccessDialog(
          context,
          emailController.text,
          () {
            navigationService.navigateTo(RouteList.login);
          },
          title: "Sent Successfully",
          subTitle: message,
        );
      } else {
        scaffoldMessenger('Invalid response received');
      }
    } catch (e) {
      scaffoldMessenger(e.toString());
    } finally {
      Loaders.circularHideLoader(context);
    }
  }
}
