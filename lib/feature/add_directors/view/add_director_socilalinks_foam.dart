import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddDirectorSocilalinksFoam extends StatelessWidget
    with BaseContextHelpers {
  @override
  Widget build(
    BuildContext context,
  ) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionHeader("Add social links` "),
        addVertical(12),
        CustomDropDown<String>(
          title: 'Account',
          hintText: 'Select Account',
          isRequired: true,
          value: AddDirectorVM.selectedAccount,
          items: AddDirectorVM.AccountList.map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              )).toList(),
          onChanged: (val) {
            AddDirectorVM.selectedTeamMember = val;
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'Please Select Account' : null,
        ),
        addVertical(16),
        InputTextField(
         title: "Social Accounts URL",
          hintText: "Paste/enter link",
          suffixIcon: IconButton(
          onPressed: () =>
                copyToClipboard(context, AddDirectorVM.SocialAccountsController),
          icon: Image.asset(ImageConst.copy),
          ),
        ),
      ]),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }
   void copyToClipboard(BuildContext context, TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Link copied to clipboard")),
      );
    }
  }
}
