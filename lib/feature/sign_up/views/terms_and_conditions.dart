import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsDetails extends StatelessWidget
    with BaseContextHelpers {
  const TermsAndConditionsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Terms and Conditions'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to our Professional Directory. By creating your account and using our platform, you agree to the following Terms and Conditions:',
              style: TextStyles.regular3(color: AppColors.black),
            ),
            addVertical(16),
            _buildSection(
              'Account Responsibility:',
              'You are responsible for maintaining the confidentiality of your account credentials and ensuring that the information you provide is accurate and up to date.',
            ),
            addVertical(12),
            _buildSection(
              'Professional Conduct:',
              'All listings and interactions must reflect professional behavior. Any misleading, false, or inappropriate content may result in account suspension.',
            ),
            addVertical(12),
            _buildSection(
              'Use of Information:',
              'The information you provide (such as name, qualification, contact details) will be displayed publicly in your directory profile as per your consent.',
            ),
            addVertical(12),
            _buildSection(
              'Compliance:',
              'You must comply with applicable laws, professional guidelines, and community standards while using this platform.',
            ),
            addVertical(12),
            _buildSection(
              'Platform Rights:',
              'We reserve the right to review, modify, or remove any content that violates these terms or affects platform integrity.',
            ),
            addVertical(12),
            _buildSection(
              'Termination:',
              'Violation of these terms may lead to temporary or permanent suspension of your account.',
            ),
            addVertical(16),
            Text(
              'By clicking "I Agree", you confirm that you have read and accepted these Terms and Conditions.',
              style: TextStyles.medium3(color: AppColors.black),
            ),
            addVertical(16),
            AppButton(
              height: 50,
              text: "I Agree",
              onTap: () {
                navigationService.goBack();
                viewModel.setAgreeToTerms(true);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.bold3(color: AppColors.black),
        ),
        addVertical(4),
        Text(
          content,
          style: TextStyles.regular3(color: AppColors.black),
        ),
      ],
    );
  }
}
