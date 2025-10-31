import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class TalentsCard extends StatelessWidget with BaseContextHelpers {
     final JobProfiles? talentList;
  TalentsCard({super.key,  this.talentList});
  @override
  Widget build(BuildContext context) {
    String profleImage = '';
    if (talentList!.profileImage.isNotEmpty) {
      profleImage = talentList!.profileImage.first.url ?? '';
    } 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _logoWithTitle(
                    context,
                    profleImage,
                  talentList?.fullName??"",
                    talentList?.professionType ??"",
                  ),
                ],
              ),
              addVertical(4),
              _descptionDate(
                 talentList?.jobDesignation??""),
              addVertical(4),
              Divider(),
              addVertical(6),
              _locationWidget(talentList?.location??""),
              addVertical(4),
              _experienceWidget(talentList?.yearOfExperience??"")
            ],
          ),
        ),
      ),
    );
  }

  Widget _experienceWidget(String experience) {
    return Row(
      children: [
        Image.asset(ImageConst.experience),
        addHorizontal(4),
        Flexible(
            child: Text(
          experience,
          style: TextStyles.regular1(
              fontSize: 14, color: AppColors.locationTextColor),
          overflow: TextOverflow.ellipsis,
        )),
      ],
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
              fontSize: 14, color: AppColors.locationTextColor),
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }

  Widget _descptionDate(String description) {
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

  Widget _logoWithTitle(
    BuildContext context,
    String imageUrl,
    String title,
    String role,
  ) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          // backgroundColor: Colors.grey,
                          child: Icon(Icons.error),
                        )))
                : CircleAvatar(
                    radius: 24,
                    child:  const Icon(Icons.person,
                      size: 20, color: AppColors.lightGeryColor),
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
      ])
    ]);
  }
}
