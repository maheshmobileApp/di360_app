import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/orders/model/orders_res.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  SuppliesOrders item;
  ValueChanged<String>? onMenuSelected;

  OrderCard({super.key, required this.item, this.onMenuSelected});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#${item?.orderNumber.toString() ?? ""}",
                    style: TextStyles.bold3(color: AppColors.primaryColor),
                  ),
                  PopupMenuButton<String>(
                    color: AppColors.whiteColor,
                    onSelected: onMenuSelected,
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: "view",
                        child: Row(
                          children: [
                            Icon(Icons.visibility),
                            SizedBox(width: 10),
                            Text("View"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tagWidget("Buyer Name", item?.dentalPractice?.name ?? item?.dentalProfessional?.name ?? "",
                      true),
                  tagWidget(
                      "Order Date",
                      DateFormatUtils.formatDateToDmy(item?.createdAt ?? ""),
                      false),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tagWidget("Items",
                      "Items", true),
                  tagWidget("Order Value", "AUD ${item?.totalAmount.toString()}" ?? "", false),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  tagWidget("Payment mode", item?.paymentMode == "ACCOUNT_PAY"?"Account pay": "" ?? "", true, chip : true),
                  tagWidget("Billing type", item?.billingType ?? "", false, chip : true),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  
                  tagWidget("Order status", item?.status ?? "", true, chip : true),
                  tagWidget("Last updated", DateFormatUtils.formatDateToDmy(item?.updatedAt ?? ""),
                      false),
                ],
              ),
            ],
          )),
    );
  }

  Widget tagWidget(String key, String value, bool place, {bool chip = false}) {
    return Column(
      crossAxisAlignment:
          place ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          key,
          style: TextStyles.medium1(color: AppColors.geryColor),
        ),
        SizedBox(height: 4),
        chip == false
            ? Text(value, style: TextStyles.medium2(color: AppColors.black))
            : chipWidget(value)
      ],
    );
  }

  Widget chipWidget(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color:text == "PENDING" || text == "Account pay" ?AppColors.primaryColor.withOpacity(0.2): AppColors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyles.medium2(
          color: text == "PENDING" || text == "Account pay" ?AppColors.primaryColor: AppColors.black,
        ),
      ),
    );
  }
}
