import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MarketPlaceLearningHubViewModel>(context);
    return Scaffold(
      appBar: AppbarTitleBackIconWidget(title: '', backAction: () {
       
      }),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle,
                  color: AppColors.primaryColor, size: 100),
              SizedBox(height: 20),
              Text('Registration Successful!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Thank you for registering. You can now access the course.',
                  textAlign: TextAlign.center),
              SizedBox(height: 30),
              AppButton(
                onTap: () async {
                  await vm.getAllLearningHubData(context,
                      isCommunityLearningHub: false);
                  navigationService
                      .pushNamedAndRemoveUntil(RouteList.dashBoard);
                },
                text: 'Done',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
