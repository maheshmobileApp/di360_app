import 'package:di360_flutter/feature/account/view/account_view_screen.dart';
import 'package:di360_flutter/feature/add_catalogues/view/add_catalogue_screen.dart';
import 'package:di360_flutter/feature/add_catalogues/view/my_catalogue_filter_widget.dart';
import 'package:di360_flutter/feature/add_catalogues/view/my_catalogues_screen.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view/my_director/my_director_screen.dart';
import 'package:di360_flutter/feature/add_news_feed/view/add_news_feed_screen.dart';
import 'package:di360_flutter/feature/applied_job.dart/view/applied_job_screen.dart';
import 'package:di360_flutter/feature/banners/view/add_banners_screen.dart';
import 'package:di360_flutter/feature/banners/view/banners_list_screen.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_details_screen.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_filter_screen.dart';
import 'package:di360_flutter/feature/dash_board/dash_board.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_details_screen.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_quicklincks.dart';
import 'package:di360_flutter/feature/directors/view/director_screen.dart';
import 'package:di360_flutter/feature/directors/view/directories_filter_screen.dart';
import 'package:di360_flutter/feature/enquiries/view/enquiries_screen.dart';
import 'package:di360_flutter/feature/job_create/view/job_create_view.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_messege.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_screen.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_screen.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_view.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_screen.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/my_job_profile_screen.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/view/apply_job_view.dart';
import 'package:di360_flutter/feature/job_seek/view/job_details.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_filter.dart';
import 'package:di360_flutter/feature/learning_hub/view/add_course.dart';
import 'package:di360_flutter/feature/learning_hub/view/contacts.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_detail_screen.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_info.dart';
import 'package:di360_flutter/feature/learning_hub/view/learning_hub_screen.dart';
import 'package:di360_flutter/feature/learning_hub/view/new_course_screen.dart';
import 'package:di360_flutter/feature/learning_hub/view/registered_users_view.dart';
import 'package:di360_flutter/feature/learning_hub/view/terms_and_conditions.dart';
import 'package:di360_flutter/feature/login/login_screen.dart';
import 'package:di360_flutter/feature/login/login_view_model/login_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view/my_learning_hub_screen.dart';
import 'package:di360_flutter/feature/pre_login/pre_login_screen.dart';
import 'package:di360_flutter/feature/professional_add_director/view/add_profess_director/add_profess_director_screen.dart';
import 'package:di360_flutter/feature/professional_add_director/view/professional_director_view/professional_director_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/plan_details_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/practice_details_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/role_selection_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/signup_screen.dart';
import 'package:di360_flutter/feature/splash/splash_screen.dart';
import 'package:di360_flutter/feature/talent_listing/view/talent_listing_filter.dart';
import 'package:di360_flutter/feature/talent_listing/view/talent_listing_screen.dart';
import 'package:di360_flutter/feature/talents/views/talents_details_view.dart';
import 'package:provider/provider.dart';

import '../../feature/talents/model/job_profile.dart';
import 'route_list.dart';
import 'package:flutter/material.dart';
//   ChangeNotifierProvider(create: (_) => JobCreateViewModel()),
//LoginViewModel
class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      RouteList.splash: (context) => SplashScreen(),
      RouteList.preLogin: (context) => PreLoginScreen(),
      RouteList.login: (context) => ChangeNotifierProvider(
          create: (_) => LoginViewModel(), child: LoginScreen()),
      RouteList.dashBoard: (context) => ChangeNotifierProvider(
            create: (context) => DashBoardViewModel(),
            child: DashBoard(),
          ),
      RouteList.addNewsFeed: (context) => AddNewsFeedScreen(),
      RouteList.subscribePlan: (context) => SubscriptionPlanScreen(),
      RouteList.signup: (context) => SignupScreen(),
      RouteList.roleScreen: (context) => RoleSelectionScreen(),
      RouteList.practiceDetailsScreen: (context) => PracticeDetailsScreen(),
      RouteList.jobCreate: (context) => ChangeNotifierProvider(
          create: (BuildContext context) => JobCreateViewModel(),
          child: JobCreateView()),
      RouteList.JobSeekFilterScreen: (context) => JobSeekFilterScreen(),
      RouteList.applyJob: (context) => ApplyJobsView(),
      RouteList.account: (context) => AccountScreen(),
      RouteList.JobProfileView: (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        final profileData = args['profileData'] ?? null;
        return ChangeNotifierProvider(
          create: (BuildContext context) => JobProfileCreateViewModel(),
          child: JobProfileView(
            profile: profileData, isEdit: null,
          ),
        );
      },
      RouteList.JobListingScreen: (context) => JobListingScreen(),
      RouteList.JobProfileScreen: (context) => JobProfileScreen(),
      RouteList.directorQuickLinks: (context) => DirectorQuickLinks(),
      RouteList.TalentListingScreen: (context) => TalentListingScreen(),
      RouteList.TalentListingFilter: (context) => TalentListingFilter(),
      RouteList.JobListingApplicantsMessege: (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return JobListingApplicantsMessege(
          jobId: args['jobId'],
          applicantId: args['applicantId'],
          userId: args['userId'],
          profilePic: args['profilePic'] ?? "",
          applicant: args['applicant'],
        );
      },

      RouteList.AppliedJobScreen: (context) {
        return AppliedJobScreen();
      },
      RouteList.EnquiriesScreen: (context) {
        return EnquiriesScreen();
      },

      RouteList.JobListingApplicantscreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return JobListingApplicantsScreen(
          jobsListingData: args as Jobs,
        );
      },
      RouteList.MyJobProfileScreen: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as JobProfile;
        return MyJobProfileScreen(jobsListingData: args);
      },
      RouteList.adddirectorview: (context) => AddDirectorView(),
      RouteList.jobdetailsScreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return JobDetailsScreen(
          job: args as Jobs,
        );
      },

      RouteList.catalogueDetails: (context) => CatalogueDetailsScreen(),
      RouteList.talentdetailsScreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return TalentsDetailsView(
          talentList: args as JobProfile,
        );
      },
      RouteList.catalogueFilterScreen: (context) => CatalogueFilterScreen(),
      RouteList.addCatalogScreen: (context) => AddCatalogueScreen(),
      RouteList.myCatalogueFilter: (context) => MyCatalogueFilterWidget(),
      RouteList.myCatalogueScreen: (context) => MyCataloguesScreen(),
      RouteList.directory: (context) => DirectorScreen(),
      RouteList.directoryFilter: (context) => DirectoriesFilterScreen(),
      RouteList.directoryDetailsScreen: (context) => DirectorDetailsScreen(),
      RouteList.learningHubScreen: (context) => LearningHubScreen(),
      RouteList.newCourseScreen: (context) => NewCourseScreen(),
      RouteList.addCourse: (context) => AddCourse(),
      RouteList.courseInfo: (context) => CourseInfo(),
      RouteList.termsAndConditions: (context) => TermsAndConditions(),
      RouteList.contacts: (context) => Contacts(),
      RouteList.myLearningHubScreen: (context) => MyLearningHubScreen(),
      RouteList.myDirectorScreen: (context) => MyDirectorScreen(),
      RouteList.courseDetailScreen: (context) => CourseDetailScreen(),
      RouteList.professionDirectorScreen: (context) => ProfessionalDirectorScreen(),
      RouteList.professionAddDirectorView: (context) => ProfessionalAddDirectorView(),
      RouteList.bannersListView: (context) => ChangeNotifierProvider(
          create: (_) => BannersViewModel(), child: BannersListScreen()),
      RouteList.addBanners: (context) => AddBannersScreen(),
      RouteList.registeredUsersView: (context) => RegisteredUsersView(),
    };
  }
}