import 'dart:io';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget with BaseContextHelpers {
  final String? title;
  final bool isRequired;
  final Color? titleColor;
  final Function()? onTap;
  final File? imageFile;
  final String? serverImg;
  final VoidCallback? onRemove; 

  const LogoContainer({
    super.key,
    this.title,
    this.isRequired = false,
    this.titleColor,
    this.onTap,
    this.imageFile,
    this.serverImg,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? "",
              style: TextStyles.regular3(color: titleColor ?? AppColors.black),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: onTap,
          child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 2,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            child: Container(
              width: double.infinity,
              height: getSize(context).height * 0.2,
              child: (serverImg != null || imageFile != null)
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        serverImg != null
                            ? CachedNetworkImageWidget(
                                imageUrl: serverImg ?? '',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                imageFile!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: onRemove, // 🔹 Call remove callback
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.timeBgColor,
                          ),
                          child: Image.asset(ImageConst.upload),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Click here to Choose a file.",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "JPEG, PNG formats, up to 5 MB",
                          style: TextStyles.regular2(
                              color: AppColors.dropDownHint),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
