import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view/registration_user_form.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/banner_image_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/contact_info_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/course_description_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/course_info_card_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/event_day_data_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/gallery_img_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/location_view_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/media_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/register_now_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CourseDetailScreen extends StatelessWidget with BaseContextHelpers {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseListingVM = Provider.of<CourseListingViewModel>(context);

    if (courseListingVM.courseDetails.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No course details available")),
      );
    }

    final courseDetails = courseListingVM.courseDetails.isNotEmpty
        ? courseListingVM.courseDetails.first
        : null;

    final headerBannerUrls = (courseDetails?.courseBannerVideo ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final bannerUrls = (courseDetails?.courseBannerImage ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final galleryUrls = (courseDetails?.courseGallery ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final sponsorUrls = (courseDetails?.sponsorByImage ?? [])
        .map((e) => e.url ?? "")
        .where((url) => url.isNotEmpty)
        .toList();

    final firstEventInfo = (courseDetails?.courseEventInfo?.isNotEmpty ?? false)
        ? courseDetails?.courseEventInfo!.first
        : null;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            iconTheme: const IconThemeData(color: AppColors.black),
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final isCollapsed =
                    top <= kToolbarHeight + MediaQuery.of(context).padding.top;

                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: isCollapsed
                      ? Text(
                          courseDetails?.courseName ?? '',
                          style: TextStyles.bold2(color: AppColors.black),
                        )
                      : null,
                  background: (bannerUrls.isEmpty)
                      ? const SizedBox.shrink()
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            autoPlay: true,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: true,
                          ),
                          items: bannerUrls
                              .map((url) => BannerImageWidget(imageUrl: url))
                              .toList(),
                        ),
                );
              },
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CourseInfoCardWidget(
                      time: "",
                      startDate: courseDetails?.startDate ?? "",
                      endDate: courseDetails?.endDate ?? "",
                      courseName: courseDetails?.courseName ?? "",
                      profilePic: courseDetails?.presentedByImage?.url ?? "",
                      presentByName: courseDetails?.presentedByName ?? "",
                      cpdHours:
                          courseDetails?.cpdPoints?.toInt().toString() ?? "0",
                      platform: courseDetails?.type ?? "",
                      webinar: courseDetails?.feedType ?? "",
                      totalPrice:
                          courseDetails?.afterwardsPrice?.toString() ?? "0",
                      discountPrice:
                          courseDetails?.earlyBirdPrice?.toString() ?? "0",
                    ),
                    const SizedBox(height: 12),
                    if (headerBannerUrls.isNotEmpty)
                      MediaWidget(
                        url: courseDetails?.courseBannerVideo?.first.url ?? "",
                        name:
                            courseDetails?.courseBannerVideo?.first.name ?? "",
                      ),
                    const SizedBox(height: 12),
                    if (courseDetails?.description != "")
                      CourseDescriptionWidget(
                        title: 'Course Description',
                        description: courseDetails?.description ?? "",
                      ),
                    const SizedBox(height: 12),
                    if ((courseDetails?.courseEventInfo?.isNotEmpty ??
                        false)) ...[
                      ...courseDetails!.courseEventInfo!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key; // 0,1,2...
                        final eventInfo = entry.value; // actual event

                        final images = (eventInfo.images ?? [])
                            .map((e) => e.url ?? "")
                            .where((url) => url.isNotEmpty)
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EventDayDataWidget(
                              title: (courseDetails.eventType == "Single Day")
                                  ? "${courseDetails.eventType ?? ""} Event"
                                  : "${courseDetails.eventType ?? ""} Event - Day ${index + 1}", // 👈 dynamic day title
                              descriptions: [eventInfo],
                            ),
                            if (images.isNotEmpty)
                              GalleryImgWidget(
                                imageUrls: images,
                              ),
                          ],
                        );
                      }),
                    ],
                    const SizedBox(height: 12),
                    if (galleryUrls.isNotEmpty)
                      GalleryImgWidget(
                          title: "Gallery", imageUrls: galleryUrls),
                    const SizedBox(height: 12),
                    if (sponsorUrls.isNotEmpty)
                      GalleryImgWidget(
                        title: "Sponsors",
                        height: 100,
                        width: 100,
                        imageUrls: sponsorUrls,
                      ),
                    const SizedBox(height: 12),
                    if ((courseDetails?.terms ?? "").isNotEmpty)
                      CourseDescriptionWidget(
                        title: 'Terms & Conditions',
                        description: courseDetails?.terms ?? "",
                      ),
                    const SizedBox(height: 12),
                    if ((courseDetails?.refundPolicy ?? "").isNotEmpty)
                      CourseDescriptionWidget(
                        title: 'Cancellation & Refund Policy',
                        description: courseDetails?.refundPolicy ?? "",
                      ),
                    const SizedBox(height: 12),
                    if (courseDetails?.address != "" &&
                        courseDetails?.contactEmail != "" &&
                        courseDetails?.contactPhone != "")
                      ContactInfoWidget(
                        location: courseDetails?.address ?? "",
                        email: courseDetails?.contactEmail ?? "",
                        phoneNumber: courseDetails?.contactPhone ?? "",
                      ),
                    if ((courseDetails?.address ?? "").isNotEmpty)
                      LocationViewWidget(location: courseDetails?.address!),
                    (courseDetails?.status == "APPROVE")
                        ? Column(
                            children: [
                              const Divider(),
                              RegisterNowWidget(
                                currentPrice:
                                    courseDetails?.earlyBirdPrice?.toString() ??
                                        "0",
                                oldPrice: courseDetails?.afterwardsPrice
                                        ?.toString() ??
                                    "0",
                                onPressed: () {
                                  courseListingVM
                                      .setCourseId(courseDetails?.id ?? "");
                                  RegistrationUserForm.show(
                                      context, courseDetails?.courseName ?? "");
                                },
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
