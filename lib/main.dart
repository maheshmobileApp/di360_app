import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/routes/routes.dart';
import 'package:di360_flutter/configuration/app_config.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/applied_job.dart/view_model.dart/applied_job_view_model.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/enquiries/view_model/enquiries_view_model.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/learning_hub_master_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/my_appointments/my_appointment_view_model/appointment_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/filter_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  print('Environment Base URL: ${AppConfig.hasuraBaseUrl}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => NewsFeedViewModel()),
        ChangeNotifierProvider(create: (_) => CommentViewModel()),
        ChangeNotifierProvider(create: (_) => AddNewsFeedViewModel()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => JobSeekViewModel()),
        ChangeNotifierProvider(create: (_) => TalentsViewModel()),
        ChangeNotifierProvider(create: (_) => CatalogueViewModel()),
        ChangeNotifierProvider(create: (_) => AddCatalogueViewModel()),
        ChangeNotifierProvider(create: (_) => JobListingsViewModel()),
        ChangeNotifierProvider(create: (_) => DirectoryViewModel()),
        ChangeNotifierProvider(create: (_) => TalentListingViewModel()),
        ChangeNotifierProvider(create: (_) => AddDirectoryViewModel()),
        ChangeNotifierProvider(create: (_) => AppliedJobViewModel()),
        ChangeNotifierProvider(create: (_) => JobProfileListingViewModel()),
        ChangeNotifierProvider(create: (_) => EditDeleteDirectorViewModel()),
        ChangeNotifierProvider(create: (_) => NewCourseViewModel()),
        ChangeNotifierProvider(create: (_) => CourseListingViewModel()),
        ChangeNotifierProvider(create: (_) => ProfessionalAddDirectorVm()),
        ChangeNotifierProvider(create: (_) => MyLearningHubViewModel()),
        ChangeNotifierProvider(create: (_) => AppointmentViewModel()),
        ChangeNotifierProvider(create: (_) => BannersViewModel()),
        ChangeNotifierProvider(create: (_) => LearningHubMasterViewModel()),
        ChangeNotifierProvider(create: (_) => FilterViewModel()),
        ChangeNotifierProvider(create: (_) => JobCreateViewModel()),
        ChangeNotifierProvider(create: (_) => ViewProfileViewModel()),
        ChangeNotifierProvider(create: (_) => EnquiriesViewModel()),
        ChangeNotifierProvider(create: (_) => SupportViewModel()),
        ChangeNotifierProvider(create: (_) => CommunityViewModel()),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'dmSans',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorObservers: [navigationService],
          initialRoute: RouteList.initial,
          routes: Routes.routes),
    );
  }
}
