import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GridViewWidget extends StatelessWidget with BaseContextHelpers {
  final ScrollController? controller;
  const GridViewWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final userId = LocalStorage.getStringVal(LocalStorageConst.userId);
    return Consumer<DirectoryViewModel>(builder: (context, value, child) {
      return SingleChildScrollView(
        controller: controller,
        child: value.directorsList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConst.NoDirectory),
                    addVertical(10),
                    Text(
                      "No Directories",
                      style: TextStyles.medium2(color: AppColors.black),
                    ),
                  ],
                ),
              )
            : Column(
                children: value.interleavedList.map((item) {
                if (item is List<Directories>) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: List.generate(2, (i) {
                        if (i < item.length) {
                          final director = item[i];
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                      color: AppColors.buttomBarColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () async {
                                  print(director.id);
                                  await value.GetDirectorDetails(
                                      director.id ?? '');
                                  final userIdString = await userId;
                                  value.getCommunityStatus(
                                      userIdString ?? "", director.id ?? "");
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImageWidget(
                                        imageUrl: director.logo?.url ??
                                            director.profileImage?.url ??
                                            '',
                                        height: 170,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        height: 1,
                                        color: AppColors.dividerColor),
                                    addVertical(6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Text(
                                              director.name ??
                                                  director.companyName ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyles.medium2(
                                                  color: AppColors.black)),
                                        ),
                                        ShareWidget()
                                      ],
                                    ),
                                    addVertical(6)
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Expanded(child: SizedBox());
                        }
                      }),
                    ),
                  );
                } else if (item is Banners) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImageWidget(
                        imageUrl: item.image?.first.url ?? '',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 170,
                      ),
                    ),
                  );
                }

                return SizedBox.shrink();
              }).toList()),
      );
    });
  }
}
