import 'package:di360_flutter/feature/add_news_feed/view/add_news_feed_screen.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_details_screen.dart';
import 'package:di360_flutter/feature/dash_board/dash_board.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/view/job_details.dart';
import 'package:di360_flutter/feature/login/login_screen.dart';
import 'package:di360_flutter/feature/pre_login/pre_login_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/plan_details_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/practice_details_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/role_selection_screen.dart';
import 'package:di360_flutter/feature/sign_up/views/signup_screen.dart';
import 'package:di360_flutter/feature/splash/splash_screen.dart';
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
      RouteList.jobdetailsScreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return JobDetailsScreen(
          job: args as Jobs, // Replace JobModel with your actual job model type
        );
      },
      RouteList.catalogueDetails: (context) => CatalogueDetailsScreen(),
       RouteList.talentdetailsScreen: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        return TalentsDetailsView(
          talentList: args as JobProfile,
        );
      },

      //RouteList.commentScreen: (context) => CommentScreen()
      };
  }
}
