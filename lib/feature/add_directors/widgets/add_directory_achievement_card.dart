import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class AddDirectoryAchievementCard extends StatelessWidget {
  final String title;
  final String? imageFile;
  final Function(String)? onSelected;

  const AddDirectoryAchievementCard(
      {super.key, required this.title, this.imageFile, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.cardcolor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          if (imageFile != null) ...[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImageWidget(
                    imageUrl: imageFile ?? '', width: 50, height: 50)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyles.bold2(color: AppColors.black),
            ),
          ),
          const SizedBox(width: 10),
          MenuWidget(onSelected: onSelected)
        ],
      ),
    );
  }
}
