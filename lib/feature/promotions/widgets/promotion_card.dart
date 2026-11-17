import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/promotions/model/get_promotions_res.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class PromotionCard extends StatelessWidget {
  final SupplyPromotions? item;

  const PromotionCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final appliesCount = item?.supplyPromotionItems
            ?.where((e) => e.itemRole == "APPLIES")
            .length ??
        0;
    return Card(
      elevation: 2,
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field("Promotion Name", item?.name ?? ""),
                ),
                Expanded(
                  child: _field("Applicable Products",
                      "${appliesCount.toString()} Products"),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field("Type", item?.type ?? "", box: true),
                ),
                Expanded(
                  child: _field("Scope", item?.scope ?? ""),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: _field("Validity",
                        "${DateFormatUtils.formatDateOnly(item?.startDate ?? "")} - ${DateFormatUtils.formatDateOnly(item?.endDate ?? "")} ")),
                Expanded(
                  child: _field("Status", item?.status ?? "", box: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String key, String value, {bool box = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 7),
        box
            ? _chip(
                value,
                _getColor(value).withValues(alpha: 0.1),
                _getColor(value),
              )
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
      ],
    );
  }

  Color _getColor(String text) {
    if (text == "ACTIVE") {
      return AppColors.greenColor;
    } else if (text == "EXPIRED") {
      return AppColors.redColor;
    } else if (text == "INACTIVE") {
      return AppColors.blueColor;
    } else {
      return AppColors.primaryColor;
    }
  }

  Widget _chip(
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
