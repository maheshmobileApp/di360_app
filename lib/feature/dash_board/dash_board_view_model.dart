import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/account/view/account_view_screen.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_screen.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/clients/view/clients_screen.dart';
import 'package:di360_flutter/feature/community/view/community_market_view.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/home/view/home_screen.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_view.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_screen.dart';
import 'package:di360_flutter/feature/news_feed_community/view/news_feed_community_view.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/feature/splash/model/app_config_model.dart';
import 'package:di360_flutter/feature/splash/repository/app_config_repo_impl.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/services/banner_services.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  // int? _pendingIndex;
  List<Widget> _pages = [];
  String _userType = '';
  bool _isInitialized = false;

  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;
  bool get isInitialized => _isInitialized;
  String get userType => _userType;

  DashBoardViewModel() {
    _initializePages();
    BannerServices.instance.fetchListViewBanners({});
  }

  Future<void> _initializePages() async {
    _userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    await LocalStorage.setBoolValue(
        LocalStorageConst.firstNavigationDirectory, false);
    //_setupPages();
    // if (_pendingIndex != null && _pendingIndex! < _pages.length) {
    //   _currentIndex = _pendingIndex!;
    //   _pendingIndex = null;
    // }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> getUserType() async {
    _userType = await LocalStorage.getStringVal(LocalStorageConst.type);
    _updatePages();
    notifyListeners();
  }

  void _updatePages() {
    if (_userType == UserRole.supplier.value) {
      _pages = [
        HomeScreen(),
        NewsFeedScreen(),
        JobSeekView(),
        NewsFeedCommunityView(),
        CataloguePage(),
        AccountScreen(),
      ];
    } else if (_userType == UserRole.practice.value) {
      _pages = [
        HomeScreen(),
        NewsFeedScreen(),
        JobSeekView(),
        CataloguePage(),
        AccountScreen(),
      ];
    } else if (_userType == UserRole.admin.value) {
      _pages = [
        HomeScreen(),
        NewsFeedScreen(),
        JobSeekView(),
        NewsFeedCommunityView(),
        CataloguePage(),
        ClientsScreen(),
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
  }

  void setIndex(int index, BuildContext context) {
    if (index < 0 || index >= _pages.length) return;
    _currentIndex = index;
    updateIndex(index, context);
    notifyListeners();
  }

  updateIndex(int index, BuildContext context) async {
    if (_userType == UserRole.supplier.value) {
      switch (index) {
        case 0: // Home
          break;
        case 1: // News Feed
          context.read<NewsFeedViewModel>().getAllNewsfeeds(context);
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
          context.read<NewsFeedCommunityViewModel>().getBannerUrl(context);
          context.read<NewsFeedCommunityViewModel>().initialStateData();

          break;
        case 4: // Catalogue
          context
              .read<CatalogueViewModel>()
              .fetchCatalogue(context, isCommunityCatalogue: false);
          break;
        case 5: // Account
          break;
      }
    } else if (_userType == UserRole.practice.value) {
      switch (index) {
        case 0: // Home
          break;
        case 1: // News Feed
          context.read<NewsFeedViewModel>().getAllNewsfeeds(context);
          context.read<NewsFeedViewModel>().updateApplyCatageories(false);
          break;
        case 2: // Job Seek
          context.read<JobSeekViewModel>().fetchJobs(context);
          break;
        case 3: // Catalogue
          context
              .read<CatalogueViewModel>()
              .fetchCatalogue(context, isCommunityCatalogue: false);
          break;
        case 4: // Account
          break;
      }
    } else {
      switch (index) {
        case 0: // Home
          break;
        case 1: // News Feed
          context.read<NewsFeedViewModel>().getAllNewsfeeds(context);
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
          context
              .read<CatalogueViewModel>()
              .fetchCatalogue(context, isCommunityCatalogue: false);
          break;
        case 5: // Account
          break;
      }
    }
    notifyListeners();
  }

  Future<void> checkForUpdate(BuildContext context) async {
    try {
      final appConfigRepo = AppConfigRepoImpl();
      final platform =
          defaultTargetPlatform == TargetPlatform.iOS ? 'iOS' : 'android';

      final appConfig = await appConfigRepo.getAppConfig(platform);
      if (appConfig == null) {
        return;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version.trim();
      final targetVersion = appConfig.latestVersion.trim();

      if (currentVersion != targetVersion && appConfig.forceUpdate) {
        _showUpdateDialog(appConfig, context);
      }
    } catch (_) {
      // Silently ignore update check errors
    }
  }

  void _showUpdateDialog(AppConfigModel appConfig, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Needed'),
          content: Text(appConfig.message.isNotEmpty
              ? appConfig.message
              : 'A new version of the app is available.'),
          actions: [
            TextButton(
              onPressed: () async {
                await _openStore(appConfig.storeUrl);
              },
              child: const Text('Update Now'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openStore(String storeUrl) async {
    final uri = Uri.tryParse(storeUrl);
    if (uri == null) return;

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future logOutAlert(BuildContext context) {
  final addDirectoryVM =
      Provider.of<AddDirectoryViewModel>(context, listen: false);
  final viewProfileVM =
      Provider.of<ViewProfileViewModel>(context, listen: false);
  final professionalAddDirVM =
      Provider.of<ProfessionalAddDirectorVm>(context, listen: false);
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
                  await Loaders.circularShowLoader(context);
                  await deleteToken();
                  await LocalStorage.clearAllData();
                  addDirectoryVM.clearAllDirectorData();
                  viewProfileVM.clearProfileData();
                  professionalAddDirVM.clearProfessionalDirectorData();
                  await Loaders.circularHideLoader(context);
                  navigationService.pushNamedAndRemoveUntil(RouteList.login);
                },
                child: const Text('Ok')),
          ],
        );
      });
}

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? '';
  }

  return '';
}

Future<void> deleteToken() async {
  final HttpService _http = HttpService();
  final type = await LocalStorage.getStringVal(LocalStorageConst.type);
  final deviceId = await getDeviceId();

  if (deviceId == "") {
    print("Device token is null or empty, skipping token deletion");
    return;
  }

  final variables = {"device_id": deviceId, "type": type};
  print("variables: $variables");
  final res = await _http.post("/api/v1/auth/remove-devicetoken", variables);
  await LocalStorage.clearAllData();
  print("res: $res");
}
