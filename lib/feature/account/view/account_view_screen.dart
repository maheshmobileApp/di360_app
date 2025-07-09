import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/account_view_model/account_view_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repo_impl.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AccountViewModel(AccountRepoImpl())..loadAccountData(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white, 
          elevation: 0,
          titleSpacing: 0,
          title: Row(
            children: [
              const SizedBox(width: 16),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    'Dental Interface',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600, 
                      fontSize: 16, 
                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: -20,
                    child: SvgPicture.asset(
                      ImageConst.logo,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: const [
            Icon(Icons.notifications_none, color: Colors.black),
            SizedBox(width: 10),
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 10),
          ],
        ),
        body: Consumer<AccountViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 16),
                ...vm.sections
                    .map((section) => _buildSection(context, section, vm)),
                const SizedBox(height: 12),
                _buildLogoutTile(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 42,
          backgroundImage: AssetImage('assets/profile_placeholder.png'),
        ),
        const SizedBox(height: 8),
        const Text(
          "Profile Name",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 15,
            height: 1.0,
            letterSpacing: 0,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        const Text(
          "Job Designation",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            height: 1.0,
            letterSpacing: 0,
            color: Color.fromRGBO(116, 130, 148, 1),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          //width: 345,
          //height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 241, 229, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    "200",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Followers",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0.2,
                      color: Color.fromRGBO(255, 112, 0, 1),
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 20,
                color: const Color(0xFFE0E0E0),
              ),
              Row(
                children: const [
                  Text(
                    "150",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Following",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0.2,
                      color: Color.fromRGBO(255, 112, 0, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, AccountSection section, AccountViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 247, 249, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              section.title ?? '',
              style: const TextStyle(
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: 0,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: List.generate(
                section.subTitle?.length ?? 0,
                (index) {
                  final isLast = index == (section.subTitle!.length - 1);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            section.subTitle![index],
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      if (!isLast)
                        const Divider(
                          height: 1,
                          color: Color(0xFFE0E0E0),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutTile() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.logout,
            color: Colors.orange,
            size: 20,
          ),
          SizedBox(width: 10),
          Text(
            "Logout",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: Color(0xFF242424),
            ),
          ),
        ],
      ),
    );
  }
}
