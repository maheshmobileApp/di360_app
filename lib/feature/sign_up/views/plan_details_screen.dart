import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/sign_up/model_class/subscription_res.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  @override
  _SubscriptionPlanScreenState createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    final viewModel = Provider.of<SignupViewModel>(context, listen: false);
    viewModel.subscriptionPlans();
    super.initState();
  }

  String selectedCategory = 'Dental Professional';
  Map<String, List<SubscriptionPlans>> categorizedPlans = {
    'Dental Professional': [],
    'Dental Business Owner': [],
    'Dental Practice Owner': [],
  };

// Map the raw plans into UI categories
  void categorizePlans(List<SubscriptionPlans> plans) {
    for (var plan in plans) {
      switch (plan.type) {
        case 'PROFESSIONAL':
          categorizedPlans['Dental Professional']!.add(plan);
          break;
        case 'SUPPLIER':
          categorizedPlans['Dental Business Owner']!.add(plan);
          break;
        case 'PRACTICE':
          categorizedPlans['Dental Practice Owner']!.add(plan);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);
    final plans = viewModel.subscriptionPlanList ?? [];

    categorizedPlans = {
      'Dental Professional': [],
      'Dental Business Owner': [],
      'Dental Practice Owner': [],
    };

    categorizePlans(plans);

    final selectedPlans = categorizedPlans[selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigationService.goBack();
            }),
        title: Text('Your Plan Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle
            ToggleButtons(
              isSelected: [true, false],
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: AppColors.primaryColor,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Monthly'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Yearly'),
                ),
              ],
              onPressed: (int index) {},
            ),
            addVertical(16),
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab("Dental Professional"),
                  addHorizontal(10),
                  _buildTab("Dental Business Owner"),
                  addHorizontal(10),
                  _buildTab("Dental Practice Owner"),
                ],
              ),
            ),
            addVertical(20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedPlans.length,
                itemBuilder: (context, index) {
                  final plan = selectedPlans[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 20),
                    color: AppColors.hintColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.name ?? '',
                            style:
                                TextStyles.bold6(color: AppColors.primaryColor),
                          ),
                          addVertical(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: plan.benefits?.length,
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      color: AppColors.primaryColor),
                                  addHorizontal(12),
                                  Expanded(
                                    child: Text(
                                      plan.benefits?[i].name ?? '',
                                      style: TextStyles.regular3(
                                          color: AppColors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "AUD ${plan.monthyPrice ?? 0} / Monthly",
                                style: TextStyles.bold5(color: AppColors.black),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  viewModel.setSelectedSubscriptionType(
                                      plan.type ?? '',
                                      plan.id ?? '',
                                      plan.name ?? '');
                                  navigationService
                                      .navigateTo(RouteList.signup);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text("Subscribe",
                                    style: TextStyles.medium4(
                                        color: AppColors.whiteColor)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Column(
        children: [
          Text(
            category,
            style: TextStyle(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.lightGeryColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 4),
              height: 2,
              width: 100,
              color: AppColors.primaryColor,
            ),
        ],
      ),
    );
  }
}
