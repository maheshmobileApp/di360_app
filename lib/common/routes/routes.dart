import 'package:di360_flutter/feature/account/view/account_view_screen.dart';
import 'package:di360_flutter/feature/add_catalogues/view/add_catalogue_screen.dart';
import 'package:di360_flutter/feature/add_catalogues/view/my_catalogue_filter_widget.dart';
import 'package:di360_flutter/feature/add_catalogues/view/my_catalogues_screen.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_news_feed/view/add_news_feed_screen.dart';
import 'package:di360_flutter/feature/applied_job.dart/view/applied_job_screen.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_details_screen.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_filter_screen.dart';
import 'package:di360_flutter/feature/dash_board/dash_board.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_details_screen.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_quicklincks.dart';
import 'package:di360_flutter/feature/directors/view/director_screen.dart';
import 'package:di360_flutter/feature/directors/view/directories_filter_screen.dart';
import 'package:di360_flutter/feature/enquiries/view/enquiries_screen.dart';
import 'package:di360_flutter/feature/job_create/view/job_create_view.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_messege.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_screen.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_details.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_screen.dart';
import 'package:di360_flutter/feature/job_profile/view/job_profile_view.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/view/apply_job_view.dart';
import 'package:di360_flutter/feature/job_seek/view/job_details.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_filter.dart';
import 'package:di360_flutter/feature/login/login_screen.dart';
import 'package:di360_flutter/feature/pre_login/pre_login_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/plan_details_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/practice_details_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/role_selection_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/signup_screen.dart';
import 'package:di360_flutter/feature/splash/splash_screen.dart';
import 'package:di360_flutter/feature/talent_listing/view/talent_listing_filter.dart';
import 'package:di360_flutter/feature/talent_listing/view/talent_listing_screen.dart';
import 'package:di360_flutter/feature/talents/model/talents_model.dart';
import 'package:di360_flutter/feature/talents/views/talents_details_view.dart';

import 'route_list.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      RouteList.splash: (context) => SplashScreen(),
      RouteList.preLogin: (context) => PreLoginScreen(),
      RouteList.login: (context) => LoginScreen(),
      RouteList.dashBoard: (context) => DashBoard(),
      RouteList.addNewsFeed: (context) => AddNewsFeedScreen(),
      RouteList.subscribePlan: (context) => SubscriptionPlanScreen(),
      RouteList.signup: (context) => SignupScreen(),
      RouteList.roleScreen: (context) => RoleSelectionScreen(),
      RouteList.practiceDetailsScreen: (context) => PracticeDetailsScreen(),
      RouteList.jobCreate: (context) => JobCreateView(),
      RouteList.JobSeekFilterScreen: (context) => JobSeekFilterScreen(),
      RouteList.applyJob: (context) => ApplyJobsView(),
      RouteList.account: (context) => AccountScreen(),
      RouteList.JobProfileView: (context) => JobProfileView(),
      RouteList.JobListingScreen: (context) => JobListingScreen(),
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
        );
      },
      
      RouteList.AppliedJobScreen: (context) {
        final dentalProfessionalId =
            ModalRoute.of(context)!.settings.arguments as String? ??
                "1d0f1ca1-2658-4869-85d0-6f098bc600a1";
        return AppliedJobScreen(dentalProfessionalId: dentalProfessionalId);
      },
      RouteList. EnquiriesScreen: (context) {
        final dentalProfessionalId =
            ModalRoute.of(context)!.settings.arguments as String? ??
                "1d0f1ca1-2658-4869-85d0-6f098bc600a1";
        return  EnquiriesScreen(dentalProfessionalId: dentalProfessionalId);
      },

      RouteList.JobListingApplicantscreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return JobListingApplicantsScreen(
          jobsListingData: args as JobsListingDetails,
        );
      },
      // RouteList.JobListingApplicantscreen: (context) => JobListingApplicantsScreen(),
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
      RouteList.JobListingDetailsScreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return JobListingDetailsScreen(
          job: args as JobsListingDetails,
          
        );
      },
     
      

      RouteList.directoryDetailsScreen: (context) => DirectorDetailsScreen(),
    };
  }
}
