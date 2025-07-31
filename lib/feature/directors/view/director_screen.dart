import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';
import 'package:di360_flutter/feature/directors/view/search_bar_widget.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DirectorScreen extends StatefulWidget {
  const DirectorScreen({super.key});

  @override
  State<DirectorScreen> createState() => _DirectorScreenState();
}

class _DirectorScreenState extends State<DirectorScreen>
    with BaseContextHelpers {
  final ScrollController _scrollController = ScrollController();

  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 700) {
        if (!_showScrollToTop) {
          setState(() => _showScrollToTop = true);
        }
      } else {
        if (_showScrollToTop) {
          setState(() => _showScrollToTop = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final directorVM = context.read<DirectorViewModel>();
    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                ImageConst.catalogueBg,
                fit: BoxFit.cover,
              ),
            ),
            addVertical(16),
            SearchBarWidget(
              controller: directorVM.searchController,
              onFieldSubmitted: (value) async {
                await directorVM.getDirectorsList(context);
              },
              filterIconAction: () =>
                  navigationService.navigateTo(RouteList.directoryFilter),
            ),
            addVertical(16),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Text(
                          'ALL DIRECTORY',
                          style: TextStyles.bold2(color: AppColors.black),
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: Consumer<DirectorViewModel>(
                            builder: (context, value, child) {
                          return SingleChildScrollView(
                            controller: _scrollController,
                            child: value.directorsList.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            ImageConst.NoDirectory),
                                        addVertical(10),
                                        Text(
                                          "No Directories",
                                          style: TextStyles.medium2(
                                              color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children:
                                        directorVM.interleavedList.map((item) {
                                    if (item is List<Directories>) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: GestureDetector(
                                          onTap: () => navigationService
                                              .navigateTo(RouteList
                                                  .directoryDetailsScreen),
                                          child: Row(
                                            children: List.generate(2, (i) {
                                              if (i < item.length) {
                                                final director = item[i];
                                                return Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .buttomBarColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImageWidget(
                                                            imageUrl: director
                                                                    .logo
                                                                    ?.url ??
                                                                director
                                                                    .profileImage
                                                                    ?.url ??
                                                                '',
                                                            height: 170,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Container(
                                                            height: 1,
                                                            color: AppColors
                                                                .dividerColor),
                                                        addVertical(6),
                                                        Text(
                                                            director.name ?? '',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            style: TextStyles
                                                                .medium2(
                                                                    color: AppColors
                                                                        .black)),
                                                        addVertical(6)
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Expanded(
                                                    child: SizedBox());
                                              }
                                            }),
                                          ),
                                        ),
                                      );
                                    } else if (item is Banners) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImageWidget(
                                            imageUrl:
                                                item.image?.first.url ?? '',
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
                        }),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
    );
  }
}
