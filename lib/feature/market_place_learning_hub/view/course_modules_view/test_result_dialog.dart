import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showTestResultDialog(BuildContext context, double scored, bool passed,
    double passPercentage, List<Map<String, dynamic>> quizAnswersPayload) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Test Result",
                    style: TextStyles.bold4(color: AppColors.primaryColor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => navigationService.goBack(),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text("${scored.toStringAsFixed(0)}%",
                  style: TextStyles.bold2(color: AppColors.primaryColor)),
              const SizedBox(height: 5),
              Text("Your Score",
                  style: TextStyles.regular1(color: Colors.grey)),
              const SizedBox(height: 20),
              Text(
                scored == 100
                    ? "Congratulations! You scored full marks."
                    : scored >= passPercentage
                        ? "Congratulations! You scored ${scored.toStringAsFixed(0)}%."
                        : "You need ${passPercentage.toStringAsFixed(0)}% to pass the test and receive the certificate.\n\nYou did not meet the passing criteria. Please try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: scored >= passPercentage ? Colors.green : Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 25),
              const Divider(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context
                            .read<MarketPlaceLearningHubViewModel>()
                            .resetQuiz();
                        navigationService.goBack();
                      },
                      child: const Text("CANCEL"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AppButton(
                    text: 'Submit',
                    width: 100,
                    height: 40,
                    radius: 10,
                    btnColor: scored >= passPercentage
                        ? AppColors.primaryColor
                        : AppColors.geryColor,
                    onTap: scored >= passPercentage
                        ? () async {
                            Loaders.circularShowLoader(context);
                            final res = await context
                                .read<MarketPlaceLearningHubViewModel>()
                                .quizSubmitted(context, quizAnswersPayload);
                            if (res['update_course_registered_users_by_pk'] !=
                                null) {
                              await context
                                  .read<MyLearningHubViewModel>()
                                  .getCoursesWithMyRegistrations(context);
                              Loaders.circularHideLoader(context);
                              scaffoldMessenger(
                                  "You have successfully completed the course");

                              navigationService
                                  .pushNamedAndRemoveUntil(RouteList.dashBoard);

                              navigationService
                                  .navigateTo(RouteList.myLearningHubScreen);
                            }
                          }
                        : null,
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
