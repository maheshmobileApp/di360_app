import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/gallery_img_widget.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeedCommunityCard extends StatelessWidget {
  final String id;
  final String logoUrl;
  final String feedUserRole;
  final String companyName;
  final String courseTitle;
  final String description;
  final String status;
  final List<String> types;
  final String createdAt;
  final int registeredCount;
  final String chipTitle;
  final List<String> imageUrls;

  final VoidCallback? onTapRegistered;
  final Function(String action, String id)? onMenuAction;
  final VoidCallback? onDetailView;
  final VoidCallback? onLikeTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onCommentTap;
  final int likes;
  final int comments;
  final bool isLiked;

  const NewsFeedCommunityCard({
    super.key,
    required this.id,
    required this.logoUrl,
    required this.feedUserRole,
    required this.comments,
    required this.companyName,
    required this.courseTitle,
    required this.description,
    required this.status,
    required this.types,
    required this.imageUrls,
    required this.createdAt,
    required this.registeredCount,
    this.onTapRegistered,
    this.onMenuAction,
    this.onDetailView,
    required this.chipTitle,
    this.onLikeTap,
    this.onShareTap,
    this.onCommentTap,
    required this.likes,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(createdAt) ?? '';

    return FutureBuilder<String>(
      future: LocalStorage.getStringVal(LocalStorageConst.type),
      builder: (context, snapshot) {
        final type = snapshot.data ?? '';

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // 🔹 Top Card
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo + Title + Menu
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _logoWithTitle(
                            logoUrl,
                            companyName,
                            createdAt,
                          ),
                        ),
                        if (type == "SUPPLIER" ||
                            (type == "PROFESSIONAL" &&
                                feedUserRole != "SUPPLIER"))
                          Row(
                            children: [
                              _menuWidget(context, type),
                            ],
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const SizedBox(height: 8),

                    _descriptionWidget(description),
                    (imageUrls.isNotEmpty)
                        ? GalleryImgWidget(imageUrls:imageUrls)
                        : SizedBox.shrink(),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// ❤️ Like Button + Count
                        GestureDetector(
                          onTap: onLikeTap,
                          child: Row(
                            children: [
                              _circleIcon(
                                child: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked
                                      ? Colors.orangeAccent
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                likes.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 15),

                        /// 🔗 Share Button
                        GestureDetector(
                          onTap: onShareTap,
                          child: _circleIcon(
                            child: Icon(Icons.share,
                                size: 20, color: Colors.black),
                          ),
                        ),

                        const Spacer(),

                        /// 💬 Comment Icon + Count
                        GestureDetector(
                          onTap: onCommentTap,
                          child: Row(
                            children: [
                              const Icon(Icons.comment,
                                  color: Colors.black, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                "${comments.toString()} Comments",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circleIcon({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }

  Widget _logoWithTitle(
    String logo,
    String company,
    String createdAt,
  ) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.geryColor,
              backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
              radius: 30,
              child: logo.isEmpty
                  ? const Icon(Icons.business,
                      size: 20, color: AppColors.lightGeryColor)
                  : null,
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: TextStyles.bold3(color: AppColors.black)),
              const SizedBox(height: 2),
              Text(DateFormatUtils.formatDateTime(createdAt),
                  style: TextStyles.regular1(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(color: AppColors.bottomNavUnSelectedColor),
      ),
    );
  }

  Widget _imagesWidget(List<String> urls) {
    return Container(
      height: 150,
      width: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImageWidget(
                imageUrl: urls[index],
                fit: BoxFit.cover,
                errorWidget: Container(
                  color: Colors.grey.shade200,
                  child: Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _chipWidget(List<String> types, String meetingLink) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type.isEmpty ? 'N/A' : type;
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondaryBlueColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                child: Text(
                  label,
                  style: TextStyles.regular1(
                    color: AppColors.typeTextColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            (meetingLink != "" && types.first == "Webinar")
                ? _meetingLinkWidget(meetingLink)
                : SizedBox.shrink(),
          ],
        );
      }).toList(),
    );
  }

  Widget _meetingLinkWidget(String link) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(37, 255, 255, 255),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.HINT_COLOR)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: GestureDetector(
          onTap: () async {
            final url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              scaffoldMessenger("Invalid link !!");
            }
          },
          child: Text(
            "Meeting Link",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.regular1(
              color: AppColors.bottomNavUnSelectedColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _jobTimeChip(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time,
        style: TextStyles.semiBold(
            fontSize: 10, color: const Color.fromRGBO(255, 112, 0, 1)),
      ),
    );
  }

  Widget _registeredChip(int registeredCount, String chipTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$registeredCount $chipTitle",
        style: TextStyles.semiBold(fontSize: 10, color: AppColors.black),
      ),
    );
  }

  Widget _menuWidget(BuildContext context, String type) {
    return PopupMenuButton<String>(
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero, // removes inside padding
      constraints: const BoxConstraints(
        minWidth: 0,
        minHeight: 0,
      ), // remove default 48x48
      icon: Icon(
        Icons.more_vert,
        size: 20,
        color: AppColors.bottomNavUnSelectedColor,
      ),
      onSelected: (value) => onMenuAction?.call(value, id),
      itemBuilder: (context) => [
        if (type == "PROFESSIONAL" ||
            (type == "SUPPLIER" && feedUserRole == "SUPPLIER")) ...[
          _popupItem("Edit", Icons.edit, AppColors.blueColor),
          _popupItem("Delete", Icons.delete, AppColors.redColor)
        ],
        if (type == "SUPPLIER" && feedUserRole == "SUPPLIER") ...[
          if (status == "UNPUBLISHED" || status == "PENDING")
            _popupItem("Publish", Icons.send, AppColors.blueColor),
          if (status == "PUBLISHED" || status == "PENDING")
            _popupItem("Unpublish", Icons.send, AppColors.redColor),
        ] else if (type != "PROFESSIONAL") ...[
          if (status == "UNPUBLISHED" || status == "PENDING")
            _popupItem("Publish", Icons.send, AppColors.blueColor),
          if (status == "PUBLISHED" || status == "PENDING")
            _popupItem("Unpublish", Icons.send, AppColors.redColor),
        ]
      ],
    );
  }

  PopupMenuItem<String> _popupItem(String label, IconData icon, Color color) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyles.semiBold(color: color, fontSize: 14)),
        ],
      ),
    );
  }

  String? _getShortTime(String createdAt) {
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }
}
