import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/register_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
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
  final VoidCallback registerTap;

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
    required this.presenterName, required this.registerTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
                GestureDetector(
                  onTap: onTap,
                  child: CachedNetworkImageWidget(
                    imageUrl: imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: AppColors.lightGeryColor,
                    ),
                  ),
                ),
                /*Positioned(
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
                ),*/
                /*(date.isEmpty && date == "")
                    ? SizedBox.shrink()
                    : Positioned(
                        left: 8,
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
                      ),*/
              ],
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PRESENTED BY",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Placeholder for Logo
                      CircleAvatar(
                        backgroundColor: AppColors.geryColor,
                        backgroundImage: profilePic.isNotEmpty
                            ? NetworkImage(profilePic)
                            : null,
                        radius: 15,
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
                              presenterName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Text(
                    companyName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            "CPD HOURS: ${cpdHours}",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Colors.grey, size: 20),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              (location.isEmpty)?"------":"${location}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined,
                              color: Colors.grey, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            (date.isEmpty)?"------":date,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /*Row(
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
                  ),*/
                ],
              ),
            ),
            //Spacer(),
            RegisterButton(
              text: 'Register Now',
              onTap: registerTap,
            )
          ],
        ),
      ),
    );
  }
}
