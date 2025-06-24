import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        child: SvgPicture.asset(
          ImageConst.logo,
          height: 200,
          width: 200
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed( Duration(seconds: 3), () async {
      final userLogin =
          await LocalStorage.getBoolValue(LocalStorageConst.isAuth);
      userLogin == true
          ? navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard)
          : navigationService.pushNamedAndRemoveUntil(RouteList.preLogin);
    });
  }
}
