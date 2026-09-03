import 'dart:async';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/register_button.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/sold_out_button.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListingHubMasterCard extends StatefulWidget {
  final String? feedId;
  final List<CourseBannerImage>? imageUrls;
  final String companyName;
  final String description;
  final String date;
  final String cpdHours;
  final String location;
  final bool isFree;
  final VoidCallback onTap;
  final List<Presenters>? presenters;
  final String profilePic;
  final String presenterName;
  final VoidCallback registerTap;
  final dynamic afterWardsPrice;
  final bool isRegistered;
  final String? type;
  final dynamic noOfSeats;
  final int? registerCount;
  final String? expiryDateCount;
  final String? courseStatus;

  const ListingHubMasterCard({
    super.key,
    required this.feedId,
    required this.imageUrls,
    required this.companyName,
    required this.description,
    required this.date,
    required this.cpdHours,
    required this.location,
    this.isFree = true,
    required this.onTap,
    required this.profilePic,
    required this.presenters,
    required this.presenterName,
    required this.registerTap,
    required this.afterWardsPrice,
    required this.isRegistered,
    this.type,
    this.noOfSeats,
    this.registerCount,
    this.expiryDateCount,
    this.courseStatus,
  });

  @override
  State<ListingHubMasterCard> createState() => _ListingHubMasterCardState();
}

class _ListingHubMasterCardState extends State<ListingHubMasterCard> {
  final PageController _imagePageController = PageController();
  final PageController _presenterPageController = PageController();

  Timer? _imageTimer;
  Timer? _presenterTimer;

  int _currentImageIndex = 0;
  int _currentPresenterIndex = 0;
  @override
  void initState() {
    super.initState();

    if ((widget.imageUrls?.length ?? 0) > 1) {
      _imageTimer = Timer.periodic(
        const Duration(seconds: 3),
        (_) {
          if (!_imagePageController.hasClients) return;

          int nextIndex = _currentImageIndex + 1;

          if (nextIndex >= widget.imageUrls!.length) {
            nextIndex = 0;
          }

          _imagePageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      );
    }

    if ((widget.presenters?.length ?? 0) > 1) {
      _presenterTimer = Timer.periodic(
        const Duration(seconds: 3),
        (_) {
          if (!_presenterPageController.hasClients) return;

          int nextIndex = _currentPresenterIndex + 1;

          if (nextIndex >= widget.presenters!.length) {
            nextIndex = 0;
          }

          _presenterPageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _presenterTimer?.cancel();

    _imagePageController.dispose();
    _presenterPageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _imagePageController,
                      itemCount: widget.imageUrls?.length ?? 0,
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return CachedNetworkImageWidget(
                          imageUrl: widget.imageUrls?[index].url ?? '',
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorWidget: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: AppColors.lightGeryColor,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                          getSeatStatus(
                            noOfSeats: widget.noOfSeats,
                            registerCount: widget.registerCount,
                            afterWardsPrice: widget.afterWardsPrice,
                          ),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              // Info section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PRESENTED BY",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: PageView.builder(
                              controller: _presenterPageController,
                              itemCount: widget.presenters?.length ?? 0,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPresenterIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final presenter = widget.presenters![index];

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.geryColor,
                                      radius: 15,
                                      child: ClipOval(
                                        child: CachedNetworkImageWidget(
                                          imageUrl:
                                              presenter.presentedByImage?.url ??
                                                  ImageConst.prfImg,
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                          errorWidget: Image.asset(
                                            ImageConst.prfImg,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        presenter.presentedByName
                                                ?.toUpperCase() ??
                                            '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            _circleIcon(),
                            SizedBox(width: 10),
                            ShareWidget(
                                category: FeedType.learnhub.name,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                size: 20,
                                feedId: widget.feedId ?? ""),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(widget.companyName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.type ?? '',
                            style: TextStyles.medium2(color: AppColors.black)),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: AppColors.primaryColor, size: 20),
                            const SizedBox(width: 6),
                            Text("CPD HOURS: ${widget.cpdHours}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyles.medium2(color: AppColors.black)),
                          ],
                        ),
                        if (widget.isRegistered &&
                            widget.type == "Online Academy" &&
                            widget.courseStatus != "EXPIRED")
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  (widget.courseStatus == "PENDING")
                                      ? "You purchased this course"
                                      : "You purchased this course ${_expiryLabel()}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.medium2(
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 4),
                        (widget.location.isEmpty)
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: AppColors.primaryColor, size: 20),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      (widget.location.isEmpty)
                                          ? ""
                                          : "${widget.location}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.medium2(
                                          color: AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 4),
                        (widget.date.isEmpty)
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                      color: AppColors.primaryColor, size: 20),
                                  const SizedBox(width: 6),
                                  Text(
                                      (widget.date.isEmpty)
                                          ? "------"
                                          : DateFormat("dd MMM").format(
                                              DateTime.parse(widget.date)),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.medium2(
                                          color: AppColors.primaryColor))
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              (getSeatStatus(
                          noOfSeats: widget.noOfSeats,
                          registerCount: widget.registerCount,
                          afterWardsPrice: widget.afterWardsPrice) ==
                      "SOLD OUT")
                  ? SoldOutButton()
                  : RegisterButton(
                      courseStatus: widget.courseStatus ?? "",
                      text: widget.isRegistered &&
                              widget.courseStatus != "EXPIRED"
                          ? (widget.type == "Online Academy")
                              ? widget.courseStatus == "PENDING"
                                  ? "Awaiting Approval"
                                  : "View Course Details"
                              : "Already Registered"
                          : 'Register Now',
                      onTap: widget.registerTap,
                      isRegistered: widget.isRegistered &&
                          widget.courseStatus != "EXPIRED")
            ],
          ),
        ),
      ),
    );
  }

  String getSeatStatus({
    int? noOfSeats,
    int? registerCount,
    double? afterWardsPrice,
  }) {
    if (noOfSeats != null) {
      final remaining = noOfSeats - (registerCount ?? 0);
      /*final isUnlimited = courseType == "Online Academy" &&
          afterWardsPrice == 0 &&
          noOfSeats == null;*/

      if (remaining <= 0) {
        return "SOLD OUT";
      } else if (remaining <= 10) {
        return "HURRY UP!! Only $remaining SEATS LEFT";
      } else {
        return "FILLING FAST!";
      }
    }

    return (afterWardsPrice ?? 0) == 0 ? "FREE MASTERCLASS" : "PAID";
  }

  String _expiryLabel() {
    if (widget.expiryDateCount == "Life Time") {
      return '';
    }
    final count = int.tryParse(widget.expiryDateCount ?? '0') ?? 0;
    if (count == 0) return '- Access expires today';
    if (count == 1) return '- Access expires tomorrow';
    return '- Access expires in $count day';
  }

  Widget _circleIcon() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Icon(
            Icons.north_east,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ));
  }
}
