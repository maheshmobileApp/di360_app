import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final Function(String)? onSelected;
  final bool? isDownload;
  const MenuWidget({super.key, this.onSelected, this.isDownload = false});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "Edit",
            child: buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit")),
        PopupMenuItem(
            value: "Delete",
            child:
                buildRow(Icons.delete_outline, AppColors.redColor, "Delete")),
        if (isDownload == true)
          PopupMenuItem(
              value: "Download",
              child:
                  buildRow(Icons.download, AppColors.greenColor, "Download")),
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
