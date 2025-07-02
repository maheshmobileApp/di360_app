import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<Object>> items;
  final Function(Object?) onChanged;
  // final List<DropdownMenuEntry<Object?>> dropdownMenuEntries;
  final Function()? onTap;
  final String hintText;
  final Color? bgcolor;
  final BoxDecoration? decoration;
  final TextStyle? style;
  final TextStyle? hintstyle;
  final Object? value;
  final bool isRequired;
  final Color? titleColor;
  const CustomDropDown(
      {super.key,
      required this.title,
      this.style,
      this.hintstyle,
      required this.items,
      required this.onChanged,
      required this.hintText,
      this.value,
      this.decoration,
      this.bgcolor,
      this.onTap,
      this.isRequired = false,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.regular3(color: titleColor ?? AppColors.black),
            ),
            if (isRequired)
              Text(
                ' *',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Rounded corners
            border: Border.all(
              color: AppColors.geryColor, // Border color
              width: 1.5, // Border width
            ),
          ),
          child: Row(
            
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                  elevation: 1,
                  // style: TextStyles.regular4(),
                  // padding: EdgeInsets.only(left: 8, right: 8,top: 2),
                  items: items,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.black,
                  ),
                  value: value,
                  hint: Text(
                    hintText,
                    //  style: TextStyles.para2(),
                    style: TextStyles.regular4(color: AppColors.dropDownHint)
                  ),
                  onChanged: onChanged,
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
