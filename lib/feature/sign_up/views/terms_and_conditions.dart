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
              'DENTAL INTERFACE 360 PRIVACY POLICY',
              style: TextStyles.bold2(color: AppColors.black),
            ),
            addVertical(16),
            _buildSection('1. INTRODUCTION', null),
            _buildNumberedItem('1.1', 'This is the Privacy Policy for the Dental Interface 360 application ("Application") and website located at https://dentalinterface360.com ("Website") (collectively and individually referred to as "DI-360") which is owned and operated by Dental Interface 360 Pty Ltd ("Company" or "us" or "we").'),
            _buildNumberedItem('1.2', 'By accessing and using DI-360 you become a user ("User", "you" or "your").'),
            _buildNumberedItem('1.3', 'Please read this Privacy Policy carefully as it explains in general terms how we protect the privacy of your personal information.'),
            addVertical(12),
            _buildSection('2. HOW WE COLLECT YOUR PERSONAL INFORMATION', null),
            _buildNumberedItem('2.1', 'We generally collect your personal information directly from you via DI-360. For example, when you sign up as an account holder or when you join our mailing list. We also collect certain information when you contact us including via phone and email.'),
            _buildNumberedItem('2.2', 'The type of personal information we collect about you may include your name, e-mail address, postal address, birthday, phone number, billing information and other information that you provide about yourself or your business.'),
            addVertical(12),
            _buildSection('3. OUR DISCLOSURE STATEMENT', null),
            _buildNumberedItem('3.1', 'Generally, we will tell you why we are collecting information when we collect it and how we plan to use it, or these things will be obvious when we collect your information.'),
            _buildNumberedItem('3.2', 'We usually collect personal information directly from you although sometimes we may use agents or third party service providers to do this for us.'),
            _buildNumberedItem('3.3', 'It is your responsibility to ensure the personal information held by us is accurate, up to date and complete.'),
            addVertical(12),
            _buildSection('4. HOW WE USE OR DISCLOSE YOUR PERSONAL INFORMATION', null),
            _buildNumberedItem('4.1', 'We will use and disclose personal information for the primary purpose for which it was collected. We may also use and disclose personal information for purposes related or ancillary to the main reasons we collect it, such as invoicing, sending reminder notices, and providing you with information relating to us and our services.'),
            _buildNumberedItem('4.2', 'We do not disclose personal information we collect to third parties for the purpose of allowing them to directly market their products and services unless you have agreed to such disclosure at the time of collection.'),
            addVertical(12),
            _buildSection('5. USE OF AGGREGATE DATA', null),
            _buildNumberedItem('5.1', 'We may collect certain non-personal information to optimise the services we provide to you (for example the identity of your browser, the type of operating system you use, your IP address and the domain name of your service provider).'),
            _buildNumberedItem('5.2', 'We may use non-personally identifiable information in aggregate form to improve DI-360 and our services.'),
            addVertical(12),
            _buildSection('6. SECURITY', null),
            _buildNumberedItem('6.1', 'We strive to ensure the security, integrity and privacy of personally identifiable information of our Users. We use a variety of physical and electronic security measures including restricting physical access to our offices and firewalls and secure databases to keep personal information secure from misuse, loss or unauthorised use or disclosure. Although we use best efforts to maintain security of your information, unfortunately no data transmission over the Internet can be guaranteed to be totally secure and you acknowledge that we will not be liable in the event that your personal information is accessed or disclosed due to reasons beyond our control, including but not limited to hacking from a third party.'),
            addVertical(12),
            _buildSection('7. CAN-SPAM COMPLIANCE & OPTING OUT', null),
            _buildNumberedItem('7.1', 'In compliance with the CAN-SPAM legislation, when we send you an email we will clearly state who the e-mail is from and provide clear information on how to contact us. In addition, all emails from us will also contain instructions on how to remove yourself or unsubscribe from our mailing list.'),
            addVertical(12),
            _buildSection('8. PUBLIC INFORMATION', null),
            _buildNumberedItem('8.1', 'All information posted by a User on any of DI-360 forums, social media accounts and/or communicated in comment and chat areas of DI-360 is public information and is accessible by other Users of DI-360. While we strive to protect and respect your privacy, you acknowledge that any information that you upload or disclose on any of the public forums on DI-360 will be seen by other Users.'),
            addVertical(12),
            _buildSection('9. COOKIES', null),
            _buildNumberedItem('9.1', 'DI-360 may use \'cookies\' which is when a website transfers certain data to an individual\'s hard drive for record-keeping purposes. They allow us to track usage patterns and to compile data that can help us improve our content and target advertising. If you do not want information collected through the use of cookies, you can elect to deny the cookie feature by going into your browser settings. It is your responsibility to adjust your cookie settings as required.'),
            addVertical(12),
            _buildSection('10. LINKING TO THIRD PARTY SITES', null),
            _buildNumberedItem('10.1', 'We are not responsible for the content or practices of websites operated by third parties that are linked from DI-360. These links are meant for your convenience only and you agree that once you leave DI-360 via such a link, you are responsible for checking the applicable privacy policy of the third party site.'),
            addVertical(12),
            _buildSection('11. PAYMENT INFORMATION', null),
            _buildNumberedItem('11.1', 'Payment information that you enter into DI-360 is collected by third party merchants. Your payment information is handled in accordance with the relevant merchant\'s terms and conditions and privacy policy. It is your responsibility to review and accept such terms before entering your payment information into DI-360.'),
            addVertical(12),
            _buildSection('12. ACCESSING YOUR INFORMATION', null),
            _buildNumberedItem('12.1', 'We will, on request, provide you with access to your personal information. Your request to obtain access will be dealt with in a reasonable time. If we refuse to provide you with access to the information, we will provide you with reasons for the refusal and inform you of any exceptions relied upon under the relevant privacy legislation.'),
            _buildNumberedItem('12.2', 'We take reasonable steps to ensure that your personal information is accurate, complete, and up-to-date whenever we collect or use it. If any of the personal information we hold about you is inaccurate, incomplete or out-of-date, please contact us immediately and we will take reasonable steps to correct this information.'),
            addVertical(12),
            _buildSection('13. HOW TO CONTACT US', null),
            _buildNumberedItem('13.1', 'If you wish to gain access to your personal information or make a complaint about a breach of your privacy, or if you have any query on how your personal information is collected, or used or any other query relating to this Privacy Policy please email Support@dentalinterface360.com'),
            addVertical(24),
            Divider(color: AppColors.black.withOpacity(0.2)),
            addVertical(24),
            Text(
              'Confidentiality & Non-Recreation Terms and Conditions',
              style: TextStyles.bold2(color: AppColors.black),
            ),
            addVertical(8),
            Text(
              'By signing up, accessing, or using this platform (including Dental Interface 360, Dental Suite 360, and associated services), you agree to the following terms:',
              style: TextStyles.regular3(color: AppColors.black),
            ),
            addVertical(12),
            _buildSection('1. Confidentiality', 'All content, features, systems, workflows, designs, concepts, and information made available through this platform are confidential and proprietary.'),
            addVertical(4),
            Text('You agree to:', style: TextStyles.regular3(color: AppColors.black)),
            _buildBullet('Keep all platform-related information strictly confidential'),
            _buildBullet('Not share, disclose, or distribute any part of the platform to any third party'),
            _buildBullet('Use the platform only for its intended purpose'),
            addVertical(12),
            _buildSection('2. Non-Recreation & Non-Replication', 'You must not, directly or indirectly:'),
            _buildBullet('Copy, reproduce, or duplicate the platform'),
            _buildBullet('Recreate or develop similar software, systems, or applications'),
            _buildBullet('Reverse engineer, decompile, or analyse the platform structure'),
            _buildBullet('Use any ideas, workflows, features, or concepts to build a competing product'),
            _buildBullet('Allow or assist any third party to do the above'),
            addVertical(4),
            Text('This applies whether in whole or in part, and whether for commercial or personal use.', style: TextStyles.regular3(color: AppColors.black)),
            addVertical(12),
            _buildSection('3. Intellectual Property', 'All intellectual property rights, including but not limited to:'),
            _buildBullet('Software'),
            _buildBullet('Features and functionality'),
            _buildBullet('Design and user interface'),
            _buildBullet('Business model and workflows'),
            addVertical(4),
            Text('remain the sole property of the platform owner. No rights, ownership, or licenses are transferred to you.', style: TextStyles.regular3(color: AppColors.black)),
            addVertical(12),
            _buildSection('4. Non-Compete Use', 'You agree not to use any knowledge, exposure, or information gained from this platform to:'),
            _buildBullet('Compete with the platform'),
            _buildBullet('Develop similar products or services'),
            _buildBullet('Gain commercial advantage'),
            addVertical(12),
            _buildSection('5. Breach', 'Any breach of these terms may result in:'),
            _buildBullet('Immediate suspension or termination of access'),
            _buildBullet('Legal action'),
            _buildBullet('Claims for damages and losses'),
            _buildBullet('Injunctive relief to prevent further misuse'),
            addVertical(12),
            _buildSection('6. Acceptance', 'By registering, accessing, or using the platform, you acknowledge and agree to these terms.'),
            addVertical(16),
            Text(
              'By clicking "I Agree", you confirm that you have read and accepted this Privacy Policy and all Terms and Conditions.',
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

  Widget _buildSection(String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.bold3(color: AppColors.black)),
        if (content != null) ...[addVertical(4), Text(content, style: TextStyles.regular3(color: AppColors.black))],
      ],
    );
  }

  Widget _buildNumberedItem(String number, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number  ', style: TextStyles.bold3(color: AppColors.black)),
          Expanded(child: Text(content, style: TextStyles.regular3(color: AppColors.black))),
        ],
      ),
    );
  }

  Widget _buildBullet(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyles.regular3(color: AppColors.black)),
          Expanded(child: Text(content, style: TextStyles.regular3(color: AppColors.black))),
        ],
      ),
    );
  }
}
