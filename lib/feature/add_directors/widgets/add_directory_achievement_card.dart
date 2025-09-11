import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class AddDirectoryAchievementCard extends StatelessWidget {
  final String title;
  final String? imageFile;
  final Function()? onDelete;
  final Function()? onEdit;

  const AddDirectoryAchievementCard(
      {super.key, required this.title, this.imageFile, this.onDelete,this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.cardcolor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          if (imageFile != null) ...[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImageWidget(
                    imageUrl: imageFile ?? '', width: 50, height: 50)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyles.bold2(color: AppColors.black),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onEdit,
            child:  Icon(Icons.edit,color: AppColors.blueColor, size: 25),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: onDelete,
            child:  Icon(
              Icons.delete_outline,
              color: AppColors.redColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  // /// Show achievement options (delete/edit)
  // void showAchievementOptionsBottomSheet(
  //     BuildContext context, AchievementModel achievement, int index) {
  //   final addDirectorVM =
  //       Provider.of<AddDirectorViewModel>(context, listen: false);

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.black,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.5,
  //         maxChildSize: 0.8,
  //         minChildSize: 0.4,
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return Container(
  //             decoration: const BoxDecoration(
  //               color: AppColors.buttomBarColor,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //             ),
  //             child: SafeArea(
  //               top: false,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(16),
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 24,
  //                           backgroundColor: AppColors.buttomBarColor,
  //                           backgroundImage: achievement.imageFile != null
  //                               ? FileImage(achievement.imageFile!)
  //                               : null,
  //                         ),
  //                         const SizedBox(width: 12),
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 achievement.name,
  //                                 style: const TextStyle(
  //                                   fontWeight: FontWeight.w600,
  //                                   fontSize: 16,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   CustomBottomButton(
  //                     onFirst: () {
  //                       addDirectorVM.achievementsList.remove(achievement);
  //                       Navigator.pop(context);
  //                     },
  //                     onSecond: () {
  //                       Navigator.pop(context);
  //                       showEditAchievementBottomSheet(
  //                           context, achievement, index);
  //                     },
  //                     firstLabel: "Delete",
  //                     secondLabel: "Edit",
  //                     firstBgColor: AppColors.timeBgColor,
  //                     firstTextColor: AppColors.primaryColor,
  //                     secondBgColor: AppColors.primaryColor,
  //                     secondTextColor: AppColors.whiteColor,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // /// Show edit bottom sheet for achievement
  // void showEditAchievementBottomSheet(
  //     BuildContext context, AchievementModel achievement, int index) {
  //   final addDirectorVM =
  //       Provider.of<AddDirectorViewModel>(context, listen: false);

  //   addDirectorVM.selectedAchievement = achievement;
  //   addDirectorVM.loadAchievementData(achievement);

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.black,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.85,
  //         maxChildSize: 0.95,
  //         minChildSize: 0.6,
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return Container(
  //             decoration: const BoxDecoration(
  //               color: AppColors.buttomBarColor,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //             ),
  //             child: SafeArea(
  //               top: false,
  //               child: Column(
  //                 children: [
  //                   Expanded(
  //                     child: SingleChildScrollView(
  //                       controller: scrollController,
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 16, vertical: 20),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           TextField(
  //                             controller:
  //                                 addDirectorVM.achievementNameController,
  //                             decoration: const InputDecoration(
  //                               labelText: "Achievement Name",
  //                             ),
  //                           ),
  //                           const SizedBox(height: 20),
  //                           if (addDirectorVM.achievementFile != null)
  //                             Image.file(
  //                               addDirectorVM.achievementFile!,
  //                               height: 100,
  //                             ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   CustomBottomButton(
  //                     onFirst: () {
  //                       addDirectorVM.achievementsList.remove(achievement);
  //                       Navigator.pop(context);
  //                     },
  //                     onSecond: () {
  //                       addDirectorVM.updateAchievement(index);
  //                       Navigator.pop(context);
  //                     },
  //                     firstLabel: "Delete",
  //                     secondLabel: "Save",
  //                     firstBgColor: AppColors.timeBgColor,
  //                     firstTextColor: AppColors.primaryColor,
  //                     secondBgColor: AppColors.primaryColor,
  //                     secondTextColor: AppColors.whiteColor,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
