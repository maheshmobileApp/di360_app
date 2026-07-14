import 'dart:async';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/status_colors.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CouresListingCard extends StatefulWidget {
  final String id;
  final int index;
  final String logoUrl;
  final String companyName;
  final String courseTitle;
  final String status;
  final String activeStatus;
  final String description;
  final List<String> types;
  final String createdAt;
  final String updatedAt;
  final int registeredCount;
  final String meetingLink;
  final String chipTitle;
  final String? userType;
  final VoidCallback? onTapRegistered;
  final Function(String action, String id)? onMenuAction;
  final VoidCallback? onDetailView;
  final List<Presenters>? presenters;

  const CouresListingCard(
      {super.key,
      required this.id,
      required this.index,
      required this.logoUrl,
      required this.companyName,
      required this.courseTitle,
      required this.status,
      required this.description,
      required this.types,
      required this.createdAt,
      required this.updatedAt,
      required this.registeredCount,
      this.onTapRegistered,
      this.onMenuAction,
      this.onDetailView,
      required this.meetingLink,
      required this.activeStatus,
      required this.chipTitle,
      required this.presenters,
      this.userType});

  @override
  State<CouresListingCard> createState() => _CouresListingCardState();
}

class _CouresListingCardState extends State<CouresListingCard> {
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    final presenters = widget.presenters ?? [];

    if (presenters.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (!mounted) return;

        setState(() {
          currentIndex = (currentIndex + 1) % presenters.length;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*final String time = (status == "ACTIVE")
        ? DateFormatUtils.formatTwoDateTime(createdAt)
        : DateFormatUtils.formatTwoDateTime(updatedAt);*/
    final time = DateFormatUtils.formatTwoDateTime(widget.createdAt);
    final List<String> presenterImages = widget.presenters!
        .where((e) => e.presentedByImage?.url != null)
        .map((e) => e.presentedByImage!.url!)
        .toList();
    final List<String> presenterNames = widget.presenters!
        .where((e) => e.presentedByName != null)
        .map((e) => e.presentedByName ?? "")
        .toList();

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
                            widget.logoUrl,
                            widget.companyName,
                            widget.courseTitle,
                            widget.status,
                            widget.activeStatus,
                            presenterImages,
                            presenterNames)),
                    Row(
                      children: [
                        _menuWidget(
                            context,
                            widget.types.isNotEmpty
                                ? widget.types.first
                                : null),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Text(currentPresenterName),
                const SizedBox(height: 8),
                _chipWidget(widget.types, widget.meetingLink, time),
                const SizedBox(height: 8),

                _descriptionWidget(widget.description, widget.index),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: widget.onTapRegistered,
                        child: _registeredChip(
                            widget.registeredCount, widget.chipTitle)),
                    GestureDetector(
                        onTap: widget.onDetailView,
                        child: Row(children: [
                          Text("View Details",
                              style: TextStyles.medium1(
                                  color: AppColors.primaryColor)),
                          SvgPicture.asset(ImageConst.nextArrow,
                              width: 26, height: 26)
                        ]))
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
    String activeStatus,
    List<String>? presenterImages,
    List<String>? presenterNames,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.geryColor,
              child: ClipOval(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: CachedNetworkImageWidget(
                      imageUrl: currentPresenterImage,
                      key: ValueKey(currentPresenterImage),
                    ),
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
              //const SizedBox(height: 2),
              //Text(title, style: TextStyles.regular2(color: AppColors.black)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(229, 244, 237, 1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Text(status == "APPROVE" ? activeStatus : status,
                    style: TextStyles.bold4(
                        color: StatusColors.getColor(status), fontSize: 10)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description, int index) {
    return SizedBox(
      width: double.infinity,
      child: ExpandableHtmlText(htmlData: description, index: index),
    );
  }

  Widget _chipWidget(List<String> types, String meetingLink, String time) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type.isEmpty ? 'N/A' : type;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlueColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: Text(label,
                        style: TextStyles.regular1(
                            color: AppColors.typeTextColor, fontSize: 12),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                (meetingLink.isNotEmpty &&
                        types.isNotEmpty &&
                        types.first == "Webinar")
                    ? _meetingLinkWidget(meetingLink)
                    : SizedBox.shrink(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_jobTimeChip(time)],
            )
          ],
        );
      }).toList(),
    );
  }

  String get currentPresenterName {
    if (widget.presenters == null || widget.presenters!.isEmpty) {
      return "";
    }

    if (currentIndex >= widget.presenters!.length) {
      return "";
    }

    return widget.presenters![currentIndex].presentedByName ?? "";
  }

  String get currentPresenterImage {
    if (widget.presenters == null || widget.presenters!.isEmpty) {
      return "";
    }

    if (currentIndex >= widget.presenters!.length) {
      return "";
    }

    return widget.presenters![currentIndex].presentedByImage?.url ?? "";
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
            final rawLink = link.trim();
            final fullLink =
                rawLink.startsWith('http://') || rawLink.startsWith('https://')
                    ? rawLink
                    : 'https://$rawLink';
            final url = Uri.parse(fullLink);
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
            style:
                TextStyles.regular1(color: AppColors.bottomNavUnSelectedColor),
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
                Color.fromRGBO(255, 241, 229, 1)
              ]),
          borderRadius: BorderRadius.circular(5)),
      child: Text("Posted on : $time",
          style: TextStyles.semiBold(
              fontSize: 10, color: const Color.fromRGBO(255, 112, 0, 1))),
    );
  }

  Widget _registeredChip(int registeredCount, String chipTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: AppColors.greyLight, borderRadius: BorderRadius.circular(10)),
      child: Text("$registeredCount $chipTitle",
          style: TextStyles.semiBold(fontSize: 10, color: AppColors.black)),
    );
  }

  Widget _menuWidget(BuildContext context, String? courseType) {
    return PopupMenuButton<String>(
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero, // removes inside padding
      constraints: const BoxConstraints(
          minWidth: 0, minHeight: 0), // remove default 48x48
      icon: Icon(Icons.more_vert,
          size: 20, color: AppColors.bottomNavUnSelectedColor),
      onSelected: (value) => widget.onMenuAction?.call(value, widget.id),
      itemBuilder: (context) => [
        _popupItem("Preview", Icons.remove_red_eye, AppColors.black),
        if (widget.userType == UserRole.admin.value &&
            (widget.status == "PENDING" || widget.status == "REJECT"))
          _popupItem("Approve", Icons.check, AppColors.greenColor),
        /*if (status != "EXPIRED" && courseType != "Online Academy")
          _popupItem("Edit", Icons.edit_outlined, AppColors.blueColor),*/
        if (widget.status != "APPROVE" &&
            widget.status != "EXPIRED" &&
            widget.status != "REJECT")
          _popupItem("Delete", Icons.delete_outline, AppColors.redColor),
        if (widget.activeStatus == "ACTIVE" && widget.status == "APPROVE")
          _popupItem(
              "Inactive", Icons.nightlight_outlined, AppColors.primaryColor),
        if (widget.activeStatus == "INACTIVE" && widget.status == "APPROVE")
          _popupItem(
              "Active", Icons.nightlight_outlined, AppColors.primaryColor),
        /*if (status == "EXPIRED")
          _popupItem("Re-Listing", Icons.edit_outlined, AppColors.blueColor),*/
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
}
