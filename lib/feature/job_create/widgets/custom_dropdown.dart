import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final Function()? onTap;
  final String hintText;
  final Color? bgcolor;
  final BoxDecoration? decoration;
  final TextStyle? style;
  final TextStyle? hintstyle;
  final T? value;
  final bool isRequired;
  final Color? titleColor;
  final String? Function(T?)? validator;

  const CustomDropDown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.value,
    this.style,
    this.hintstyle,
    this.decoration,
    this.bgcolor,
    this.onTap,
    this.isRequired = false,
    this.titleColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       if(title.isNotEmpty) Row(
          children: [
            Text(
              title,
              style: TextStyles.regular3(color: titleColor ?? AppColors.black),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          validator: validator,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            filled: bgcolor != null,
            fillColor: bgcolor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.geryColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.geryColor, width: 1.5),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.black),
          hint: Text(
            hintText,
            style: hintstyle ?? TextStyles.regular4(color: AppColors.dropDownHint),
          ),
          items: items,
        ),
      ],
    );
  }
}
