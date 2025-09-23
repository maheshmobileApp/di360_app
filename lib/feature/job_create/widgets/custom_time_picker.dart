import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final String? text;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool? isRequired;
  final String? title;

  const CustomTimePicker({
    Key? key,
    required this.controller,
    this.onTap,
    this.text,
    this.hintText,
    this.validator,
    this.isRequired,
    this.title,
  }) : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (title != "")
        Row(
          children: [
            Text(
              title ?? "",
              style: TextStyles.regular3(color: AppColors.black),
            ),
            if (isRequired ?? false)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        readOnly: true,
        onTap: onTap ?? () => _selectTime(context), // 👈 default to time picker
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              ImageConst.clock,
              width: 20,
              height: 20,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 12, 0),
          hintText: hintText ?? "Time",
          hintStyle: TextStyles.regular4(color: AppColors.dropDownHint),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.0,
              color: AppColors.HINT_COLOR,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.0,
              color: AppColors.inputBorderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.red,
            ),
          ),
        ),
      )
    ]);
  }
}
