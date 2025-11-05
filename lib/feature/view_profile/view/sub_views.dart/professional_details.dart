import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessionalDetails extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputTextField(
              controller: viewProfileVM.professionTypeController,
              hintText: "Profession Type",
              title: "Profession Type",
            ),
            addVertical(10),
            InputTextField(
              controller: viewProfileVM.tgaController,
              hintText: "TGA",
              title: "TGA",
            ),
            addVertical(10),
          ],
        ),
      ),
    );
  }
}
