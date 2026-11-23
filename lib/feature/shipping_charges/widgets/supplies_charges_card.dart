import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ShippingMethodCard extends StatelessWidget {
  final String title;
  final int minOrderVal;
  final dynamic standardPrice;
  final int expressPrice;
  final String status;
  final ValueChanged<String>? onMenuSelected;
  final int minProducts;

  const ShippingMethodCard({
    super.key,
    required this.title,
    required this.minOrderVal,
    required this.standardPrice,
    required this.expressPrice,
    required this.status,
    this.minProducts = 0,
    this.onMenuSelected,
  });

  bool get isActive => status.toUpperCase() == "ACTIVE";

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF16A34A);
    const grey = Color(0xFF808898);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isActive ? green : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon, status and menu
          Row(
            children: [
              Icon(
                _getIcon(title),
                color: AppColors.greenColor,
                size: 28,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.greenColor : grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Title
          Text(
            _getTitle(title),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF171E30),
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            _getDescription(title, minOrderVal, minProducts),
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF7C8595),
            ),
          ),

          const SizedBox(height: 10),

          // Standard delivery
          _priceBox(
            label: "STANDARD",
            price: title == "FREE_ALL" ? "Free" : "\$ ${standardPrice.toString()}",
          ),

          const SizedBox(height: 10),

          // Express delivery
          _priceBox(
            label: "EXPRESS",
            price: title == "FREE_ALL" ? "N/A" : "\$ ${expressPrice.toString()}",
          ),

          const SizedBox(height: 10),
          const Divider(
            color: Color(0xFFE5E7EB),
          ),
          const SizedBox(height: 0),

          Text(
            "Status: ${isActive ? 'Active' : status}",
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Color(0xFF8B94A5),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(title) {
     if (title == "FREE_OVER_VALUE") {
      return Icons.shopping_cart;
    } else if (title == "FREE_OVER_PRODUCTS") {
      return Icons.shopping_bag;
    } else if (title == "FREE_ALL") {
      return Icons.local_shipping;
    } else if (title == "FLAT_RATE") {
      return Icons.local_shipping;
    }
    return Icons.local_shipping;
  }

  String _getTitle(String title) {
    if (title == "FREE_OVER_VALUE") {
      return "Free over value";
    } else if (title == "FREE_OVER_PRODUCTS") {
      return "Free over quantity";
    } else if (title == "FREE_ALL") {
      return "Free shipping";
    } else if (title == "FLAT_RATE") {
      return "Flat rate";
    }
    return "Free over value";
  }

  String _getDescription(String title, int minOrderValue, int minProducts) {
    if (title == "FREE_OVER_VALUE") {
      return "Free above \$ ${minOrderValue.toString()} order value";
    } else if (title == "FREE_OVER_PRODUCTS") {
      return "Free at ${minProducts.toString()}+ items in car";
    } else if (title == "FREE_ALL") {
      return "Applies to every order";
    } else if (title == "FLAT_RATE") {
      return "Applies to every order";
    }
    return "Free";
  }

  Widget _priceBox({
    required String label,
    required String price,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFE1E5EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7D8594),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            price,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF171E30),
            ),
          ),
        ],
      ),
    );
  }
}
