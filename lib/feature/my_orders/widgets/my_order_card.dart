import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class MyOrderCard extends StatelessWidget {
  SuppliesOrders? item;
  ValueChanged<String>? onMenuSelected;

  MyOrderCard({super.key, required this.item, this.onMenuSelected});

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
                  tagWidget("Supplier Name", item?.supplier?.businessName ?? "",
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
                  tagWidget("Order Value",
                      "AUD ${item?.totalAmount.toString() ?? ""}", true),
                  tagWidget("Order Status", item?.status ?? "", false, chip : true),
                ],
              ),
              Divider(),
              tagWidget("Last Updated",
                  DateFormatUtils.formatDateToDmy(item?.updatedAt ?? ""), true),
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
        color:text == "PENDING" ?AppColors.primaryColor.withOpacity(0.2): AppColors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyles.medium2(
          color: text == "PENDING" ?AppColors.primaryColor: AppColors.black,
        ),
      ),
    );
  }
}
