import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view/basic_info.dart';
import 'package:di360_flutter/feature/view_profile/view/contact_info.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';

class ViewProfileView extends StatelessWidget with BaseContextHelpers {
  const ViewProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppbarTitleBackIconWidget(title: 'View Profile'),
        body: SingleChildScrollView(
            child: Column(children: [
          _sectionTitle('Basic Info', BasicInfo()),
          _sectionTitle('Contact Information', ContactInfo())
        ])));
  }

  Widget _sectionTitle(String title, Widget? child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(title,
                style: TextStyles.medium4(color: AppColors.primaryColor)),
          ),
          Row(
            children: [
              Container(height: 2, width: 40, color: AppColors.primaryColor),
              Expanded(child: Container(height: 2, color: AppColors.geryColor))
            ],
          ),
          addVertical(10),
          Container(child: child)
        ],
      ),
    );
  }
}
