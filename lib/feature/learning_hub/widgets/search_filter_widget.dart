import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SearchFilterWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onFilterTap;
  final VoidCallback? onClearFilter;
  final bool showClearFilter;

  const SearchFilterWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onFilterTap,
    this.onClearFilter,
    this.showClearFilter = false,
  });

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
                onFieldSubmitted: (value) => onSearch(),
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: TextStyles.dmsansLight(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (controller.text.isNotEmpty) {
                        onSearch();
                      }
                    },
                    child: Icon(Icons.search, color: AppColors.black),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onFilterTap,
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
            if (showClearFilter && onClearFilter != null)
              GestureDetector(
                onTap: onClearFilter,
                child: Icon(Icons.close, color: AppColors.black),
              ),
          ],
        ),
      ),
    );
  }
}
