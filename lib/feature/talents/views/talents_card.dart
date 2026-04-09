import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TalentsCard extends StatelessWidget with BaseContextHelpers {
  final JobProfiles? talentList;
  TalentsCard({super.key, this.talentList});
  @override
  Widget build(BuildContext context) {
    final talentViewModel = Provider.of<TalentsViewModel>(context);
    String profleImage = '';
    if (talentList!.profileImage.isNotEmpty) {
      profleImage = talentList!.profileImage.first.url ?? '';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                    talentList?.fullName ?? "",
                    talentList?.professionType ?? "",
                  ),
                ],
              ),
              if (talentList?.jobDesignation?.isNotEmpty == true) ...[
                addVertical(4),
                _descptionDate(talentList?.jobDesignation ?? ""),
              ],
              addVertical(6),
              Row(
                children: [
                  Flexible(child: _chipWidget(talentList?.workType ?? [])),
                ],
              ),
              addVertical(6),
              if (talentList?.location?.isEmpty == false)
                _locationWidget(talentList?.location ?? ""),
              addVertical(4),
              if (talentList?.yearOfExperience?.isEmpty == false)
                _experienceWidget(talentList?.yearOfExperience ?? ""),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShareWidget(
                    category: FeedType.talents.name,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    size: 20,
                    feedId: talentList?.id ?? '',
                  ),
                  addHorizontal(10),
                  GestureDetector(
                    onTap: () async {
                      await talentViewModel.getTalentListMutationById(
                          context, talentList?.dentalProfessionalId ?? "");
                      navigationService
                          .navigateToWithParams(RouteList.talentsHireMeScreen);
                    },
                    child: Row(
                      children: [
                        Text(
                          "View Details",
                          style:
                              TextStyles.medium1(color: AppColors.primaryColor),
                        ),
                        SvgPicture.asset(
                          ImageConst.nextArrow,
                          width: 26,
                          height: 26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: Color.fromRGBO(4, 113, 222, 0.15),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            type.toString() == 'null' ? 'N/A' : type.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(4, 113, 222, 1),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _experienceWidget(String experience) {
    return Row(
      children: [
        Image.asset(ImageConst.experience),
        addHorizontal(4),
        Flexible(
            child: Text(
          "$experience of Experience",
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
              backgroundColor: AppColors.primaryColor,
              child: ClipOval(

                  child: CachedNetworkImageWidget(
                width: 48,
                height: 48,
                imageUrl: imageUrl,
                errorWidget: Image.asset(ImageConst.directorProfile),
              )))),
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
