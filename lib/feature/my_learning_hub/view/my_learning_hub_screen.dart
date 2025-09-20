import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listings_card_widget.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/model/filter_section_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/filter_section_widget.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/register_course_card.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyLearningHubScreen extends StatefulWidget {
  const MyLearningHubScreen({super.key});

  @override
  State<MyLearningHubScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<MyLearningHubScreen>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    // final jobListingVM =
    //     Provider.of<JobListingsViewModel>(context, listen: false);
    // jobListingVM.fetchJobStatusCounts();
  }

  @override
  Widget build(BuildContext context) {
    //final notificationVM = Provider.of<NotificationViewModel>(context);
    //final jobListingVM = Provider.of<JobListingsViewModel>(context);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                'My Learning Hub',
                style: TextStyles.bold4(color: AppColors.black),
              ),
              Positioned(
                top: -9,
                right: -18,
                child: SvgPicture.asset(
                  ImageConst.logo,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
          actions: [
            addHorizontal(15),
            SvgPicture.asset(ImageConst.search, color: AppColors.black),
            addHorizontal(15),
            GestureDetector(
              onTap: () => {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => FilterBottomSheet(
                    sections: [
                      FilterSectionModel(
                        title: "Filter by Type",
                        options: ["Online", "Live", "Webinar"],
                      ),
                     /* FilterSectionModel(
                        title: "Category",
                        options: [
                          "Restorative",
                          "Endodontics",
                          "Prosthodontics",
                          "Oral surgery",
                        ],
                      ),
                      FilterSectionModel(
                        title: "Speaker",
                        options: ["Speaker 1", "Speaker 2", "Speaker 3"],
                      ),*/
                    ],
                    onApply: () {
                      // ✅ handle apply logic
                    },
                    onClear: () {
                      // ✅ handle clear logic
                    },
                  ),
                )
              },
              //navigationService.navigateTo(RouteList.JobSeekFilterScreen),
              child:
                  SvgPicture.asset(ImageConst.filter, color: AppColors.black),
            ),
            addHorizontal(15),
          ],
        ),
        body: Column(
          children: [
            Divider(),
            Expanded(
              child: /*jobListingVM.myJobListingList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Data.",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : */
                  ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  //final jobData = jobListingVM.myJobListingList[index];
                  //print(jobListingVM.myJobListingList.length);
                  return RegisterCourseCard(
                    logo: "",
                    cpdPoints: "10",
                    courseName: "Flutter",
                    name: "Name",
                    status: "Active",
                    types: ['webinar'],
                    link: "https://workspace.google.com/products/meet/",
                    onCardTap: navigationService.goBack,
                    createdAt: "2025-09-15 12:30:00",
                  );
                },
              ),
            ),
          ],
        ));
  }
}
