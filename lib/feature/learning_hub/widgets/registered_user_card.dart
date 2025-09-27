import 'package:flutter/material.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';

class RegisteredUserCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userMail;
  final String description;
  final String userPhone;

  const RegisteredUserCard({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.userMail,
    required this.description,
    required this.userPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Image Container (1st column)
          CircleAvatar(
            backgroundColor: AppColors.geryColor,
            backgroundImage:
                imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
            radius: 30,
            child: imageUrl.isEmpty
                ? const Icon(Icons.person,
                    size: 28, color: AppColors.lightGeryColor)
                : null,
          ),

          const SizedBox(width: 12),

          // ✅ User details (2nd column)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName.toUpperCase(),
                    style: TextStyles.bold2(color: AppColors.black)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email,
                        size: 16, color: AppColors.bottomNavUnSelectedColor),
                    const SizedBox(width: 4),
                    Text(
                      userMail,
                      style: TextStyles.regular2(
                          color: AppColors.bottomNavUnSelectedColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone,
                        size: 16, color: AppColors.bottomNavUnSelectedColor),
                    const SizedBox(width: 4),
                    Text(
                      userPhone,
                      style: TextStyles.regular2(
                          color: AppColors.bottomNavUnSelectedColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (description.isNotEmpty) ...[
                      Text(
                        "Description :",
                        style: TextStyles.bold2(color: AppColors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.regular1(
                          color: AppColors.bottomNavUnSelectedColor,
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
