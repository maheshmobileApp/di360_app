import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:flutter/material.dart';

class CountsContainer extends StatelessWidget with BaseContextHelpers {
  final String type;
  final String recipientsCount;
  final String emailsCount;
  final String totalsCount;

  const CountsContainer({
    Key? key,
    required this.recipientsCount,
    required this.emailsCount,
    required this.totalsCount,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _buildCountCard(Icons.group, "Recipients", recipientsCount)),
        addHorizontal(4),
        Expanded(child: _buildCountCard((type == "SMS")?Icons.phone:Icons.email, (type == "SMS")?"Mobile No.":"Emails", emailsCount)),
        addHorizontal(4),
        Expanded(child: _buildCountCard(Icons.check, "Totals", totalsCount)),
      ],
    );
  }

  Widget _buildCountCard(IconData icon, String title, String count) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor),
          Text(title, style: TextStyles.regular3(color: AppColors.black)),
          Text(count,
              style: TextStyles.clashMedium(color: AppColors.buttonColor)),
        ],
      ),
    );
  }
}
