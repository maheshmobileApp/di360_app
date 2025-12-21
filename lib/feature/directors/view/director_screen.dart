import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view/grid_view_widget.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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

  fetchDirectorData() {
    final directorVM = context.read<DirectoryViewModel>();
    directorVM.getDirectorsList(context);
    directorVM.clearFilter();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      fetchDirectorData();
        
    });
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
    final directorVM = Provider.of<DirectoryViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      endDrawer: NotificationsPanel(),
      appBar: AppBarWidget(
          searchWidget: false,
          filterWidget: Row(children: [
            GestureDetector(
                onTap: () =>
                    navigationService.navigateTo(RouteList.directoryFilter),
                child: SvgPicture.asset(ImageConst.filter,
                    color: AppColors.black)),
            if (directorVM.removeIcon == true)
              GestureDetector(
                onTap: () => directorVM.clearFilter(),
                child: Icon(Icons.close, color: AppColors.black),
              )
          ])),
      body: Column(
        children: [
          ListBanner(),
          /*  Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                    Image.asset(ImageConst.catalogueBg, fit: BoxFit.cover)),
            Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                    radius: 20,
                    child: InkWell(
                        onTap: () => navigationService.goBack(),
                        child:
                            Icon(Icons.arrow_back, color: AppColors.black))))
          ]),
          addVertical(16),
          Selector<DirectoryViewModel, bool>(
            selector: (_, vm) => vm.removeIcon,
            builder: (context, removeIcon, _) {
              final directorVM = context.read<DirectoryViewModel>();
              return SearchBarWidget(
                controller: directorVM.searchController,
                onFieldSubmitted: (value) async {
                  await directorVM.getDirectorsList(context);
                  directorVM.updateTheRemoveIcon(true);
                },
                filterIconAction: () =>
                    navigationService.navigateTo(RouteList.directoryFilter),
                closeIconVal: removeIcon,
                closeIconAction: () => directorVM.clearFilter(),
              );
            },
          ),*/
          addVertical(16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.whiteColor),
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
                        child: GridViewWidget(controller: _scrollController),
                      ),
                    ],
                  )),
            ),
          )
        ],
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
