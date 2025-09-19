import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/contact_info_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/course_description_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/course_info_card_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/sponsors_image_widget.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget with BaseContextHelpers {
  final CoursesListingDetails job;
  const CourseDetailScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            backgroundColor: AppColors.whiteColor,
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
                          job.courseName ?? '',
                          style: TextStyles.medium2(color: AppColors.black),
                        )
                      : null,
                  background: CachedNetworkImageWidget(
                    imageUrl:
                        'https://blogassets.leverageedu.com/blog/wp-content/uploads/2020/11/09210122/Dental-Courses-380x220.jpg',
                    width: double.infinity,
                  ),
                );
              },
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const CourseInfoCardWidget(
                    courseName: "Course Name",
                    presentByName: 'Dr. Sandeep',
                    cpdHours: '6 Hrs',
                    platform: 'Online',
                    webinar: 'Google',
                  ),
                  const SizedBox(height: 12),
                  const CourseDescriptionWidget(),
                  /*SponsorsImageWidget(
                    imagePaths: [
                      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                    ],
                  ),*/
                  ContactInfoWidget(
                      location: '138 Marsh Street, Armidale, NSW 2350',
                      email: 'test@gmail.com',
                      phoneNumber: '9874563210')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const CourseInfoCardWidget(),
            const SizedBox(height: 12),
            const CourseDescriptionWidget(),
          ],
        ),
      ),
    );
  }*/
}
