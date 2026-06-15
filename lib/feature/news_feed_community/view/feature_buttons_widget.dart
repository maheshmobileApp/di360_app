import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';

class FeatureButtonsWidget extends StatelessWidget {
  const FeatureButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ConstantData.featureStatus.length,
        itemBuilder: (context, index) {
          String status = ConstantData.featureStatus[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 2),
            child: AppButton(
                btnColor: AppColors.whiteColor,
                btnTextColor: AppColors.black,
                text: status,
                height: 45,
                width: 130,
                radius: 8,
                onTap: () {
                  if (index == 0) {
                    navigationService.navigateTo(RouteList.directory);
                  }
                }),
          );
        },
      ),
    );
  }
}
