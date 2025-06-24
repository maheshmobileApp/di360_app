import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget with BaseContextHelpers {
  final List<DropdownMenuItem>? items;
  final String? prefixImage;
  final String? value;
  final String? hintText;
  final Function(dynamic)? onChanged;
  const DropDownTextField(
      {super.key,
      this.prefixImage,
      this.items,
      this.onChanged,
      this.value,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.HINT_COLOR),
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton(
              hint: hintText != null ? Text(hintText ?? '') : null,
              underline: Container(),
              isExpanded: true,
              value: value,
              selectedItemBuilder: (context) =>
                  List.generate(items!.length, (index) {
                return Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 8,
                    ),
                    items![index].child,
                  ],
                );
              }),
              style: TextStyle(
                color: AppColors.PRIMARY_BLACK_COLOR,
                fontSize: 16,
              ),
              items: items,
              onChanged: onChanged,
            ),
          ),
          addHorizontal(3)
        ],
      ),
    );
  }
}
