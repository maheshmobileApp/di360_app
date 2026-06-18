import 'dart:async';

import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/services/deep_link_service.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with BaseContextHelpers {
  bool _isNavigating = false;
  Timer? _startupTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SvgPicture.asset(ImageConst.logo, height: 200, width: 200)));
  }

  @override
  void initState() {
    super.initState();
    _startupTimer = Timer(const Duration(seconds: 3), _bootstrap);
  }

  @override
  void dispose() {
    _startupTimer?.cancel();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    if (!mounted) {
      return;
    }

    await _continueNavigation();
  }

  Future<void> _continueNavigation() async {
    if (_isNavigating) {
      return;
    }
    _isNavigating = true;

    final userLogin = await LocalStorage.getBoolValue(LocalStorageConst.isAuth);
    final profileCompleted =
        await LocalStorage.getBoolValue(LocalStorageConst.profileCompleted);

    if (!mounted) {
      return;
    }

    if (userLogin == true) {
      if (profileCompleted == true) {
        print('SplashScreen: routing to dashboard');
        navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);

        if (DeepLinkService.hasPendingLink) {
          await DeepLinkService.consumePendingLink();
        }
        return;
      }

      await viewProfileHandle(context);
      if (DeepLinkService.hasPendingLink) {
        await DeepLinkService.consumePendingLink();
      }
      return;
    }

    navigationService.pushNamedAndRemoveUntil(RouteList.preLogin);
  }

  viewProfileHandle(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    await context.read<ViewProfileViewModel>().getBusinessTypes();
    await context.read<ViewProfileViewModel>().getTheViewProfileData();
    Loaders.circularHideLoader(context);
    type == UserRole.professional.value
        ? await navigationService
            .navigateTo(RouteList.professionalViewProfileScreen)
        : type == UserRole.admin.value
            ? navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard)
            : await navigationService.navigateTo(RouteList.viewProfileScreen);
  }

  directorNavigationHandle(BuildContext context) async {
    final directorComplete =
        await LocalStorage.getBoolValue(LocalStorageConst.directoryComplete);
    directorComplete == false
        ? await context
            .read<AddDirectoryViewModel>()
            .fetchTheDirectorData(context)
        : navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);
  }
}
