import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleSelectionScreen extends StatelessWidget with BaseContextHelpers {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);

    final businessTypes = viewModel.directoryBusinessTypes;
    final selectedIndex = viewModel.selectedIndex;

    final selectedBusiness = businessTypes?[selectedIndex];
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Know Your Role'),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: getSize(context).height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset(ImageConst.role)),
                  addVertical(5),
                  Text(
                    "Understand your responsibilities and how you fit into the team.",
                    textAlign: TextAlign.center,
                    style: TextStyles.medium3(color: AppColors.lightGeryColor),
                  ),
                  addVertical(20),
                  Text("What's your current role?",
                      textAlign: TextAlign.center,
                      style: TextStyles.bold3(color: AppColors.black)),
                  addVertical(10),

                  // Role Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(businessTypes?.length ?? 0, (index) {
                        final type = businessTypes?[index];
                        final isSelected = index == selectedIndex;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(type?.name ?? ''),
                            selected: isSelected,
                            onSelected: (_) =>
                                viewModel.setSelectedIndex(index),
                            selectedColor: AppColors.primaryColor,
                            backgroundColor: AppColors.geryColor,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  addVertical(16),

                  // Category Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      selectedBusiness?.directoryCategories?.length ?? 0,
                      (index) {
                        final cat =
                            selectedBusiness?.directoryCategories?[index];
                        final isSelected =
                            viewModel.selectedCategory?.id == cat?.id;
                        return ChoiceChip(
                          label: Text(cat?.name ?? ''),
                          selected: isSelected,
                          onSelected: (_) => cat != null
                              ? viewModel.selectCategory(cat)
                              : null,
                          selectedColor: AppColors.primaryColor,
                          backgroundColor: AppColors.hintColor,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          shape: const StadiumBorder(
                            side: BorderSide(color: AppColors.primaryColor),
                          ),
                        );
                      },
                    ),
                  ),
                  addVertical(20),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: AppButton(
                          text: 'Create new account',
                          height: 48,
                          onTap: () {
                            if (viewModel.selectedCategory == null) {
                              scaffoldMessenger('Please select category');
                            } else {
                              navigationService
                                  .navigateTo(RouteList.practiceDetailsScreen);
                            }
                          })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
