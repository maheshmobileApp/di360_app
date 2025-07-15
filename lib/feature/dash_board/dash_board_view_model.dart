import 'package:di360_flutter/feature/account/view/account_view_screen.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_screen.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/view/home_screen.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_view.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/logout_view.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_screen.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final pages = [
    HomeScreen(),
    NewsFeedScreen(),
    JobSeekView(),
    CataloguePage(),
    AccountScreen(),
    //Center(child: Text('Profile Page')),
   LogoutView()
  ];

  void setIndex(int index, BuildContext context) {
    _currentIndex = index;
    updateIndex(index, context);
    notifyListeners();
  }

  updateIndex(int index, BuildContext context) async {
    switch (index) {
      case 0:
        break;
      case 1:
        context.read<HomeViewModel>().getAllNewsfeeds(context);
        context.read<NewsFeedViewModel>().updateApplyCatageories(false);
        break;
      case 2:
        context.read<JobSeekViewModel>().applyFilters();
        break;
      case 3:
      context.read<CatalogueViewModel>().fetchCatalogue(context);
        break;
         case 4:
        // Account screen – nothing to fetch here
        break;
      default:
    }
    notifyListeners();
  }
}

Future logOutAlert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Are you sure, do you want to Logout?',
              style: TextStyles.medium4(color: AppColors.black)),
          actions: [
            TextButton(
                onPressed: () {
                  navigationService.goBack();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  await LocalStorage.clearAllData();
                  navigationService.pushNamedAndRemoveUntil(RouteList.login);
                },
                child: const Text('Ok')),
          ],
        );
      });
}
