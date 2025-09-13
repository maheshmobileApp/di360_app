import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:flutter/material.dart';

class CloseAddButtonWidget extends StatelessWidget with BaseContextHelpers {
  final Function()? closeBtn;
  final Function()? addBtn;
  final String? btnText;
  const CloseAddButtonWidget({super.key, this.closeBtn,this.addBtn,this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEFEFEF))),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF1E5),
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: TextStyles.medium3(),
                  elevation: 0,
                ),
                onPressed: closeBtn ?? () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ),
          addHorizontal(12),
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: TextStyles.medium3(),
                  elevation: 0,
                ),
                onPressed: addBtn ?? () => Navigator.pop(context),
                child:  Text(btnText ??"Add"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
