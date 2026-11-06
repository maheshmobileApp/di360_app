import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_transactions_res.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/campaign_detail_sheet.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/transaction_detail_sheet.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransactionData? transactionData;

  const TransactionCard({
    super.key,
    this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF2)),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionData?.buyerName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'preview') {
                    await vm.getTransactionDetail(
                        context, transactionData?.id ?? '');
                    final data = vm.getTransactionDetailRes;
                    TransactionDetailSheet.show(
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
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEF0F4)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _detail(
                  'Stripe ID',
                  transactionData?.stripePaymentIntentId ?? '',
                ),
              ),
              Expanded(
                child: _detail(
                  'Amount',
                  transactionData?.totalAmount.toString() ?? '',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _detail(
                    'Status', transactionData?.transactionStatus ?? '',
                    color: AppColors.greenColor.withOpacity(0.1),
                    textColor: AppColors.greenColor),
              ),
              Expanded(
                  child: _detail(
                'Date',
                transactionData?.createdAt != null
                    ? DateFormatUtils.formatDateToDmy(
                        transactionData?.createdAt ?? '')
                    : '',
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detail(
    String title,
    String value, {
    Color? color,
    Color? textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF929AAA),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        if (color != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF273247),
            ),
          ),
      ],
    );
  }
}
