import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListingHubMasterCard extends StatelessWidget {
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

  const ListingHubMasterCard({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tags overlay
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(136, 141, 139, 139),
                      border: Border.all(color: AppColors.whiteColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isFree ? "Free Master Class" : "Paid Master Class",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                (date.isEmpty && date == "")
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 140,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(136, 141, 139, 139),
                            border: Border.all(color: AppColors.whiteColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "$date",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder for Logo
                      CircleAvatar(
                        backgroundColor: AppColors.geryColor,
                        backgroundImage: profilePic.isNotEmpty
                            ? NetworkImage(profilePic)
                            : null,
                        radius: 20,
                        child: profilePic.isEmpty
                            ? const Icon(Icons.business,
                                size: 20, color: AppColors.lightGeryColor)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      // Company Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companyName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              presenterName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(135, 184, 219, 244),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              "CPD: ${cpdHours} Hrs",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      (location.isEmpty && location == "")
                          ? SizedBox.shrink()
                          : Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(135, 184, 219, 244),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on_outlined,
                                        size: 16, color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        "${location}",
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onTap,
                        child: Row(
                          children: [
                            Text(
                              "Details",
                              style: TextStyles.medium1(
                                  color: AppColors.primaryColor),
                            ),
                            SvgPicture.asset(
                              ImageConst.nextArrow,
                              width: 26,
                              height: 26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
