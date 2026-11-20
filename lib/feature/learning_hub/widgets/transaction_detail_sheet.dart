import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_transaction_detail_res.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class TransactionDetailSheet extends StatelessWidget {
  final GetTransactionDetailRes? data;

  const TransactionDetailSheet({
    super.key,
    required this.data,
  });

  static void show(
    BuildContext context, {
    final GetTransactionDetailRes? data,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TransactionDetailSheet(
        data: data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Transaction Details',
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
                    _heading('COURSE'),
                    _detail("Course Name", data?.courseName ?? ''),
                    _detail("Supplier", data?.supplierName ?? ''),
                    _heading('BUYER'),
                    _detail("Name", data?.buyerFirstName ?? ''),
                    _detail("Email", data?.buyerEmail ?? ''),
                    _detail("Phone", data?.buyerPhone ?? ''),
                    _heading('PAYMENT'),
                    _detail(
                        "Total Amount Paid","A\$ ${data?.totalAmount?.toStringAsFixed(2)}" , isActive: true),
                    _detail("Course Price", "A\$ ${data?.coursePrice?.toStringAsFixed(2)}" ),
                    _detail("Discount", "A\$ ${data?.discountAmount?.toStringAsFixed(2)}" ),
                    _detail("Admin Commission",
                        "A\$ ${data?.adminCommission?.toStringAsFixed(2)}" ),
                    _detail(
                        "Supplier Amount", "A\$ ${data?.supplierAmount?.toStringAsFixed(2) ?? ''}" ),
                    _detail("Date", DateFormatUtils.formatTwoDateTime(data?.createdAt ?? '')),
                  ]),
            )));
  }

  Widget _heading(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.bold2(color: AppColors.black),
        ),
        const SizedBox(height: 2),
        Divider()
      ],
    );
  }

  Widget _detail(String title, String value, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.medium1(
              color: const Color(0xFF929BAD),
            ),
          ),
          Text(
            value,
            style: isActive ? TextStyles.bold2(
              color: AppColors.black,
            ): TextStyles.medium2(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
