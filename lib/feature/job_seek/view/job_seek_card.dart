import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
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
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color.fromRGBO(220, 224, 228, 1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(116, 130, 148, 0.2),
              blurRadius: 15,
              offset: Offset(0, 2),
            ),
          ],
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logoWithTitle(
                context,
                jobsData?.logo ?? "",
                jobsData?.companyName ?? "",
                jobsData?.jRole ?? "",
                _getShortTime(jobsData?.createdAt ?? ""),
              ),
              addVertical(10),
              _descriptionWidget(jobsData?.description ?? ""),
              addVertical(10),
              _locationWidget(jobsData?.location ?? ""),
              addVertical(10),
              _chipWidget(jobsData?.typeofEmployment ?? []),
            ],
          ),
        ),
      
    );
  }
  Widget _chipWidget(List<dynamic> typeofEmployment) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      children: typeofEmployment.map<Widget>((type) {
        return Container(
          height: 21,
          width: 71,
          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
          decoration: BoxDecoration(
            color: Color.fromRGBO(4, 113, 222, 0.15),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              type.toString() == 'null' ? 'N/A' : type.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1,
                color: Color.fromRGBO(4, 113, 222, 1),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }
  Widget _locationWidget(String location) {
    return Row(
      children: [
        Image.asset(ImageConst.location),
        addHorizontal(4),
        Flexible(
          child: Text(
            location,
            style: TextStyles.regular1(
              fontSize: 14,
              color: AppColors.locationTextColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Text(
        description,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1,
          color: Color.fromRGBO(116, 130, 148, 1),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }

  Widget _logoWithTitle(BuildContext context, String imageUrl, String title,
      String role, String? time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 24,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.whiteColor,
            child: (imageUrl.isNotEmpty)
                ? ClipOval(
                    child: CachedNetworkImageWidget(
                      width: 48,
                      height: 48,
                      imageUrl: imageUrl,
                      errorWidget: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.error),
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                  ),
          ),
        ),
        addHorizontal(6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: getSize(context).width * 0.5,
              child: Text(
                title,
                style:
                    TextStyles.semiBold(fontSize: 16, color: AppColors.black),
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
          ],
        ),
        Spacer(),
        if (time != null) JobTimeChip(time: time),
      ],
    );
  }

 

  String? _getShortTime(String createdAt) {
    return Jiffy.parse(createdAt).fromNow();
  }
}