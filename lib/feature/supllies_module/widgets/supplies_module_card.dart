import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class SuppliesModuleCard extends StatelessWidget {
  final Supplies? item;
  final ValueChanged<String>? onMenuSelected;
  final ValueChanged<int>? onStockChanged;

  const SuppliesModuleCard({
    super.key,
    required this.item,
    this.onMenuSelected,
    this.onStockChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Map these values from your Supplies model.
    final String name = item?.name ?? "N/A";
    final String status = item?.status ?? "N/A";

    // Replace these placeholders with actual model fields.
    final String productType = item?.productType == "simple"
        ? "Simple Product"
        : "Product with variant";
    final double price = item?.supplyVariants?.firstOrNull?.sellingPrice;
    final int stock = item?.supplyVariants?.firstOrNull?.availableStock ?? 0;
    final String variants = "N/A";
    final String sohAlert =
        ((item?.supplyVariants?.firstOrNull?.availableStock) ?? 0) > 0
            ? ((item?.minStock) ?? 0) >
                    ((item?.supplyVariants?.firstOrNull?.availableStock) ?? 0)
                ? "Low Stock"
                : "In Stock"
            : "Out of Stock";
    final String? imageUrl = item?.image?.firstOrNull?.url;
    final String notes = "";

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
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 75,
                    height: 75,
                    child: imageUrl != null && imageUrl.isNotEmpty
                        ? NetworkImageWidget(imageUrl: imageUrl)
                        : _imagePlaceholder(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      _chip(
                        productType,
                        const Color(0xFFEDF4FF),
                        const Color(0xFF2563EB),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${price}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Price (Inc GST)",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  color: AppColors.whiteColor,
                  onSelected: onMenuSelected,
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: "view",
                      child: Row(
                        children: [
                          Icon(Icons.visibility_outlined),
                          SizedBox(width: 8),
                          Text("View"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field(
                    "Stock",
                    Text(
                      stock.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _field(
                    "Variants",
                    Text(
                      variants,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field(
                    "SOH Alert",
                    _chip(
                      sohAlert,
                      const Color(0xFFFFF4E8),
                      const Color(0xFFDE6500),
                    ),
                  ),
                ),
                Expanded(
                  child: _field(
                    "Status",
                    _chip(
                      status.toUpperCase(),
                      status.toUpperCase() == "ACTIVE"
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFFEE2E2),
                      status.toUpperCase() == "ACTIVE"
                          ? const Color(0xFF15803D)
                          : const Color(0xFFDC2626),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Notes"),
                  content: Text(
                    notes.isEmpty ? "No notes available" : notes,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "View Notes",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }

  Widget _chip(
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _stockButton(
    IconData icon,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 17,
          color: onTap == null ? Colors.grey : Colors.black87,
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFFF5F6F8),
      child: const Icon(
        Icons.inventory_2_outlined,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}
