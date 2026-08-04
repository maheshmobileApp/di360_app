import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/feature/dash_board/home_grid_model.dart';
import 'package:di360_flutter/utils/permissions_enum.dart';

class HomeGridData {
  static const List<HomeGridItem> items = [
    HomeGridItem(
      permission: ModulePermission.newsfeedMarketplace,
      title: 'News Feed',
      image: ImageConst.newsFeed,
    ),
    HomeGridItem(
      permission: ModulePermission.learningHubMarketplace,
      title: 'Learning Hub',
      image: ImageConst.learningHub,
    ),
    HomeGridItem(
      permission: ModulePermission.directoryMarketplace,
      title: 'Directory',
      image: ImageConst.directory,
    ),
    HomeGridItem(
      permission: ModulePermission.jobSeekMarketplace,
      title: 'Job Seek',
      image: ImageConst.jobSeek,
    ),
    HomeGridItem(
      permission: ModulePermission.catalogueMarketplace,
      title: 'Catalogue',
      image: ImageConst.catalogue,
    ),
     HomeGridItem(
      permission: ModulePermission.suppliesMarketplace,
      title: 'Supplies',
      image: ImageConst.supplies,
    ),
  ];
}