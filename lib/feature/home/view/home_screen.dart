import 'package:di360_flutter/feature/home/view/grid_widget.dart';
import 'package:di360_flutter/feature/home/view/user_data.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        searchWidget: false,
      ),
      body: Column(
        children: [UserData(), Expanded(child: GridWidget())],
      ),
    );
  }

  @override
  void initState() {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.getFollowersCount(context);
    context.read<NotificationViewModel>().getNotificationsCount();
    super.initState();
  }
}
