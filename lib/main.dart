import 'package:di360_flutter/data/local_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/routes/routes.dart';
import 'package:di360_flutter/feature/account/account_view_model/account_view_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repo_impl.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';
import 'package:di360_flutter/feature/clients/clients_provider/clients_provider.dart';
import 'package:di360_flutter/feature/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:di360_flutter/feature/login/login_view_model/login_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/no_internet/no_internet_view.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/applied_job.dart/view_model.dart/applied_job_view_model.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
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
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view_model/news_feed_community_comment_view_model.dart';
import 'package:di360_flutter/feature/notifications/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/feature/sign_up/view_model/signup_view_model.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/talent_enquiries/view_model/talent_enquiry_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/feature/team_members/view_model/team_members_view_model.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/firebase_options.dart';
import 'package:di360_flutter/feature/splash/splash_screen.dart';
import 'package:di360_flutter/services/deep_link_service.dart';
import 'package:di360_flutter/services/download_notification_service.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await NotificationService.initialize();
    await DownloadNotificationService.initialize();
    await NotificationService.initFirebaseMessaging();
    await NotificationService.captureInitialMessage();
  } catch (e) {}

  await DeepLinkService.init();
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
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
        ChangeNotifierProvider(create: (_) => EnquiriesViewModel()),
        ChangeNotifierProvider(create: (_) => SupportViewModel()),
        ChangeNotifierProvider(create: (_) => CommunityViewModel()),
        ChangeNotifierProvider(
            create: (_) => ProfileViewModel(ProfileRepositoryImpl())),
        ChangeNotifierProvider(create: (_) => NewsFeedCommunityViewModel()),
        ChangeNotifierProvider(create: (_) => DashBoardViewModel()),
        ChangeNotifierProvider(create: (_) => TalentEnquiryViewModel()),
        ChangeNotifierProvider(
            create: (_) => NewsFeedCommunityCommentViewModel()),
        ChangeNotifierProvider(create: (_) => CampaignViewModel()),
        ChangeNotifierProvider(create: (_) => TeamMembersViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(
            create: (_) => MarketPlaceLearningHubViewModel()),
        ChangeNotifierProvider(create: (_) => ClientsProvider()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          child = EasyLoading.init()(context, child);
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor,
            ),
          );
          return StreamBuilder<List<ConnectivityResult>>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final hasConnection = snapshot.data != null &&
                  snapshot.data!.isNotEmpty &&
                  snapshot.data!.first != ConnectivityResult.none;
              if (snapshot.hasData && !hasConnection) {
                return const SafeArea(child: NoInternetView());
              }
              return SafeArea(child: child!);
            },
          );
        },
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'dmSans',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorObservers: [navigationService],
        initialRoute: RouteList.initial,
        routes: Routes.routes,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => SplashScreen(),
        ),
      ),
    );
  }
}
