import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talents/model/talents_model.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/custom_chip_view.dart';
import 'package:di360_flutter/widgets/education_data_withicon.dart';
import 'package:di360_flutter/widgets/expended_view.dart';
import 'package:di360_flutter/widgets/experience_info.dart';
import 'package:di360_flutter/widgets/gallary_view.dart';
import 'package:di360_flutter/widgets/header_image.dart';
import 'package:di360_flutter/widgets/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalentsDetailsView extends StatelessWidget with BaseContextHelpers {
  final JobProfile? talentList;

  const TalentsDetailsView({
    super.key,
    this.talentList,
  });

  @override
  Widget build(BuildContext context) {
    final talentViewModel = Provider.of<TalentsViewModel>(context);
    return Scaffold(
        body: HeaderImageView(
          logo: "",
          title: talentList?.fullName ?? "",
          body: _buildBodyContent(context, talentViewModel),
        ),
        bottomNavigationBar: _bottomButtons(context));
  }

  Widget _buildBodyContent(
      BuildContext context, TalentsViewModel talentViewmodel) {
    final List<String> educationList = talentList?.educations
            .map((e) => e.qualification ?? '')
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoWithTitle(
                title: talentList?.fullName ?? "",
                showTime: false,
                createdAt: talentList?.createdAt ?? "",
                role: talentList?.jobDesignation ?? "",
                imageUrl: ""),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExperienceInfo(
                    svgPath: ImageConst.briefcaseSvg,
                    text:
                        '${talentList?.yearOfExperience ?? 0} Yrs Experience'),
                SizedBox(height: 12),
                ExperienceInfo(
                    svgPath: ImageConst.locationsvg,
                    text: '${talentList?.location ?? ''}'),
              ],
            ),
            Divider(
              color: AppColors.geryColor,
            ),
            SizedBox(height: 16),
            EducationDataWithicon(
                iconPath: ImageConst.graduationSvg,
                title: 'Education',
                educationList: educationList),
            SizedBox(height: 16),
            Text("Skils"),
            SizedBox(height: 6),
            CustomChipView(typesList: talentList?.skills ?? []),
            SizedBox(height: 12),
            Divider(
              color: AppColors.geryColor,
            ),
            SizedBox(height: 12),
            _sectionHeader("About me / Profile Summary"),
            SizedBox(height: 6),
            _sectionText(
                "The entire course was re-recorded from scratch and was therefore completely updated! It's now 100% up-to-date with the latest version of Angular again, covering crucial modern features like signals, standalone components etc."),
            Divider(
              color: AppColors.geryColor,
            ),
            _sectionHeader("Key Responsibilities"),
            SizedBox(height: 6),
            _sectionText("${talentList?.aboutYourself ?? ""}"),
            Divider(
              color: AppColors.geryColor,
            ),
             SizedBox(height: 6),
            Padding(
              padding:  EdgeInsets.only(top: 0),
              child: ExperienceAccordionItem(
                details: ListView.separated(
                 shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = talentViewmodel.experienceList[index];
                    return ListTile(
                      dense: true,
                      onTap: () => talentViewmodel.toggleIndex(index),
                      title: Text(item['title']),
                      subtitle: talentViewmodel.expandedIndex == index
                          ? Text('descriptions')
                          : null,
                      trailing: Icon(
                        talentViewmodel.expandedIndex == index
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.orange,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: talentViewmodel.experienceList.length,
                ),
              ),
            ),
            SizedBox(height: 16),
            _sectionHeader('Gallery'),
            SizedBox(height: 6),
            GalleryView(imageUrls: []),
            SizedBox(height: 16),
            _sectionHeader("Certifications"),
            SizedBox(height: 6),
            CustomChipView(typesList: talentList?.certificate ?? []),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Container(
      height: getSize(context).height * 0.1,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.87),
          blurRadius: 5.0,
        )
      ], color: AppColors.whiteColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomRoundedButton(
                height: 42,
                text: 'Enquiry',
                onPressed: () {
                  // handle Enquiry
                },
                backgroundColor: AppColors.timeBgColor, 
                textColor: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomRoundedButton(
                text: 'Hire Me',
                height: 42,
                onPressed: () {
                  // handle Hire Me
                },
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title, style: TextStyles.medium2()),
    );
  }

  Widget _sectionText(String text) {
    return Text(text,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(color: AppColors.locationTextColor));
  }
}
