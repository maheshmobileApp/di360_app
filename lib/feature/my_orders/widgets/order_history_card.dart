import 'package:di360_flutter/feature/my_orders/model/view_order_res.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class OrderHistoryCard extends StatelessWidget {
  final SuppliesOrderNotes? item;

  OrderHistoryCard({
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
                  child: _buildDetail('Date & Time', DateFormatUtils.formatDateTime(item?.createdAt ?? ""))),
              Expanded(
                  child: _buildDetail(
                      'Invoice Number', "")),
            ],
          ),

          const SizedBox(height: 8),

          // Email and phone
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child:
                      _buildDetail('Attachments', "N/A")),
              Expanded(
                  child: _buildDetail(
                      'Postal Service', "")),
            ],
          ),

          const SizedBox(height: 8),

          // ABN and billing address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetail(
                    'Tracking Number',  ""),
              ),
              Expanded(
                child: _buildDetail(
                    'Sent QTY', ""),
              ),
            ],
          ),

           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetail(
                    'Status', item?.status ?? ""),
              ),
              Expanded(
                child: _buildDetail(
                    'Activity', item?.message?? ""),
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
