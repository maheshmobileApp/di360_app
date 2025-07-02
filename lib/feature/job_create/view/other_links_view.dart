import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OtherLinksView extends StatelessWidget with BaseContextHelpers {
 const OtherLinksView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Other Links"),
            SizedBox(
              height: 20,
            ),
            InputTextField(
                controller:jobCreateVM.videoLinkController,
                title: "Video",
                hintText: "Paste/enter link",
                suffixIcon: InkWell(
                    onTap: () {
                      copyToClipboard(context, jobCreateVM. videoLinkController);
                    },
                    child: Image.asset(ImageConst.copy))),
            SizedBox(
              height: 8,
            ),
            InputTextField(
                controller:jobCreateVM.  websiteController,
                title: "Website",
                hintText: "Paste/enter link",
                suffixIcon: IconButton(
                    onPressed: () {
                      copyToClipboard(context,jobCreateVM. websiteController);
                    },
                    icon: Image.asset(ImageConst.copy))),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              controller: jobCreateVM. facebookController,
              title: "Facebook",
              hintText: "Paste/enter link",
              suffixIcon: InkWell(
                  onTap: () =>
                      copyToClipboard(context,jobCreateVM.  facebookController),
                  child: Image.asset(ImageConst.copy)),
            ),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              controller: jobCreateVM. instgramController,
              title: "Instagram",
              hintText: "Paste/enter link",
              suffixIcon: InkWell(
                  onTap: () =>
                      copyToClipboard(context, jobCreateVM. instgramController),
                  child: Image.asset(ImageConst.copy)),
            ),
            SizedBox(
              height: 8,
            ),
            InputTextField(
              controller:jobCreateVM.  linkedInController,
              title: "Linked in",
              hintText: "00000",
              suffixIcon: InkWell(
                  onTap: () =>
                      copyToClipboard(context, jobCreateVM. linkedInController),
                  child: Image.asset(ImageConst.copy)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  void copyToClipboard(context, controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Link copied to clipboard")),
      );
    }
  }
}
