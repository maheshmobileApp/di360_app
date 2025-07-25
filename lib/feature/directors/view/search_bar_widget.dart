import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatelessWidget with BaseContextHelpers {
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final Function()? searchIconAction;
  final Function()? filterIconAction;
  final bool? closeIconVal;
  final Function()? closeIconAction;
  const SearchBarWidget(
      {super.key,
      this.controller,
      this.onFieldSubmitted,
      this.searchIconAction,
      this.filterIconAction,
      this.closeIconVal,
      this.closeIconAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: onFieldSubmitted,
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: TextStyles.dmsansLight(
                      color: AppColors.black, fontSize: 18),
                  suffixIcon: GestureDetector(
                      onTap: searchIconAction,
                      child: Icon(Icons.search, color: AppColors.black)),
                  border: InputBorder.none,
                ),
              ),
            ),
            addHorizontal(12),
            GestureDetector(
              onTap: filterIconAction,
              child: CircleAvatar(
                radius: 23,
                backgroundColor: AppColors.HINT_COLOR,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.whiteColor,
                  child: SvgPicture.asset(
                    ImageConst.filter,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            if (closeIconVal == true)
              GestureDetector(
                onTap: closeIconAction,
                child: Icon(Icons.close, color: AppColors.black),
              )
          ],
        ),
      ),
    );
  }
}
