import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryCodeNumberFeild<T> extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  final T? value;
  final dynamic Function(T?)? onChanged;
  final TextEditingController? textController;
  final Widget? suffixIcon;
  final Function(String)? textFeildChanged;
  const CountryCodeNumberFeild(
      {super.key,
      this.value,
      this.onChanged,
      this.textController,
      this.suffixIcon,
      this.textFeildChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Label (like other fields)
        RichText(
          text: TextSpan(
            text: "Mobile Number ",
            style: TextStyles.regular3(color: AppColors.black),
            children: const [
              TextSpan(text: "*", style: TextStyle(color: Colors.red))
            ],
          ),
        ),

        SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 125,
              child: CustomDropDown(
                  value: value,
                  title: '',
                  onChanged: (v) => onChanged?.call(v as T?),
                  items: const [
                    DropdownMenuItem(value: '+61', child: Text('AU (+61)')),
                    DropdownMenuItem(value: '+64', child: Text('NZ (+64)')),
                  ],
                  hintText: "",
                  isRequired: false),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  InputTextField(
                      controller: textController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                      ],
                      hintText: 'Enter mobile number',
                      suffixIcon: suffixIcon,
                      onChange: textFeildChanged,
                      validator: validateEmptyPhoneNumber),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
