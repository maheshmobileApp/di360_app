import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/login/login_screen.dart';
import 'package:di360_flutter/feature/pre_login/signin_button.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PreLoginScreen extends StatelessWidget with BaseContextHelpers {
  const PreLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          addVertical(19),
          Stack(clipBehavior: Clip.none, children: [
            Text('Dental Interface',
                style: TextStyles.clashSemiBold(color: AppColors.black)),
            Positioned(
                right: -25, top: -16, child: SvgPicture.asset(ImageConst.logo))
          ]),
          addVertical(20),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      ImageConst.pre_login,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  right: 30,
                  bottom: getSize(context).height * 0.04,
                  child: Column(
                    children: [
                      /*SigninButton(
                        text: 'Sign in with Google',
                        img: ImageConst.googleSvg,
                        onTap: () {
                          signInWithGoogle();
                        },
                      ),*/
                      addVertical(23),
                      SigninButton(
                        text: 'Sign in with Email',
                        img: ImageConst.emailSvg,
                        onTap: () {
                          navigationService.navigateTo(RouteList.login);
                        },
                      ),
                      addVertical(20),
                      richText(
                        color1: AppColors.hintColor,
                        color2: AppColors.hintColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print('googleUser: ${googleAuth}');

    // final credential = FirebaseAuth.GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    // final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    // return userCredential.user;
  }
}
