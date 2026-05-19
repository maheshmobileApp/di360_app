import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/register_button.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListingHubMasterCard extends StatelessWidget {
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

  const ListingHubMasterCard(
      {super.key,
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
      this.courseStatus});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: CachedNetworkImageWidget(
                      imageUrl: imageUrl,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorWidget: const Icon(Icons.broken_image,
                          size: 50, color: AppColors.lightGeryColor),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                          noOfSeats != null
                              ? noOfSeats == registerCount
                                  ? "SOLD OUT"
                                  : noOfSeats > 15
                                      ? " FILLING FAST !"
                                      : "HURRY UP!! Only ${noOfSeats - registerCount} SEATS LEFT"
                              : afterWardsPrice == 0.0
                                  ? "FREE MASTERCLASS"
                                  : "PAID",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              // Info section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PRESENTED BY",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.geryColor,
                              radius: 15,
                              child: ClipOval(
                                child: CachedNetworkImageWidget(
                                    imageUrl: profilePic,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                    errorWidget:
                                        Image.asset(ImageConst.prfImg)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              presenterName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4)
                          ],
                        ),
                        Row(
                          children: [
                            _circleIcon(),
                            SizedBox(width: 10),
                            ShareWidget(
                                category: FeedType.learnhub.name,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                size: 20,
                                feedId: feedId ?? ""),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(companyName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type ?? '',
                            style: TextStyles.medium2(color: AppColors.black)),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: AppColors.primaryColor, size: 20),
                            const SizedBox(width: 6),
                            Text("CPD HOURS: ${cpdHours}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyles.medium2(color: AppColors.black)),
                          ],
                        ),
                        if (isRegistered && courseStatus != "PENDING")
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "You purchased this course", //- Access expires in ${expiryDateCount ?? '0'} days.
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.medium2(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        (location.isEmpty)
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: AppColors.primaryColor, size: 20),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      (location.isEmpty) ? "" : "${location}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.medium2(
                                          color: AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 4),
                        (date.isEmpty)
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                      color: AppColors.primaryColor, size: 20),
                                  const SizedBox(width: 6),
                                  Text(
                                      (date.isEmpty)
                                          ? "------"
                                          : DateFormat("dd MMM")
                                              .format(DateTime.parse(date)),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.medium2(
                                          color: AppColors.primaryColor))
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              //Spacer(),
              RegisterButton(
                  text: isRegistered ? "View Course Details" : 'Register Now',
                  onTap: registerTap,
                  isRegistered: isRegistered)
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIcon() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Icon(
            Icons.north_east,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ));
  }
}
