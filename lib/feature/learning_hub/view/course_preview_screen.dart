import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/banner_image_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/contact_info_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/course_description_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/course_info_card_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/event_day_data_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/gallery_img_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/location_view_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/register_now_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CoursePreviewScreen extends StatelessWidget with BaseContextHelpers {
  final CoursesListingDetails courseDetails;
  final bool showRegisterButton;
  final VoidCallback? onRegisterPressed;

  const CoursePreviewScreen({
    super.key,
    required this.courseDetails,
    this.showRegisterButton = true,
    this.onRegisterPressed,
  });

  String _getAddressAsString(dynamic address) {
    if (address == null) return "";
    if (address is String) return address;
    if (address is List) {
      return address.map((e) => e.toString()).join(", ");
    }
    return address.toString();
  }

  String _safeToString(dynamic value) {
    if (value == null) return "0";
    if (value is String) return value;
    if (value is int || value is double) return value.toString();
    return value.toString();
  }

  String _safeCpdPointsToString(dynamic cpdPoints) {
    if (cpdPoints == null) return "0";
    if (cpdPoints is String) return cpdPoints;
    if (cpdPoints is double) return cpdPoints.toInt().toString();
    if (cpdPoints is int) return cpdPoints.toString();
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    final bannerUrls = (courseDetails.courseBannerImage ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final galleryUrls = (courseDetails.courseGallery ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final sponsorUrls = (courseDetails.sponsorByImage ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final bannerUrl = (courseDetails.courseBannerVideo != null &&
            courseDetails.courseBannerVideo!.isNotEmpty)
        ? courseDetails.courseBannerVideo?.first.url ?? ""
        : "";

    final bannerName = (courseDetails.courseBannerVideo != null &&
            courseDetails.courseBannerVideo!.isNotEmpty)
        ? courseDetails.courseBannerVideo?.first.name ?? ""
        : "";

    return Scaffold(
      backgroundColor: AppColors.greyLightcolor,
      appBar: AppBar(
        title: Text(
          courseDetails.courseName ?? 'Course Preview',
          style: TextStyles.bold2(color: AppColors.black),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      bottomNavigationBar: showRegisterButton && (courseDetails.status == "APPROVE")
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RegisterNowWidget(
                    earlyBirdEndDate: courseDetails.earlyBirdEndDate,
                    registerStatus: false, // You can pass this as parameter if needed
                    currentPrice: _safeToString(courseDetails.earlyBirdPrice),
                    oldPrice: _safeToString(courseDetails.afterwardsPrice),
                    onPressed: onRegisterPressed,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            if (bannerUrls.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                  ),
                  items: bannerUrls
                      .map((url) => BannerImageWidget(imageUrl: url))
                      .toList(),
                ),
              ),
            
            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                color: AppColors.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Info Card
                      CourseInfoCardWidget(
                        startTime: courseDetails.startTime ?? "",
                        endTime: courseDetails.endTime ?? "",
                        startDate: courseDetails.startDate ?? "",
                        endDate: courseDetails.endDate ?? "",
                        courseName: courseDetails.courseName ?? "",
                        profilePic: courseDetails.presentedByImage?.url ?? "",
                        presentByName: courseDetails.presentedByName ?? "",
                        cpdHours: _safeCpdPointsToString(courseDetails.cpdPoints),
                        platform: courseDetails.type ?? "",
                        webinar: courseDetails.feedType ?? "",
                        totalPrice: _safeToString(courseDetails.afterwardsPrice),
                        discountPrice: _safeToString(courseDetails.earlyBirdPrice),
                        bannerUrl: bannerUrl,
                        bannerName: bannerName,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Course Description
                      if ((courseDetails.description ?? "").isNotEmpty)
                        CourseDescriptionWidget(
                          title: 'Course Description',
                          description: courseDetails.description ?? "",
                        ),
                      
                      const SizedBox(height: 12),
                      
                      // Event Type
                      Text(
                        (courseDetails.eventType == "Single Day")
                            ? "Single Day Event"
                            : "Multiple Day Event",
                        style: TextStyles.bold2(color: AppColors.primaryColor),
                      ),
                      
                      const SizedBox(height: 6),
                      
                      // Event Info
                      if (courseDetails.courseEventInfo != null &&
                          courseDetails.courseEventInfo!.isNotEmpty) ...[
                        ...courseDetails.courseEventInfo!
                            .asMap()
                            .entries
                            .map((entry) {
                          final eventInfo = entry.value;
                          final images = (eventInfo.images ?? [])
                              .map((e) => e.url ?? "")
                              .where((url) => url.isNotEmpty)
                              .toList();
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EventDayDataWidget(
                                descriptions: [eventInfo],
                                images: images,
                              ),
                            ],
                          );
                        }),
                      ],
                      
                      const SizedBox(height: 12),
                      
                      // Gallery
                      if (galleryUrls.isNotEmpty)
                        GalleryImgWidget(
                          title: "Gallery",
                          imageUrls: galleryUrls,
                        ),
                      
                      const SizedBox(height: 12),
                      
                      // Sponsors
                      if (sponsorUrls.isNotEmpty)
                        GalleryImgWidget(
                          title: "Sponsored by",
                          height: 100,
                          width: 100,
                          imageUrls: sponsorUrls,
                        ),
                      
                      const SizedBox(height: 12),
                      
                      // Terms & Conditions
                      if ((courseDetails.terms ?? "").isNotEmpty)
                        CourseDescriptionWidget(
                          title: 'Terms & Conditions',
                          description: courseDetails.terms ?? "",
                        ),
                      
                      const SizedBox(height: 12),
                      
                      // Refund Policy
                      if ((courseDetails.refundPolicy ?? "").isNotEmpty)
                        CourseDescriptionWidget(
                          title: 'Cancellation & Refund Policy',
                          description: courseDetails.refundPolicy ?? "",
                        ),
                      
                      const SizedBox(height: 12),
                      
                      // Contact Info
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        color: AppColors.greyLight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ContactInfoWidget(
                                location: _getAddressAsString(courseDetails.address),
                                email: courseDetails.contactEmail ?? "",
                                phoneNumber: courseDetails.contactPhone ?? "",
                              ),
                              if (_getAddressAsString(courseDetails.address).isNotEmpty)
                                LocationViewWidget(
                                  location: _getAddressAsString(courseDetails.address),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}