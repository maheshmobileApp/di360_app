import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LogoutView extends StatelessWidget with BaseContextHelpers {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
                onTap: () => logOutAlert(navigatorKey.currentContext!),
                child: Text('Logout')),
          ),
          addVertical(10),
          CustomRoundedButton(
            backgroundColor: AppColors.buttonColor,
            text: 'Create Job',
            onPressed: () {
              navigationService.navigateTo(RouteList.jobCreate);
            },
          )
        ],
      ),
    );
  }
}
