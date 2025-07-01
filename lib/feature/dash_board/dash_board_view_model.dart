import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/view/home_screen.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_view.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_screen.dart';
import 'package:di360_flutter/main.dart';
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
    Center(child: Text('Cart Page')),
    Center(child: Text('Profile Page')),
    Center(child: InkWell(
      onTap: () => logOutAlert(navigatorKey.currentContext!),
      child: Text('Logout')))
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
        break;
      case 2:
        context.read<JobSeekViewModel>().fetchJobs();
        break;
      case 3:
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
