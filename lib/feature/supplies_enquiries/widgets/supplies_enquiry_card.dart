import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_res.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class SuppliesEnquiryCard extends StatelessWidget {
  final SupplyEnquiries item;
  final ValueChanged<String>? onMenuSelected;

  const SuppliesEnquiryCard({
    super.key,
    required this.item,
    this.onMenuSelected,
  });

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
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: NetworkImageWidget(
                        imageUrl: item.supply?.image?.firstOrNull?.url ?? "",
                        fit: BoxFit.contain,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _field("Product Name", item.supply?.name ?? ""),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _field(
                            "Enquiry Date",
                            DateFormatUtils.formatDateOnly(
                                item.createdAt ?? ""))),
                    Expanded(
                        child: _field(
                            "Name",
                            item.dentalSupplier?.name ??
                                item.dentalProfessional?.name ??
                                item.dentalPractice?.name ??
                                "")),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _field(
                            "Phone No",
                            item.dentalSupplier?.phone ??
                                item.dentalProfessional?.phone ??
                                item.dentalPractice?.phone ??
                                "")),
                    Expanded(
                        child: _field(
                            "Email",
                            item.dentalSupplier?.email ??
                                item.dentalProfessional?.email ??
                                item.dentalPractice?.email ??
                                "")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, String child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          child,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight(600),
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
