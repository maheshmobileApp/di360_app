import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SvgPicture.asset(ImageConst.logo, height: 200, width: 200)));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      final userLogin =
          await LocalStorage.getBoolValue(LocalStorageConst.isAuth);
      final profileCompleted =
          await LocalStorage.getBoolValue(LocalStorageConst.profileCompleted);
      userLogin == true
          ? profileCompleted == true
              ? navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard)
              : viewProfileHandle(context)
          : navigationService.pushNamedAndRemoveUntil(RouteList.preLogin);
    });
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
        : await navigationService.navigateTo(RouteList.viewProfileScreen);
  }
}
