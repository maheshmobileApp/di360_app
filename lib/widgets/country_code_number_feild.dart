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
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 125,
            child: CustomDropDown(
              value: value,
              title: "Phone Number",
              onChanged: (v) => onChanged?.call(v as T?),
              items: [
                DropdownMenuItem(value: '+61', child: Text('AU (+61)')),
                DropdownMenuItem(value: '+64', child: Text('NZ (+64)')),
              ],
              hintText: "Select country code",
              isRequired: true,
            ),
          ),
          addHorizontal(5),
          Expanded(
              child: InputTextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  hintText: 'Enter phone number',
                  suffixIcon: suffixIcon,
                  onChange: textFeildChanged,
                  validator: validateEmptyPhoneNumber))
        ]);
  }
}
