import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class CommunityHeaderCard extends StatelessWidget {
  final String imageUrl;
  final bool leaveButton;

  final String title;
  final VoidCallback onLeaveTap;

  const CommunityHeaderCard({
    super.key,
    required this.imageUrl,
    required this.leaveButton,
    required this.title,
    required this.onLeaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          /// TOP IMAGES SECTION
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImageWidget(
                    imageUrl: imageUrl,
                    height: 100,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      height: 100,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM FOOTER SECTION
          Container(
            
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 153, 153, 153),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// TITLE TEXT
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),

                (leaveButton)?
                ElevatedButton.icon(
                  onPressed: onLeaveTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Leave"),
                ):SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
