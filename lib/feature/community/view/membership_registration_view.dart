import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MembershipRegistrationView extends StatefulWidget {
  @override
  State<MembershipRegistrationView> createState() => _MembershipRegistrationViewState();
}

class _MembershipRegistrationViewState extends State<MembershipRegistrationView> with ValidationMixins  {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);

      viewModel.getMembershipLink(context);

      viewModel.getDirectory();
    });
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
          title: "Membership Registration",
          searchWidget: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              InputTextField(
                controller: viewModel.membershipLinkController,
                hintText: "Enter Registration link",
                title: "Registration Link",
                maxLength: 75,
                validator: validateOptionalUrl,
                isRequired: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AppButton(
                      height: 42,
                      text:
                          (viewModel.membershipLink != "") ? "Update" : "Save",
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          viewModel.updateMembershipLink(context,
                              viewModel.directoryData?.directories?.first.id ??
                                  "");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                      child: CustomRoundedButton(
                    fontSize: 16,
                    backgroundColor: AppColors.timeBgColor,
                    textColor: AppColors.primaryColor,
                    text: 'Cancel',
                    height: 42,
                    width: 160,
                    onPressed: () {},
                  )),
                ],
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    "Registration Link :",
                    style: TextStyles.regular3(color: AppColors.black),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(viewModel.membershipLink);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        scaffoldMessenger("Invalid link !!");
                      }
                    },
                    child: Text(
                      viewModel.membershipLink,
                      maxLines: 3,
                      style: TextStyles.bold3(color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
              ],
            ),
          ),
        ));
  }
}
