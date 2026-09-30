import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class StockStatusWidget extends StatelessWidget {
  final String label;
  final Color color;

  const StockStatusWidget({
    super.key,
    this.label = 'In Stock',
    this.color = const Color(0xFF009B77),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyles.medium2(color: color),
        ),
      ],
    );
  }
}