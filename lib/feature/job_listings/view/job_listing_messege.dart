import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
//import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class JobListingMessege extends StatelessWidget with BaseContextHelpers {
  final Jobs? jobsListingData;
  const JobListingMessege({
    this.jobsListingData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: _logoWithTitle(
            context,
            jobsListingData?.logo ?? '',
            jobsListingData?.companyName ?? '',
            jobsListingData?.jRole ?? '',
            jobsListingData?.status ?? '',
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.bottomNavUnSelectedColor,
              ),
              onPressed: () {},
            ),
          ],
        ));
  }

  Widget _logoWithTitle(
    BuildContext context,
    String logo,
    String company,
    String title,
    String status,
  ) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.geryColor,
              radius: 30,
              child: CachedNetworkImageWidget(
                  imageUrl: logo ?? '',
                  fit: BoxFit.fill,
                  errorWidget: Image.asset(ImageConst.prfImg)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(229, 244, 237, 1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyles.medium1(
                    color: AppColors.greenColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        addHorizontal(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: TextStyles.medium2(color: AppColors.black)),
              addVertical(2),
              Text(title, style: TextStyles.regular2(color: AppColors.black)),
            ],
          ),
        ),
      ],
    );
  }
}
