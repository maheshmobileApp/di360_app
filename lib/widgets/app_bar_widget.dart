import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget
    with BaseContextHelpers
    implements PreferredSizeWidget {
  final Widget? filterWidget;
  final String? title;
  final bool searchWidget;
  final Function()? searchAction;
  const AppBarWidget(
      {super.key,
      this.filterWidget,
      this.title,
      this.searchAction,
      this.searchWidget = true});

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    return AppBar(
      elevation: 3,
      shadowColor: AppColors.black.withOpacity(0.2),

      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      title: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(title ?? 'Dental Interface',
              style: TextStyles.bold4(color: AppColors.black)),
          Positioned(
              top: -9,
              right: -18,
              child: SvgPicture.asset(ImageConst.logo, height: 20, width: 20)),
        ],
      ),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(ImageConst.notification,
                      color: AppColors.black),
                  if (notificationVM.notificationCount != 0)
                    Positioned(
                        top: -16,
                        right: -13,
                        child: CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.primaryColor,
                            child: Text('${notificationVM.notificationCount}',
                                textAlign: TextAlign.center,
                                style: TextStyles.regular1(
                                    fontSize: 8, color: AppColors.whiteColor))))
                ],
              )),
        ),
        addHorizontal(15),
        (searchWidget)
            ? GestureDetector(
                onTap: searchAction,
                child:
                    SvgPicture.asset(ImageConst.search, color: AppColors.black))
            : SizedBox.shrink(),
        addHorizontal(15),
        if (filterWidget != null) filterWidget!,
        addHorizontal(15)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
