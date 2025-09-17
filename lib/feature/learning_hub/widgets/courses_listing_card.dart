import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';

class CouresListingCard extends StatelessWidget {
  final String id;
  final String logoUrl;
  final String companyName;
  final String courseTitle;
  final String status;
  final String description;
  final List<String> types;
  final String createdAt;
  final int registeredCount;

  final VoidCallback? onTapRegistered;
  final Function(String action, String id)? onMenuAction;
  final VoidCallback? onCardTap;

  const CouresListingCard({
    super.key,
    required this.id,
    required this.logoUrl,
    required this.companyName,
    required this.courseTitle,
    required this.status,
    required this.description,
    required this.types,
    required this.createdAt,
    required this.registeredCount,
    this.onTapRegistered,
    this.onMenuAction,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(createdAt) ?? '';

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
                        courseTitle,
                        status,
                      ),
                    ),
                    Row(
                      children: [
                        _jobTimeChip(time),
                        _menuWidget(context),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                _chipWidget(types),
                const SizedBox(height: 8),

                _descriptionWidget(description),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _registeredChip(registeredCount),
                    GestureDetector(
                      onTap: onCardTap,
                      child: SvgPicture.asset(
                        ImageConst.nextArrow,
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoWithTitle(
    String logo,
    String company,
    String title,
    String status,
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
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(229, 244, 237, 1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyles.medium1(
                    color: AppColors.greenColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: TextStyles.medium2(color: AppColors.black)),
              const SizedBox(height: 2),
              Text(title, style: TextStyles.regular2(color: AppColors.black)),
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

  Widget _chipWidget(List<String> types) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type.isEmpty ? 'N/A' : type;
        return Container(
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
        );
      }).toList(),
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

  Widget _registeredChip(int registeredCount) {
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
        "$registeredCount Registered",
        style: TextStyles.semiBold(
            fontSize: 10, color: const Color.fromRGBO(255, 112, 0, 1)),
      ),
    );
  }

  Widget _menuWidget(BuildContext context) {
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
        _popupItem("Preview", Icons.remove_red_eye, AppColors.black),
        _popupItem("Edit", Icons.edit_outlined, AppColors.blueColor),
        _popupItem("Delete", Icons.delete_outline, AppColors.redColor),
        if (status == "APPROVE")
          _popupItem(
              "Inactive", Icons.nightlight_outlined, AppColors.primaryColor),
        if (status == "REJECT")
          _popupItem(
              "Active", Icons.nightlight_outlined, AppColors.primaryColor),
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
