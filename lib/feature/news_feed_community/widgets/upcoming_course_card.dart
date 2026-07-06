import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/outline_button_widget.dart';
import 'package:flutter/material.dart';

class UpcomingCourseCard extends StatelessWidget {
  final String? feedId;
  final String imageUrl;
  final String companyName;
  final String description;
  final String date;
  final String cpdHours;
  final String location;
  final bool isFree;
  final VoidCallback onTap;
  final String profilePic;
  final String presenterName;
  final VoidCallback registerTap;
  final dynamic afterWardsPrice;
  final bool isRegistered;
  final String? type;
  final dynamic noOfSeats;
  final int? registerCount;
  final String? expiryDateCount;
  final String? courseStatus;

  const UpcomingCourseCard({
    super.key,
    required this.feedId,
    required this.imageUrl,
    required this.companyName,
    required this.description,
    required this.date,
    required this.cpdHours,
    required this.location,
    this.isFree = true,
    required this.onTap,
    required this.profilePic,
    required this.presenterName,
    required this.registerTap,
    required this.afterWardsPrice,
    required this.isRegistered,
    this.type,
    this.noOfSeats,
    this.registerCount,
    this.expiryDateCount,
    this.courseStatus,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightGeryColor, width: 1),
        ),
        margin: const EdgeInsets.only(right: 12),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: CachedNetworkImageWidget(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.contain,
                    errorWidget: const Icon(Icons.broken_image,
                        size: 50, color: AppColors.lightGeryColor),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                        noOfSeats != null
                            ? "FILLING FAST !"
                                    
                            : "SOLD OUT",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.semiBold(
                              color: AppColors.black, fontSize: 14),
                        ),
                        Text(
                          "Presented By : ${presenterName.toUpperCase()}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.semiBold(
                              color: AppColors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  OutlineButtonWidget(
                    text: "View Details",
                    onTap: onTap,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
