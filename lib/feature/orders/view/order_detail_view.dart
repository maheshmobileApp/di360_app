import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/my_orders/widgets/order_history_card.dart';
import 'package:di360_flutter/feature/my_orders/widgets/order_item_card.dart';
import 'package:di360_flutter/feature/orders/model/view_order_res.dart';
import 'package:di360_flutter/feature/orders/view_model/orders_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OrdersViewModel>();
    final data = vm.viewOrderData?.suppliesOrdersByPk;
    return Scaffold(
      appBar: AppBarWidget(
        title: "Order View",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _orderInformation(data),
            const SizedBox(height: 10),
            _orderSummary(data),
            const SizedBox(height: 10),
            _orderItems(vm),
            const SizedBox(height: 10),
            _orderHistory(vm),
            const SizedBox(height: 10),
            /*if (data?.suppliesOrderNotes?.isNotEmpty == true)
              _supplierNotes(data?.suppliesOrderNotes?.first.message ?? ""),
            const SizedBox(height: 10),*/
            _buttonSection(context, data)
          ],
        ),
      ),
    );
  }
}

Widget _orderInformation(SuppliesOrdersByPk? data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("1. Order Information",
            style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        _textWidget("Buyer / Client Name", data?.dentalPractice?.businessName ?? data?.dentalProfessional?.businessName ?? "" ),
        _textWidget("Contact Person", data?.dentalPractice?.name ?? data?.dentalProfessional?.name ?? "" ),
        _textWidget("Order Date", data?.createdAt ?? ""),
        
      ],
    ),
  );
}

Widget _orderSummary(SuppliesOrdersByPk? data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("2. Order Summary", style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        Text("Price Breakdown", style: TextStyles.clashSemiBold(fontSize: 14)),
        const SizedBox(height: 4),
        _textWidget("Items subtotal (unit price x quantity)",
            "AUD ${data?.subTotal?.toStringAsFixed(2) ?? ""}"),
        _textWidget(
            "Order discount", "AUD ${data?.couponDiscount?.toStringAsFixed(2)}"),
        _textWidget("Shipping charges",
            "AUD ${data?.deliveryCharge?.toStringAsFixed(2) ?? ""}"),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order total",
              style: TextStyles.clashSemiBold(fontSize: 16),
            ),
            Text(
              "AUD ${data?.totalAmount?.toStringAsFixed(2) ?? ""}",
              style: TextStyles.clashSemiBold(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Amounts use the prices and charges saved with this order. Free items are included at no charge.",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828181),
          ),
        )
      ],
    ),
  );
}

Widget _orderItems(OrdersViewModel vm) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("3. Order Items", style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.viewOrderData?.suppliesOrdersByPk?.suppliesOrderItems
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            return OrderItemCard(
                item: vm.viewOrderData?.suppliesOrdersByPk
                    ?.suppliesOrderItems?[index]);
          },
        ),
      ],
    ),
  );
}

Widget _orderHistory(OrdersViewModel vm) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("4. Order History", style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.viewOrderData?.suppliesOrdersByPk?.suppliesOrderHistory
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            return OrderHistoryCard(
                item: vm.viewOrderData?.suppliesOrdersByPk
                    ?.suppliesOrderHistory?[index]);
          },
        ),
      ],
    ),
  );
}

Widget _supplierNotes(String notes) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("5. Supplier Notes",
            style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        Text(notes,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

_buttonSection(BuildContext context,SuppliesOrdersByPk? supplier) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Column(
          children: [
            _containerWidget("Download Summary", false, () {}),
            const SizedBox(height: 10),
            _containerWidget("Dispatch Order", true, () {}),
          ],
        )
      ],
    ),
  );
}

Widget _containerWidget(String title, bool status, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: status ? AppColors.primaryColor : Colors.white,
        ),
        child: Text(title,
            style: TextStyles.medium2(
                color: status ? AppColors.whiteColor : AppColors.black))),
  );
}

Widget _textWidget(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF828181),
            ),
          ),
        ),
        const Text(
          " : ",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828181),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
