import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final double? width;
  final TextStyle? hintstyle;
  final Widget? prefixIcon;
  final bool obsecureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String value)? onChange;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final Color? fillcolor;
  final bool? isfilled;
  final int? maxLines;
  final int? maxLength;
  final String? label;
  final OutlineInputBorder? border;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final TextStyle? labelstyle;
  final InputBorder? enableborder;
  final Color? titleColor;
  final Color? enableBorderColor;
  final Color? borderColor;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? canRequestFocus;
  final String? initialValue;
  final Function()? onTap;
  final Function(String?)? onSubmitted;
  final TextInputAction? textInputAction;
  final String? obscuringCharacter;
  final TextCapitalization? textCapitalization;
  final String? suffixText;
  const InputTextField(
      {super.key,
      required this.title,
      this.label,
      this.focusNode,
      this.controller,
      this.textAlign,
      this.maxLines,
      this.isfilled = false,
      this.width,
      this.contentPadding,
      this.onChange,
      this.border,
      this.enableborder,
      this.labelstyle,
      this.fillcolor,
      this.inputFormatters,
      this.keyboardType,
      this.hintText,
      this.obsecureText = false,
      this.suffixIcon,
      this.hintstyle,
      this.prefixIcon,
      this.validator,
      this.borderRadius,
      this.maxLength,
      this.titleColor,
      this.enableBorderColor,
      this.borderColor,
      this.readOnly,
      this.initialValue,
      this.canRequestFocus,
      this.onTap,
      this.onSubmitted,
      this.textInputAction,
      this.obscuringCharacter,
      this.textCapitalization,
      this.suffixText});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == ''
            ? const SizedBox()
            : Text(title, style: TextStyles.regular3(color: AppColors.black)),
        title == '' ? const SizedBox() : const SizedBox(height: 10),
        TextFormField(
          obscuringCharacter: obscuringCharacter ?? '*',
          focusNode:
              focusNode ?? FocusNode(canRequestFocus: canRequestFocus ?? true),
          canRequestFocus: canRequestFocus ?? true,
          initialValue: initialValue,
          onChanged: onChange,
          textInputAction: textInputAction,
          onTap: onTap,
          onFieldSubmitted: onSubmitted,
          controller: controller,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          obscureText: obsecureText,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          textAlign: textAlign ?? TextAlign.start,
          decoration: InputDecoration(
            counterText: '',
            labelStyle: labelstyle,
            fillColor: fillcolor,
            filled: isfilled ?? false,
            enabledBorder: enableborder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColors.HINT_COLOR),
                ),
            suffixText: suffixText,
            labelText: label,
            contentPadding:
                contentPadding ?? const EdgeInsets.fromLTRB(10, 10, 12, 0),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintstyle ??
                TextStyles.dmsansLight(
                    fontSize: 16, color: AppColors.inputHintColor),
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1.5,
                color: borderColor ?? AppColors.inputBorderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1.5,
                color: borderColor ?? AppColors.inputBorderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
