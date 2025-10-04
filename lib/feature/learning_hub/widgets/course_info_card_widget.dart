import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/media_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final String courseName;
  final String presentByName;
  final String cpdHours;
  final String platform;
  final String webinar;
  final String profilePic;
  final String totalPrice;
  final String discountPrice;
  final String startDate;
  final String endDate;
  final String time;
  final String bannerUrl;
  final String bannerName;

  const CourseInfoCardWidget(
      {super.key,
      required this.courseName,
      required this.presentByName,
      required this.cpdHours,
      required this.platform,
      required this.webinar,
      required this.profilePic,
      required this.totalPrice,
      required this.discountPrice,
      required this.startDate,
      required this.endDate,
      required this.time,
      required this.bannerUrl,
      required this.bannerName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              
              Container(
                height: 50,
                width: 5,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${courseName}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("A Comprehensive Guide",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PRESENTED BY",
                        style: TextStyles.medium1(color: AppColors.black)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
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
                        const SizedBox(width: 10),
                        Text("${presentByName}".toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Divider(),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoTextWidget(
                      label: "Date",
                      value: (startDate.isEmpty && endDate.isEmpty)
                          ? "Not Specified"
                          : "${DateFormat("d MMM").format(DateTime.parse("${startDate}"))} - ${DateFormat("d MMM").format(DateTime.parse("${endDate}"))} ",
                      first: true,
                    ),
                    _InfoTextWidget(
                      label: "Platform",
                      first: false,
                      value: "${platform}",
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoTextWidget(
                      label: "CPD Hours",
                      first: true,
                      value: "${cpdHours}",
                    ),
                    _InfoTextWidget(
                      label: "Price",
                      first: true,
                      value: "\$${totalPrice}",
                    ),
                    /* _PriceTextWidget(
                label: "Price",
                first: false,
                originalPrice: "${totalPrice} ",
                discountedPrice: "${discountPrice}",
              ),*/
                  ],
                ),
                const SizedBox(height: 10),
                MediaWidget(
                  url: bannerUrl,
                  name: bannerName,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTextWidget extends StatelessWidget {
  final String label;
  final String value;

  final bool first;

  const _InfoTextWidget({
    required this.label,
    required this.value,
    required this.first,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          first ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(width: 4),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black)),
      ],
    );
  }
}

class _PriceTextWidget extends StatelessWidget {
  final String label;

  final String originalPrice;
  final String discountedPrice;

  final bool first;

  const _PriceTextWidget({
    required this.label,
    required this.first,
    required this.originalPrice,
    required this.discountedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          first ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(
              color: AppColors.lightGeryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              "\$${originalPrice}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                decoration: TextDecoration.lineThrough, // strike-through
              ),
            ),
            Text(
              "AUD \$${discountedPrice}",
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.activesendary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
