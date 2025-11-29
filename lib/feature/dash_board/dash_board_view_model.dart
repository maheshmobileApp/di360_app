import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/feature/account/view/account_view_screen.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_screen.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/view/community_market_view.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/home/view/home_screen.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_view.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_screen.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/services/banner_services.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  String _userType = '';

  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;

  DashBoardViewModel() {
    _initializePages();
    BannerServices.instance.fetchListViewBanners({});
  }

  void _initializePages() async {
    _userType = await LocalStorage.getStringVal(LocalStorageConst.type);

    if (_userType == "SUPPLIER") {
      _pages = [
        HomeScreen(),
        NewsFeedScreen(),
        JobSeekView(),
        CataloguePage(),
        AccountScreen(),
      ];
    } else {
      _pages = [
        HomeScreen(),
        NewsFeedScreen(),
        JobSeekView(),
        CommunityMarketView(),
        CataloguePage(),
        AccountScreen(),
      ];
    }
    notifyListeners();
  }

  void setIndex(int index, BuildContext context) {
    _currentIndex = index;
    updateIndex(index, context);
    notifyListeners();
  }

  updateIndex(int index, BuildContext context) async {
    if (_userType == "SUPPLIER") {
      switch (index) {
        case 0: // Home
          break;
        case 1: // Job Seek
          context.read<HomeViewModel>().getAllNewsfeeds(context);
          context.read<NewsFeedViewModel>().updateApplyCatageories(false);

          break;
        case 2: // Catalogue
          context.read<JobSeekViewModel>().fetchJobs(context);
          break;
        case 3:
          context.read<CatalogueViewModel>().fetchCatalogue(context);
          break;
        case 4:
          break;
      }
    } else {
      switch (index) {
        case 0: // Home
          break;
        case 1: // News Feed
          context.read<HomeViewModel>().getAllNewsfeeds(context);
          context.read<NewsFeedViewModel>().updateApplyCatageories(false);
          break;
        case 2: // Job Seek
          context.read<JobSeekViewModel>().fetchJobs(context);
          break;
        case 3: // Community
          context
              .read<CommunityViewModel>()
              .getJoinedCommunityMembersRes(context);
          context.read<CommunityViewModel>().changeProfessionalMode(true);
          break;
        case 4: // Catalogue
          context.read<CatalogueViewModel>().fetchCatalogue(context);
          break;
        case 5: // Account
          break;
      }
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
