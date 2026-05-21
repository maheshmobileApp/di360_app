import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/attachment_view_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/gallery_img_widget.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModuleSectionWidget extends StatelessWidget with BaseContextHelpers {
  final ScrollController scrollController;
  const ModuleSectionWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketPlaceLearningHubViewModel>(
      builder: (context, vm, _) {
        final modules = vm.courseDetails?.moduleDetails ?? [];
        if (modules.isEmpty) return const SizedBox.shrink();
        final section = modules[vm.currentModuleIndex];
        final prevSectionsCount = modules
            .sublist(0, vm.currentModuleIndex)
            .fold<int>(0, (sum, m) => sum + (m.sectionDetails?.length ?? 0));
        final localSectionIndex = vm.currentSectionIndex - prevSectionsCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Module ${vm.currentModuleIndex + 1}"),
              Text(section.moduleName ?? '',
                  style: TextStyles.bold4(color: AppColors.black)),
              addVertical(10),
              _navButtons(
                label1: 'Previous',
                icon1: Icons.arrow_back_ios,
                onTap1: vm.currentSectionIndex > 0 ? vm.previousModule : null,
                label2: 'Next',
                icon2: Icons.arrow_forward_ios,
                onTap2: vm.currentSectionIndex < vm.allSections.length - 1
                    ? () => vm.completeAndContinue(context)
                    : null,
              ),
              addVertical(10),
              _buildSectionItem(
                  context, vm, section.sectionDetails ?? [], localSectionIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionItem(
      BuildContext context,
      MarketPlaceLearningHubViewModel vm,
      List<SectionDetails> sectionList,
      int localSectionIndex) {
    if (sectionList.isEmpty) return const SizedBox.shrink();
    final topic =
        sectionList[localSectionIndex.clamp(0, sectionList.length - 1)];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topic.courseTopic ?? '',
            style: TextStyles.bold3(color: AppColors.primaryColor)),
        addVertical(5),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: LazyYoutubePlayer(youtubeUrl: topic.youtubeLink ?? ''),
          ),
        ),
        addVertical(10),
        if (topic.description != null && topic.description != '') ...[
          Text('Description: ',
              style: TextStyles.bold2(
                color: AppColors.primaryColor,
              )),
          addVertical(5),
          ExpandableHtmlText(htmlData: topic.description ?? ''),
        ],
        if (topic.image != null) ...[
          addVertical(10),
          GalleryImgWidget(
              title: "Images",
              imageUrls: _toList(topic.image)
                  .map((e) =>
                      e is Map ? (e['url'] ?? '').toString() : e.toString())
                  .where((url) => url.isNotEmpty)
                  .toList()),
        ],
        if (topic.attachment != null) ...[
          addVertical(10),
          AttachmentViewWidget(
            attachments: _toList(topic.attachment)
                .whereType<Map<String, dynamic>>()
                .where((e) => e['url'] != null)
                .toList(),
          ),
        ],
        addVertical(30),
        Align(
          alignment: Alignment.bottomRight,
          child: AppButton(
            text: vm.isSectionCompleted(topic.id)
                ? 'Completed'
                : 'Complete and Continue',
            radius: 8,
            height: 42,
            width: 230,
            btnColor: vm.isSectionCompleted(topic.id) ? Colors.green : null,
            onTap: vm.isSectionCompleted(topic.id)
                ? null
                : () {
                    vm.completeAndContinue(context);
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut);
                  },
          ),
        ),
        addVertical(30),
      ],
    );
  }

  List _toList(dynamic value) {
    if (value == null) return [];
    if (value is List) return value;
    return [value];
  }

  Widget _navButtons(
      {required String label1,
      required IconData icon1,
      required VoidCallback? onTap1,
      required String label2,
      required IconData icon2,
      required VoidCallback? onTap2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap1,
          child: Opacity(
            opacity: onTap1 != null ? 1.0 : 0.3,
            child: Row(children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.bottomBarSelectIconColor,
                child: Icon(icon1, color: AppColors.black, size: 10),
              ),
              addHorizontal(4),
              Text(label1, style: TextStyle(color: AppColors.black)),
            ]),
          ),
        ),
        GestureDetector(
          onTap: onTap2,
          child: Opacity(
            opacity: onTap2 != null ? 1.0 : 0.3,
            child: Row(children: [
              Text(label2, style: TextStyle(color: AppColors.black)),
              addHorizontal(4),
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.bottomBarSelectIconColor,
                child: Icon(icon2, color: AppColors.black, size: 10),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
