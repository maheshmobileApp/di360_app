
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/model/certificates.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CertificatesView extends StatelessWidget {
  final String? label;
  final List<FileUpload>? certificates;
  final Widget? icon;
  const CertificatesView({
    super.key,
    this.label,
    required this.certificates,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
  if(certificates != null)  return   Wrap(
      direction: Axis.horizontal,
      spacing: 1,
      runSpacing: 2,
      children:  certificates!.map<Widget>((type) {
        return Padding(
          padding: EdgeInsets.all(2.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.timeBgColor,
              borderRadius: BorderRadius.circular(16), // Adjust radius here
            ),
            child: InkWell(
              onTap: () {
                navigationService.push(HorizantalPdf(
                    // key: ValueKey(
                    //   pdf?.url ?? '',
                    // ),
                    fileUrl: type.url ?? '',
                    fileName: '',
                    isfullScreen: true,
                  ));
              },
              child: Column(
                children: [
                     SvgPicture.asset(ImageConst.certificate_img, height: 55, width: 55, color: AppColors.primaryColor,),
                  Text(
                    "${type.name}",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
    return SizedBox.shrink();
  }
}
