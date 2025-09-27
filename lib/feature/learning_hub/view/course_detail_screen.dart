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
import 'package:di360_flutter/feature/learning_hub/widgets/register_now_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/sponsors_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CourseDetailScreen extends StatelessWidget with BaseContextHelpers {
  const CourseDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final courseDetails = courseListingVM.courseDetails.first;

    return Scaffold(
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
                          courseDetails.courseName ?? '',
                          style: TextStyles.bold2(color: AppColors.black),
                        )
                      : null,
                  background: CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      viewportFraction: 1.0, // full width
                      enableInfiniteScroll: true,
                    ),
                    items: (courseDetails.courseBannerImage ?? [])
                        .map((e) => e.url ?? "")
                        .where((url) => url.isNotEmpty)
                        .map(
                          (url) => BannerImageWidget(imageUrl: url),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            leading: Container(
              margin: const EdgeInsets.all(8), // outer spacing
              decoration: const BoxDecoration(
                color: Colors.white, // white background
                shape: BoxShape.circle, // circular button
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CourseInfoCardWidget(
                          time: "",
                          date: courseDetails.startDate ?? "",
                          courseName: courseDetails.courseName ?? "",
                          profilePic: courseDetails.presentedByImage?.url ?? "",
                          presentByName: courseDetails.presentedByName ?? "",
                          cpdHours:
                              courseDetails.cpdPoints?.toInt().toString() ??
                                  "0",
                          platform: courseDetails.type ?? "",
                          webinar: courseDetails.feedType ?? "",
                          totalPrice: courseDetails.afterwardsPrice.toString(),
                          discountPrice:
                              courseDetails.earlyBirdPrice.toString(),
                        ),
                        const SizedBox(height: 12),
                        CourseDescriptionWidget(
                            title: 'Course Description',
                            description: courseDetails.description ?? ""),
                        const SizedBox(height: 12),
                        (courseDetails.courseEventInfo?.first.info == "")
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  EventDayDataWidget(
                                      title:
                                          '${courseDetails.eventType ?? ""} Event',
                                      descriptions:
                                          courseDetails.courseEventInfo ?? []),
                                  GalleryImgWidget(
                                    imageUrls: (courseDetails.courseEventInfo
                                                ?.first.images ??
                                            [])
                                        .map((e) => e.url ?? "")
                                        .where((url) => url.isNotEmpty)
                                        .toList(),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 12),
                        GalleryImgWidget(
                          title: "Gallery",
                          imageUrls: (courseDetails.courseGallery ?? [])
                              .map((e) => e.url ?? "")
                              .where((url) => url.isNotEmpty)
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        (courseDetails.sponsorByImage?.length== 0)?SizedBox.shrink(): GalleryImgWidget(
                          title: "Sponsors",
                          height: 100,
                          width: 100,
                          imageUrls: (courseDetails.sponsorByImage ?? [])
                              .map((e) => e.url ?? "")
                              .where((url) => url.isNotEmpty)
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        (courseDetails.terms=="")?SizedBox.shrink():  CourseDescriptionWidget(
                            title: 'Terms & Conditions',
                            description: courseDetails.terms ?? ""),
                        const SizedBox(height: 12),
                          (courseDetails.refundPolicy=="")?SizedBox.shrink():   CourseDescriptionWidget(
                            title: 'Cancellation & Refund Policy',
                            description: courseDetails.refundPolicy ?? ""),
                        const SizedBox(height: 12),
                        ContactInfoWidget(
                            location: courseDetails.address ?? "",
                            email: courseDetails.contactEmail ?? "",
                            phoneNumber: courseDetails.contactPhone ?? ""),
                        (courseDetails.address != null &&
                                courseDetails.address!.isNotEmpty)
                            ? LocationViewWidget(
                                location: courseDetails.address!,
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const Divider(),
                  RegisterNowWidget(
                    currentPrice: courseDetails.earlyBirdPrice.toString(),
                    oldPrice: courseDetails.afterwardsPrice.toString(),
                    onPressed: () {
                      courseListingVM.setCourseId(courseDetails.id ?? "");
                      RegistrationUserForm.show(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
