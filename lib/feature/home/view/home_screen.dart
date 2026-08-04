import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/dash_board/home_grid_data.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/home/view/grid_widget.dart';
import 'package:di360_flutter/feature/home/view/user_data.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/notifications/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String type = '';
  List<String> permissions = [];
  

  @override
  Widget build(BuildContext context) {
    final viewProfileVM = Provider.of<ViewProfileViewModel>(context);
    final directorVM = Provider.of<DirectoryViewModel>(context);
    final visibleItems = HomeGridData.items.where(
      (item) => permissions.contains(item.permission.value),
    ).toList();
    

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        searchWidget: true,
        searchAction: () {
          directorVM.setSearchBar(true);
          navigationService.navigateTo(RouteList.directory);
        },
      ),
      body: Column(
        children: [
          UserData(type: type, gender: viewProfileVM.gender),
          Expanded(child: SingleChildScrollView(child: GridWidget()))
        ],
      ),
    );
  }

  @override
  void initState() {
    
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.getFollowersCount(context);
    context.read<NotificationViewModel>().getNotificationsCount();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ViewProfileViewModel>().getTheViewProfileData();
      final t = await LocalStorage.getStringVal(LocalStorageConst.type);
      setState(() => type = t);
    });
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    permissions = await LocalStorage.getStringList(
      LocalStorageConst.permissions,
    );
    setState(() {});
  }
}
