import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view/grid_view_widget.dart';
import 'package:di360_flutter/feature/directors/view/search_bar_widget.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
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
              Selector<DirectorViewModel, bool>(
                selector: (_, vm) => vm.removeIcon,
                builder: (context, removeIcon, _) {
                  final directorVM = context.read<DirectorViewModel>();
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
                          child: GridViewWidget(controller: _scrollController),
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
      ),
    );
  }
}
