import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/email_phone_visiable_enums.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';


class EmailVisibilityDialog extends StatelessWidget with BaseContextHelpers {
  final String? title;
  final String? selectedOption;
  final Function(String?, VisibilityType?)? onSave;
  
  const EmailVisibilityDialog({
    Key? key,
    this.title,
    this.selectedOption,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? tempSelection = selectedOption;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '', style: TextStyles.bold5(color: AppColors.black)),
              addVertical(20),
              _buildOption(
                icon: Icons.public,
                title: VisibilityType.PUBLIC.displayName,
                subtitle: "Anyone on marketplace can access",
                selectedOption: tempSelection,
                onTap: () => setState(() => tempSelection = VisibilityType.PUBLIC.displayName),
              ),
              addVertical(12),
              _buildOption(
                icon: Icons.group,
                title: VisibilityType.FOLLOWERS.displayName,
                subtitle: "Anyone who follows you can access",
                selectedOption: tempSelection,
                onTap: () => setState(() => tempSelection = VisibilityType.FOLLOWERS.displayName),
              ),
              addVertical(12),
              _buildOption(
                icon: Icons.lock,
                title: VisibilityType.PRIVATE.displayName,
                subtitle: "No one can access",
                selectedOption: tempSelection,
                onTap: () => setState(() => tempSelection = VisibilityType.PRIVATE.displayName),
              ),
              addVertical(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => navigationService.goBack(),
                    child: Text("Cancel",
                        style: TextStyles.medium2(
                            color: AppColors.bottomNavUnSelectedColor)),
                  ),
                  addHorizontal(12),
                  AppButton(
                    text: 'Save',
                    onTap: () {
                      final visibilityType = VisibilityType.fromDisplayName(tempSelection);
                      onSave?.call(tempSelection, visibilityType);
                      Navigator.pop(context, tempSelection);
                    },
                    width: 70,
                    height: 35,
                    radius: 10,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String? selectedOption,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.geryColor,
            child: Icon(icon, color: AppColors.black),
          ),
          addHorizontal(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.semiBold(fontSize: 16)),
                addVertical(4),
                Text(subtitle,
                    style: TextStyles.regular3(color: AppColors.lightGeryColor))
              ],
            ),
          ),
          Radio<String>(
            value: title,
            groupValue: selectedOption,
            onChanged: (_) => onTap(),
            activeColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
