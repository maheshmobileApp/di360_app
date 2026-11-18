import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class AddressTypeRadioWidget extends StatelessWidget {
  final String? selectedAddressType;
  final ValueChanged<String> onChanged;

  const AddressTypeRadioWidget({
    super.key,
    required this.selectedAddressType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const addressTypes = [
      'Home',
      'Work',
      'Other',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
                "Address Type",
                style:
                    TextStyles.regular3(color: AppColors.black),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: addressTypes.map((type) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                  value: type,
                  groupValue: selectedAddressType,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                    }
                  },
                ),
                Text(type),
                const SizedBox(width: 12),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}