import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDirectorGallery extends StatefulWidget {
  const AddDirectorGallery({super.key});

  @override
  State<AddDirectorGallery> createState() => _AddDirectorGalleryState();
}

class _AddDirectorGalleryState extends State<AddDirectorGallery>
    with BaseContextHelpers {
  bool showForm = false;
  String? serverImg;
  dynamic galleryImg;
  String? id;

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Gallery'),
                CustomAddButton(
                  label: showForm ? 'Cancel' : 'Add +',
                  onPressed: () {
                    setState(() {
                      serverImg = null;
                      galleryImg = null;
                      showForm = !showForm;
                    });
                  },
                ),
              ],
            ),
            if (showForm) _buildGalleryForm(addDirectorVM, editVM),
            const Divider(thickness: 2),
            addDirectorVM.getBasicInfoData.first.directoryGalleryPosts?.length == 0
                ? Center(child: Text('No gallery'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: addDirectorVM
                        .getBasicInfoData.first.directoryGalleryPosts?.length,
                    itemBuilder: (context, index) {
                      final galleryItem = addDirectorVM
                          .getBasicInfoData.first.directoryGalleryPosts?[index];
                      final hasImages = galleryItem?.image != null &&
                          galleryItem!.image!.isNotEmpty;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: AddDirectoryGalleryCard(
                          imageUrl:
                              hasImages ? galleryItem.image?.first.url : '',
                          onEdit: () {
                            editVM.updateIsEditGallery(true);
                            setState(() {
                              id = galleryItem?.id;
                              serverImg =
                                  hasImages ? galleryItem.image?.first.url : '';
                              galleryImg = galleryItem?.image?.first.toJson();
                              showForm = true;
                            });
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryForm(
      AddDirectoryViewModel addDirectorVM, EditDeleteDirectorViewModel editVM) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          LogoContainer(
            title: "Gallery Images",
            imageFile: addDirectorVM.galleryFile,
            onTap: () {
              imagePickerSelection(
                context,
                () => addDirectorVM.pickGalleryImage(ImageSource.gallery),
                () => addDirectorVM.pickGalleryImage(ImageSource.camera),
              );
              serverImg = null;
            },
            serverImg: serverImg,
          ),
          addVertical(20),
          CustomBottomButton(
            onFirst: () {
              editVM.updateIsEditGallery(false);
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              if (addDirectorVM.galleryFile?.path.isEmpty ??
                  false || galleryImg == null) {
                scaffoldMessenger('Select gallery image');
              } else {
                editVM.isEditGallery
                    ? editVM.updateTheGallery(context, id ?? '', galleryImg)
                    : addDirectorVM.addGallery(context);
                setState(() {
                  showForm = false;
                });
              }
            },
            firstLabel: "Close",
            secondLabel: editVM.isEditGallery ? 'Update' : "Add",
            firstBgColor: AppColors.timeBgColor,
            firstTextColor: AppColors.primaryColor,
            secondBgColor: AppColors.primaryColor,
            secondTextColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}

class AddDirectoryGalleryCard extends StatelessWidget {
  final String? imageUrl;
  final Function()? onDelete;
  final Function()? onEdit;

  const AddDirectoryGalleryCard(
      {super.key, this.imageUrl, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (imageUrl != null) ...[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImageWidget(
                    imageUrl: imageUrl ?? '', width: 200, height: 200)),
            const SizedBox(width: 10),
          ],
          const Spacer(),
          GestureDetector(
            onTap: onEdit,
            child: Icon(Icons.edit, color: AppColors.blueColor, size: 25),
          ),
          // const SizedBox(width: 8),
          // GestureDetector(
          //   onTap: onDelete,
          //   child:
          //       Icon(Icons.delete_outline, color: AppColors.redColor, size: 25),
          // ),
        ],
      ),
    );
  }
}
