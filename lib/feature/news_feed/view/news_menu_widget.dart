import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

class NewsMenuWidget extends StatelessWidget {
  final Function(String)? onSelected;
  const NewsMenuWidget({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "share",
            child: buildRow(Icons.share, AppColors.blueColor, "Share")),
        PopupMenuItem(
            value: "report",
            child: buildRow(Icons.report, AppColors.primaryColor, "Report")),
        PopupMenuItem(
            value: "block",
            child: buildRow(Icons.block, AppColors.redColor, "Block")),
      ],
    );
  }
}

Widget buildRow(IconData? icon, Color? color, String? title) {
  return Row(children: [
    Icon(icon, color: color),
    SizedBox(width: 8),
    Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
  ]);
}

void showReportBottomSheet(BuildContext context, Function()? sumbitedAction) {
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
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
                    InputTextField(title: 'Report', hintText: 'Enter report'),
                    SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            width: 150,
                            height: 45,
                            radius: 12,
                            text: 'Cancel',
                            onTap: () => navigationService.goBack(),
                          ),
                          AppButton(
                              width: 150,
                              height: 45,
                              radius: 12,
                              text: 'Submited',
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
