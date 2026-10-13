import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SuppliesInformationCard extends StatelessWidget {
  final Supplies? suppliesDetails;

  const SuppliesInformationCard({
    required this.suppliesDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.storefront_outlined,
                          size: 18, color: AppColors.primaryColor),
                      const SizedBox(width: 4),
                      Text("SUPPLIER INFORMATION",
                          style: TextStyles.bold2(color: Colors.black)),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  _infoRow("Supplier",
                      suppliesDetails?.dentalSupplier?.businessName ?? ''),
                  _infoRow("Location", "Melbourne, VIC, Australia"),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          height: 40,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          title: "View Supplier",
                          fontSize: 12,
                          prefixIcon: Icons.person,
                          outlined: true,
                          backgroundColor: Colors.white,
                          borderColor: Colors.grey.shade300,
                          textColor: Colors.black87,
                          iconColor: Colors.black87,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          height: 40,
                          title: "Send Enquiry",
                          fontSize: 12,
                          prefixIcon: Icons.mail,
                          outlined: true,
                          backgroundColor: Colors.white,
                          borderColor: Colors.grey.shade300,
                          textColor: Colors.black87,
                          iconColor: Colors.black87,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ]),
          )),
    );
  }
}

_infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.medium2(color: Colors.grey.shade700)),
        Text(value, style: TextStyles.bold2()),
      ],
    ),
  );
}