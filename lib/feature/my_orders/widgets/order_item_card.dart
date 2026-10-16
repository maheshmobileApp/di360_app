import 'package:di360_flutter/feature/my_orders/model/view_order_res.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final SuppliesOrderItems? item;

  OrderItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Supplier name and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),

          // Serial number and name
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: _buildDetail('Product', item?.supply?.name ?? "")),
              Expanded(
                  child: _buildDetail(
                      'Variant / SKU', item?.supplyVariant?.skuCode ?? "")),
            ],
          ),

          const SizedBox(height: 8),

          // Email and phone
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child:
                      _buildDetail('Unit Price', item?.price.toString() ?? "")),
              Expanded(
                  child: _buildDetail(
                      'Ordered QTY', item?.quantity.toString() ?? "")),
            ],
          ),

          const SizedBox(height: 8),

          // ABN and billing address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetail(
                    'Received QTY', item?.sentQuantity.toString() ?? ""),
              ),
              Expanded(
                child: _buildDetail(
                    'Back Order QTY', item?.quantity.toString() ?? ""),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF98A2B3),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF344054),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
