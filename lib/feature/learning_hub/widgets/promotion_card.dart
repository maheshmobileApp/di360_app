import 'package:di360_flutter/feature/learning_hub/model_class/get_course_promotions_res.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/promotion_detail_sheet.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionCard extends StatelessWidget {
  final int serialNo;
  final String promotionName;
  final String promoCode;
  final String discount;
  final String validFrom;
  final String validUntil;
  final String status;
  final VoidCallback? onMenuTap;
  final String courseId;
  final CoursePromotions? promotionData;
  final String discountType;
  final String maxDiscountPrice;

  const PromotionCard({
    super.key,
    required this.serialNo,
    required this.promotionName,
    required this.promoCode,
    required this.discount,
    required this.validFrom,
    required this.validUntil,
    required this.status,
    required this.courseId,
    this.onMenuTap,
    this.promotionData,
    required this.discountType,
    required this.maxDiscountPrice,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status.toLowerCase() == 'active';
    final vm = Provider.of<CourseListingViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE8ECF2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promotion name and code
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROMOTION #$serialNo',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF929AAA),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      promotionName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF273247),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFFD0B0),
                  ),
                ),
                child: Text(
                  promoCode,
                  style: const TextStyle(
                    color: Color(0xFFFF791F),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'preview') {
                    await vm.coursePromotionDetails(context, courseId);
                    final data = vm.promotionDetailData?.coursePromotionsByPk;

                    PromotionDetailSheet.show(
                      context,
                      data: data,
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'preview',
                    child: Text('Preview'),
                  ),
                ],
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              color: Color(0xFFEEF0F4),
            ),
          ),

          // Two-column details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetail(
                  'Discount',
                  "${discountType == 'FLAT' ? '₹' : ''} $discount ${discountType == 'FLAT' ? '' : '%'} ${maxDiscountPrice != "" ? '( max ₹$maxDiscountPrice )' : ''} ",
                ),
              ),
              Expanded(
                child: _buildDetail(
                  'Status',
                  status,
                  valueColor: isActive
                      ? const Color(0xFF0BA76B)
                      : const Color(0xFFFF9800),
                  backgroundColor: isActive
                      ? const Color(0xFFE6F7EF)
                      : const Color(0xFFFFF3E0),
                  isBadge: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetail(
                  'Valid From',
                  DateFormatUtils.formatDateOnly(validFrom),
                ),
              ),
              Expanded(
                child: _buildDetail(
                  'Valid Until',
                  DateFormatUtils.formatDateOnly(validUntil),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(
    String title,
    String value, {
    Color? valueColor,
    Color? backgroundColor,
    bool isBadge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF929AAA),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        if (isBadge)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          )
        else
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xFF273247),
            ),
          ),
      ],
    );
  }
}
