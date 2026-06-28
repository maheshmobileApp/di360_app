import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

void showAdminReportBottomSheet(BuildContext context, Function()? sumbitedAction,
    TextEditingController? controller) {
  final _formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    showDragHandle: false,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Report',
                              style: TextStyles.bold5(
                                  color: AppColors.primaryColor)),
                          InkWell(
                              onTap: () => navigationService.goBack(),
                              child: Icon(Icons.close,
                                  color: AppColors.primaryColor))
                        ]),
                    SizedBox(height: 20),
                    Text("Why are you reporting this post?",
                        style: TextStyles.semiBold(
                            color: AppColors.black, fontSize: 16)),
                    SizedBox(height: 10),
                    Text(
                        "If someone is in immediate danger, get help before reporting. Your report is confidential and won’t be shared.",
                        style: TextStyles.regular2()),
                    SizedBox(height: 10),
                    InputTextField(
                        controller: controller,
                        title: '',
                        hintText: 'Describe the issue',
                        maxLines: 5),
                    SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                              width: 150,
                              height: 45,
                              radius: 12,
                              text: 'Cancel',
                              onTap: () => navigationService.goBack()),
                          AppButton(
                              width: 150,
                              height: 45,
                              radius: 12,
                              text: 'Submit',
                              onTap: sumbitedAction)
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
