import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final String courseName;
  final String presentByName;
  final String cpdHours;
  final String platform;
  final String webinar;
  final String profilePic;
  final String totalPrice;
  final String discountPrice;

  const CourseInfoCardWidget(
      {super.key,
      required this.courseName,
      required this.presentByName,
      required this.cpdHours,
      required this.platform,
      required this.webinar,
      required this.profilePic,
      required this.totalPrice,
      required this.discountPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${courseName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("A Comprehensive Guide",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            const Text("Presented by",
                style: TextStyle(color: Colors.black)),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.geryColor,
                  backgroundImage:
                      profilePic.isNotEmpty ? NetworkImage(profilePic) : null,
                  radius: 30,
                  child: profilePic.isEmpty
                      ? const Icon(Icons.business,
                          size: 20, color: AppColors.lightGeryColor)
                      : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${presentByName}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("A Comprehensive Guide",
                        style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoTextWidget(
                  label: "CPD Duration",
                  value: "${cpdHours}",
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
                  label: "Webinar",
                  first: true,
                  value: "${webinar}",
                ),
                _PriceTextWidget(
                  label: "Price",
                  first: false,
                  originalPrice: "${totalPrice} ",
                  discountedPrice: "${discountPrice}",
                ),
              ],
            ),
          ],
        ),
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
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor)),
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
                fontSize: 12,
                color: Colors.black,
                decoration: TextDecoration.lineThrough, // strike-through
              ),
            ),
            Text(
              "AUD \$${discountedPrice}",
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
