import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/promotion_detail_res.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionDetailSheet extends StatelessWidget {
  final CoursePromotionsByPk? data;

  const PromotionDetailSheet({
    super.key,
    required this.data,
  });

  static void show(
    BuildContext context, {
    final CoursePromotionsByPk? data,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PromotionDetailSheet(
        data: data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);

    final coursePrice = vm.courseData?.coursesByPk?.afterwardsPrice ?? 0.0;
    final discountAmount = data?.discountType == "FLAT"
        ? data?.discountValue
        : (coursePrice * (data?.discountValue ?? 0) / 100);
    final finalPrice = coursePrice - discountAmount;

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      data?.promotionName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF17243F),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xFF536078)),
                    style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F3F9)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  data?.promoCode?.toUpperCase() ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFF9800),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Divider(height: 1, color: Color(0xFFEDF0F5)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data?.discountType == "FLAT" ? "\$ " : ""}${data?.discountValue?.toStringAsFixed(0) ?? ''} ${data?.discountType == "FLAT" ? "flat off" : "% off"} ${data?.maxDiscountAmount != null ? "(capped at ${data?.maxDiscountAmount.toStringAsFixed(0)}  )" : ""}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getColor(data?.status?.toUpperCase())
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data?.status?.toUpperCase() ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getColor(data?.status?.toUpperCase()),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            _discountCard(
                coursePrice?.toStringAsFixed(0),
                discountAmount?.toStringAsFixed(0),
                finalPrice?.toStringAsFixed(0),
                data),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _detail(
                                'ELIGIBLE USERS',
                                data?.eligibleUserType ==
                                        "DENTAL_INTERFACE_USERS"
                                    ? "Dental Interface Users"
                                    : data?.eligibleUserType == "ALL_USERS"
                                        ? "All Users"
                                        : data?.eligibleUserType ==
                                                "GUEST_USERS"
                                            ? "Guest Users"
                                            : "")),
                        Expanded(
                            child: _detail(
                                'VALID FROM',
                                DateFormatUtils.formatDateToDmy(
                                    data?.validFrom ?? ''))),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _detail(
                                'VALID UNTIL',
                                DateFormatUtils.formatDateToDmy(
                                    data?.validUntil ?? ''))),
                        Expanded(
                          child: _detail(
                              'USAGE LIMIT',
                              data?.usageLimit == null
                                  ? "Unlimited"
                                  : data?.usageLimit.toString() ?? "",
                              isBadge: false,
                              isActive: true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _detail('USAGE COUNT',
                                data?.usedCount?.toString() ?? '')),
                        Expanded(
                            child: _detail('MAX DISCOUNT CAP',
                                data?.maxDiscountAmount?.toString() ?? '')),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _detail(
                                'CREATED BY', data?.createdByRole ?? '')),
                        Expanded(
                            child: _detail(
                                'CREATED AT',
                                DateFormatUtils.formatDateTime(
                                    data?.createdAt ?? ''))),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _detail(
                                'LAST UPDATED',
                                DateFormatUtils.formatDateTime(
                                    data?.updatedAt ?? ''))),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(text) {
    if (text == "EXPIRED") {
      return AppColors.redColor;
    } else if (text == "ACTIVE") {
      return AppColors.greenColor;
    } else if (text == "INACTIVE") {
      return AppColors.blueColor;
    } else {
      return AppColors.primaryColor;
    }
  }

  Widget _discountCard(String coursePrice, String discountAmount,
      String finalPrice, CoursePromotionsByPk? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _detail("ORIGINAL PRICE", "\$ $coursePrice", cross: true),
                    SizedBox(width: 10),
                    _detail(
                        "DISCOUNT",
                        data?.discountType == "FLAT"
                            ? "- \$ ${data?.discountValue?.toStringAsFixed(0) ?? ''} "
                            : "-\$ $discountAmount (${data?.discountValue?.toStringAsFixed(0) ?? ''} %)",
                        red: true),
                  ],
                ),
                _detail("FINAL PRICE", "\$ $finalPrice"),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Divider(
              height: 1,
              color: const Color(0xFFEDF0F5),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
                "User saves ${data?.discountValue?.toStringAsFixed(0) ?? ''} % (\$ ${discountAmount})  on this course",
                style: TextStyles.medium2(color: AppColors.greenColor)),
          ],
        ),
      ),
    );
  }

  Widget _detail(String title, String value,
      {bool isBadge = false,
      bool isActive = false,
      bool red = false,
      bool cross = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF929BAD),
          ),
        ),
        const SizedBox(height: 8),
        if (isBadge)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFFE5F7EE) : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                decoration: cross ? TextDecoration.lineThrough : null,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? const Color(0xFF0BA75D)
                    : const Color(0xFFFF9800),
              ),
            ),
          )
        else
          Text(
            value.isEmpty ? '-' : value,
            style: TextStyle(
              decoration: cross ? TextDecoration.lineThrough : null,
              fontSize: 14,
              height: 1.5,
              color: red ? AppColors.redColor : AppColors.black,
            ),
          ),
      ],
    );
  }
}
