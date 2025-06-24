import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/view/chip_view.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JobSeekCard extends StatelessWidget with BaseContextHelpers {
   final Jobs? jobsData; 
  final List<Widget>? children;
  const JobSeekCard({super.key, this.children, this.jobsData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.borderColor,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _logoWithTitle(
                        context,
                        jobsData?.logo ?? "",
                        jobsData?.title ?? "",
                        jobsData?.jRole ?? "",
                        Jiffy.parse(jobsData?.createdAt ?? '').fromNow())
                  ],
                ),
                _descptionWidget(jobsData?.description ?? ""),
                addVertical(6),
                _locationWidget(jobsData?.location ?? ""),
                addVertical(6),
                _chipWidget(jobsData?.typeofEmployment ?? [])
              ],
            )),
      ),
    );
  }

  Widget _chipWidget(List<dynamic> typeofEmployment) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 1,
      runSpacing: 2,
      children: typeofEmployment.map<Widget>((type) {
        return Padding(
          padding: EdgeInsets.all(2.0),
          child: customFilterChip(
              type.toString() == 'null' ? 'N/A' : type.toString()),
        );
      }).toList(),
    );
  }

  Widget _locationWidget(String location) {
    return Row(
      children: [
        Image.asset(ImageConst.location),
        addHorizontal(2),
        Flexible(
            child: Text(
          location,
          style: TextStyles.regular1(
              fontSize: 14, color: AppColors.locationTextColor),
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }

  Widget _descptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description,
        style: TextStyles.regular1(
            fontSize: 14, color: AppColors.bottomNavUnSelectedColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }

  Widget _logoWithTitle(BuildContext context, String imageUrl, String title,
      String role, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 24,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.whiteColor,
              child: (imageUrl != '' || imageUrl.isNotEmpty)
                  ? ClipOval(
                      child: CachedNetworkImageWidget(
                          width: 48,
                          height: 48,
                          imageUrl: imageUrl,
                          errorWidget: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.error),
                          )))
                  : CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                    ),
            )),
        addHorizontal(6),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: getSize(context).width * 0.5,
            child: Text(
              title,
              style: TextStyles.semiBold(fontSize: 16, color: AppColors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          addVertical(4),
          SizedBox(
            width: getSize(context).width * 0.5,
            child: Text(
              role,
              style: TextStyles.regular2(color: AppColors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Text(
              time,
              style: TextStyles.regular1(color: AppColors.primaryColor),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.timeBgColor,
            AppColors.timeBgColor,
          ])),
        ),
      ],
    );
  }
}
