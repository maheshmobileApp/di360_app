import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/account_view_model/account_view_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(ProfileRepositoryImpl())..fetchProfileSections(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: _buildAppBar(),
        body: Consumer<ProfileViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(child: Text('Error: ${vm.error}'));
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 16),
                ...vm.sections
                    .map((section) => _buildSection(context, section))
                    .toList(),
                const SizedBox(height: 12),
                _buildLogoutTile(),
              ],
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 16),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Text(
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
    );
  }

  Widget _buildProfileHeader() {
  return Column(
    children: [
      const SizedBox(height: 20),
      CircleAvatar(
        radius: 42,
        backgroundColor: Colors.grey.shade200,
        child: SvgPicture.asset(
          ImageConst.accountProfile,
          width: 50,
          height: 50,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        "Profile Name",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      const Text(
        "Job Designation",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color.fromRGBO(116, 130, 148, 1),
        ),
      ),
      const SizedBox(height: 12),
      Container(
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
                Text("200", style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(width: 4),
                Text("Followers", style: TextStyle(color: Colors.orange)),
              ],
            ),
            Container(width: 1, height: 20, color: Color(0xFFE0E0E0)),
            Row(
              children: const [
                Text("150", style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(width: 4),
                Text("Following", style: TextStyle(color: Colors.orange)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}


  Widget _buildSection(BuildContext context, ProfileSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 247, 249, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              section.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Colors.black,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: List.generate(
                section.subTitle.length,
                (index) {
                  final item = section.subTitle[index];
                  final isLast = index == section.subTitle.length - 1;
                  return Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(
                          item.asset,
                          width: 22,
                          height: 22,
                          placeholderBuilder: (context) => const SizedBox(
                            width: 22,
                            height: 22,
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // TODO: Navigation
                        },
                      ),
                      if (!isLast)
                        const Divider(height: 1, color: Color(0xFFE0E0E0)),
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
        children: [
          SvgPicture.asset(
            ImageConst.logout,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          const Text(
            "Logout",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              color: Color(0xFF242424),
            ),
          ),
        ],
      ),
    );
  }
}
