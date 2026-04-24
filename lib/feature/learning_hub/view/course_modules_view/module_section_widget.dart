import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ModuleSectionWidget extends StatelessWidget with BaseContextHelpers {
  final CourseListingViewModel courseViewModel;
  const ModuleSectionWidget({super.key, required this.courseViewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courseViewModel.courseDetails?.moduleSection?.length,
      itemBuilder: (context, index) {
        final section = courseViewModel.courseDetails?.moduleSection?[index];
        return _buildModuleItem(index, section);
      },
    );
  }

  Widget _buildModuleItem(int index, ModuleSection? section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Module ${index + 1}"),
        Text(section?.moduleName ?? '',
            style: TextStyles.bold4(color: AppColors.black)),
        addVertical(10),
        _moduleButtons(() => print('Previous'), () => print('Next')),
        addVertical(10),
        _buildsectionList(section?.sectionList),
      ],
    );
  }

  Widget _moduleButtons(Function()? onPrevious, Function()? onNext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onPrevious,
          child: Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.bottomBarSelectIconColor,
                child: const Icon(Icons.arrow_back_ios,
                    color: AppColors.black, size: 10),
              ),
              addHorizontal(4),
              Text('Previous', style: TextStyle(color: AppColors.black))
            ],
          ),
        ),
        GestureDetector(
          onTap: onNext,
          child: Row(
            children: [
              Text('Next', style: TextStyle(color: AppColors.black)),
              addHorizontal(4),
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.bottomBarSelectIconColor,
                child: const Icon(Icons.arrow_forward_ios,
                    color: AppColors.black, size: 10),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildsectionList(List<SectionList>? sectionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sectionList?.length ?? 0,
      itemBuilder: (context, index) {
        final topic = sectionList?[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topic?.courseTopic ?? '',
                style: TextStyles.bold3(color: AppColors.primaryColor)),
            addVertical(5),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child:
                        LazyYoutubePlayer(youtubeUrl: topic?.youtubeLink ?? ''),
                  ),
                ),
                Positioned(
                    left: 8,
                    top: 80,
                    child: CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(Icons.arrow_back_ios,
                            size: 11, color: AppColors.black))),
                Positioned(
                    right: 8,
                    top: 80,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.whiteColor,
                      child: Icon(Icons.arrow_forward_ios,
                          size: 11, color: AppColors.black),
                    ))
              ],
            ),
            addVertical(10),
            if (topic?.description != null) ...[
              Text('Description: ',
                  style: TextStyles.regular1(color: AppColors.black)),
              addVertical(5),
              HtmlWidget(topic?.description ?? '',
                  textStyle: TextStyles.regular4(color: AppColors.black))
            ],
            if (topic?.image != null) ...[
              addVertical(10),
              Text('Images:',
                  style: TextStyles.regular1(color: AppColors.black)),
              addVertical(10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topic?.image?.length ?? 0,
                  itemBuilder: (_, i) {
                    final img = topic?.image?[i] as Map<String, dynamic>;
                    final url = img['url'] ?? '';
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            Image.network(url, width: 150, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              )
            ],
            if (topic?.attachment != null) ...[
              addVertical(10),
              Text('Attachements:',
                  style: TextStyles.regular1(color: AppColors.black)),
              addVertical(5),
              Image.asset(ImageConst.pdf),
              // Text(topic?.pdfLink ?? '',
              //     style: TextStyles.regular4(color: AppColors.primaryColor))
            ],
            addVertical(30),
            Align(
                alignment: Alignment.bottomRight,
                child: AppButton(
                    text: topic?.status == 'Pending'
                        ? 'Complete and Continue'
                        : 'Completed',
                        radius: 8,
                        height: 42,width: 230,))
          ],
        );
      },
    );
  }
}
