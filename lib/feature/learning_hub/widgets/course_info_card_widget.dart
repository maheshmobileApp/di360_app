import 'dart:async';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/media_widget.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class CourseInfoCardWidget extends StatefulWidget {
  final String address;
  final String courseName;
  final List<Presenters>? presenters;
  final String cpdHours;
  final String platform;
  final String webinar;
  final String profilePic;
  final String? totalPrice;
  final String? discountPrice;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String bannerUrl;
  final String bannerName;
  final String? creatAt;
  final bool? registerStatus;
  final String? courseStatus;
  final String? expiryDate;

  const CourseInfoCardWidget(
      {super.key,
      required this.address,
      required this.courseName,
      required this.presenters,
      required this.cpdHours,
      required this.platform,
      required this.webinar,
      required this.profilePic,
      required this.totalPrice,
      required this.discountPrice,
      required this.startDate,
      required this.endDate,
      required this.bannerUrl,
      required this.bannerName,
      required this.startTime,
      required this.endTime,
      this.creatAt,
      this.registerStatus,
      this.courseStatus,
      this.expiryDate});

  @override
  State<CourseInfoCardWidget> createState() => _CourseInfoCardWidgetState();
}

class _CourseInfoCardWidgetState extends State<CourseInfoCardWidget> {
  final PageController _presenterPageController = PageController();
  int _currentPresenterIndex = 0;
  Timer? _presenterTimer;
  @override
  void initState() {
    super.initState();

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
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Container(height: 50, width: 5, color: AppColors.primaryColor),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.courseName}",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text("A Comprehensive Guide",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.registerStatus == true &&
                          widget.courseStatus != "PENDING" &&
                          widget.courseStatus != "EXPIRED")
                        Text("Already Registered",
                            style: TextStyles.medium2(
                                color: AppColors.greenColor)),
                      const SizedBox(height: 4)
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PRESENTED BY",
                              style:
                                  TextStyles.medium1(color: AppColors.black)),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: PageView.builder(
                                    controller: _presenterPageController,
                                    itemCount: widget.presenters?.length ?? 0,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentPresenterIndex = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      final presenter =
                                          widget.presenters![index];

                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColors.geryColor,
                                            radius: 15,
                                            child: ClipOval(
                                              child: CachedNetworkImageWidget(
                                                imageUrl: presenter
                                                        .presentedByImage
                                                        ?.url ??
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                          if (widget.platform == "Online Academy" &&
                              widget.registerStatus == true &&
                              widget.courseStatus != "PENDING" &&
                              widget.courseStatus != "EXPIRED" &&
                              widget.expiryDate != '')
                            Text("Expires on : ${widget.expiryDate}"),
                          if (widget.platform != "Online Academy")
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_month_outlined,
                                    color: AppColors.primaryColor, size: 20),
                                const SizedBox(width: 4),
                                if (widget.startDate.isNotEmpty &&
                                    widget.endDate.isNotEmpty)
                                  Flexible(
                                      child: Text(
                                          DateFormatUtils.formatDateRange(
                                              widget.startDate, widget.endDate),
                                          maxLines: 2)),
                              ],
                            ),
                          const SizedBox(height: 4),
                          if (widget.startTime.isNotEmpty &&
                              widget.endTime.isNotEmpty)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time_rounded,
                                    color: AppColors.primaryColor, size: 20),
                                const SizedBox(width: 4),
                                Flexible(
                                    child: Text(
                                        '${DateFormatUtils.formatTime(widget.startTime)}  –  ${DateFormatUtils.formatTime(widget.endTime)}',
                                        maxLines: 2)),
                              ],
                            ),
                        ]))
                  ],
                ),
                const SizedBox(height: 4),
                const Divider(),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoTextWidget(
                            label: "CPD Hours",
                            first: true,
                            value: "${widget.cpdHours}",
                          ),
                          const SizedBox(height: 6),
                          _InfoTextWidget(
                            label: "Price",
                            first: true,
                            value: (widget.totalPrice == 0)
                                ? "\$${widget.totalPrice != null ? double.tryParse(widget.totalPrice!)?.toStringAsFixed(0) ?? widget.totalPrice : ''}"
                                : "FREE",
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _InfoTextWidget(
                              label: "How",
                              first: false,
                              value: "${widget.platform}"),
                          const SizedBox(height: 6),
                          _InfoTextWidget(
                              label: "Where",
                              first: false,
                              value: widget.address.isNotEmpty
                                  ? "${widget.address}"
                                  : "Online"),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.bannerUrl.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  MediaWidget(url: widget.bannerUrl, name: widget.bannerName)
                ],
                const SizedBox(height: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTextWidget extends StatelessWidget {
  final String label;
  final String value;

  final bool first;

  const _InfoTextWidget(
      {required this.label, required this.value, required this.first});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          first ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(value,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black)),
        ),
      ],
    );
  }
}
