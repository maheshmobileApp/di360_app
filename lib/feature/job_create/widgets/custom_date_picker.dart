import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final String? text;
 final String? hintText;

  const CustomDatePicker({
    Key? key,
    required this.controller,
    this.onTap,
    this.text, this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true, 
      onTap: onTap,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon:Image.asset(ImageConst.calender),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 12, 0),
        hintText: hintText??"Date",
        hintStyle: TextStyles.regular4(color: AppColors.dropDownHint),
         enabledBorder:
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(  8),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: AppColors.HINT_COLOR,
                  ),
                ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.inputBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.inputBorderColor,
          ),
        ),
      ),
    );
  }
}
