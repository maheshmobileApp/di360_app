import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view/professinoal_basic_info.dart';
import 'package:di360_flutter/feature/view_profile/view/professional_contact_info.dart';
import 'package:di360_flutter/feature/view_profile/view/professional_detail_info.dart';
import 'package:di360_flutter/feature/view_profile/view/professional_personal_details.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalViewProfileScreen extends StatelessWidget
    with BaseContextHelpers {
  ProfessionalViewProfileScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewProfileViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppbarTitleBackIconWidget(title: 'View Profile'),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(children: [
            _sectionTitle('Basic Info', ProfessinoalBasicInfo()),
            _sectionTitle('Personal Details', ProfessionalPersonalDetails()),
            _sectionTitle('Contact Information', ProfessionalContactInfo()),
            _sectionTitle('Professional Details', ProfessionalDetailInfo()),
            addVertical(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                      text: 'Delete My Account',
                      height: 45,
                      width: 180,
                      onTap: () {
                        showDeleteAccountDialog(context, () {
                          provider.deleteAccount(context);
                        });
                      }),
                  AppButton(
                      text: 'Save & Update',
                      height: 45,
                      width: 180,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          provider.updateViewProfile(context);
                        }
                      }),
                ],
              ),
            ),
            addVertical(10)
          ]),
        )));
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
