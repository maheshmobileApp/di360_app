import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactInfoWidget extends StatelessWidget {
  final String location;
  final String email;
  final String phoneNumber;

  const ContactInfoWidget({
    Key? key,
    required this.location,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  Widget _buildRow(String iconPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style:   TextStyles.medium3(color: AppColors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CONTACT DETAILS",
            style:  TextStyles.medium2(color: AppColors.primaryColor),
          ),
           const SizedBox(height: 6),
          _buildRow(ImageConst.contactLocation, location),
          const SizedBox(height: 6),
          _buildRow(ImageConst.contactMail, email),
          const SizedBox(height: 6),
          _buildRow(ImageConst.contactPhone, phoneNumber),
        ],
      ),
    );
  }
}
