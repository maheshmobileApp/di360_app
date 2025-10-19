import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';

class AppbarTitleBackIconWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Function()? backAction;
  const AppbarTitleBackIconWidget({super.key, this.title, this.backAction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      leading: GestureDetector(
          onTap: backAction ?? () => navigationService.goBack(),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.black)),
      title:
          Text(title ?? '', style: TextStyles.bold4(color: AppColors.black)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
