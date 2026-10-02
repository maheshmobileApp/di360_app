import 'package:flutter/material.dart';

class AccountPayRequestsCard extends StatelessWidget {
  final String serialNo;
  final String supplierName;
  final String name;
  final String email;
  final String phoneNo;
  final String abnNumber;
  final String billingAddress;
  final String status;
  final String? notes;
  final VoidCallback? onNotesTap;

  const AccountPayRequestsCard({
    super.key,
    required this.serialNo,
    required this.supplierName,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.abnNumber,
    required this.billingAddress,
    required this.status,
    this.notes,
    this.onNotesTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = status.toLowerCase() == 'pending';

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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SUPPLIER NAME',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF98A2B3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      supplierName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF344054),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFFFF8EB)
                      : const Color(0xFFF0FFF9),
                  border: Border.all(
                    color: isPending
                        ? const Color(0xFFFFD58A)
                        : const Color(0xFF6CE9A6),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: isPending
                          ? const Color(0xFFB54708)
                          : const Color(0xFF039855),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isPending
                            ? const Color(0xFFB54708)
                            : const Color(0xFF039855),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          const Divider(
            height: 1,
            color: Color(0xFFEAECF0),
          ),
          const SizedBox(height: 8),

          // Serial number and name
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDetail('Name', name)),
                Expanded(child: _buildDetail('Email', email)),
            ],
          ),

          const SizedBox(height: 8),

          // Email and phone
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Expanded(child: _buildDetail('Phone No', phoneNo)),
              Expanded(child: _buildDetail('ABN Number', abnNumber)),
            ],
          ),

          const SizedBox(height: 8),

          // ABN and billing address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetail('Billing Address', billingAddress),
              ),
              Expanded(
                child: _buildDetail('Notes', notes ?? '-'),
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

