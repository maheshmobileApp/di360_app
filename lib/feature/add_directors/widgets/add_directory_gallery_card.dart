import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/add_directors/model/gallery_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddDirectoryGalleryCard extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onDelete;
  final GalleryModel gallery;
  final int index;

  const AddDirectoryGalleryCard({
    super.key,
    this.imageFile,
    required this.onDelete,
    required this.gallery,
    required this.index,
  });

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
          if (imageFile != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                imageFile!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
          ],
          const Spacer(),
          GestureDetector(
            onTap: () {
              showGalleryOptionsBottomSheet(context, gallery, index);
            },
            child: const Icon(Icons.more_vert, size: 20),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.redColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  void showGalleryOptionsBottomSheet(
      BuildContext context, GalleryModel gallery, int index) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.7,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.buttomBarColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (gallery.imageFile != null)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            gallery.imageFile!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const Spacer(),
                    CustomBottomButton(
                      onFirst: () {
                        addDirectorVM.Gallerys.remove(gallery);
                        Navigator.pop(context);
                      },
                      onSecond: () {
                        Navigator.pop(context);
                        showEditGalleryBottomSheet(context, gallery, index);
                      },
                      firstLabel: "Delete",
                      secondLabel: "Edit",
                      firstBgColor: AppColors.timeBgColor,
                      firstTextColor: AppColors.primaryColor,
                      secondBgColor: AppColors.primaryColor,
                      secondTextColor: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showEditGalleryBottomSheet(
      BuildContext context, GalleryModel gallery, int index) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);

    addDirectorVM.selectedGallery = gallery;
    addDirectorVM.loadGalleryData(gallery);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.buttomBarColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (addDirectorVM.galleryFile != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  addDirectorVM.galleryFile!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                              
                              },
                              icon: const Icon(Icons.photo_library),
                              label: const Text("Change Image"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomBottomButton(
                      onFirst: () {
                        addDirectorVM.Gallerys.remove(gallery);
                        Navigator.pop(context);
                      },
                      onSecond: () {
                        addDirectorVM.updateGallery(index);
                        Navigator.pop(context);
                      },
                      firstLabel: "Delete",
                      secondLabel: "Save",
                      firstBgColor: AppColors.timeBgColor,
                      firstTextColor: AppColors.primaryColor,
                      secondBgColor: AppColors.primaryColor,
                      secondTextColor: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
