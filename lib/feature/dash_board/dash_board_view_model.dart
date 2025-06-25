import 'package:di360_flutter/feature/home/view/home_screen.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_view.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final pages = [
    HomeScreen(),
    NewsFeedScreen(),
    JobSeekView(),
    Center(child: Text('Cart Page')),
    Center(child: Text('Profile Page')),
    Center(child: Text('Cart Page')),

  ];

  void setIndex(int index, BuildContext context) {
    _currentIndex = index;
    updateIndex(index, context);
    notifyListeners();
  }

  updateIndex(int index, BuildContext context) async {
    switch (index) {
      case 0:
        break;
      case 1:
        context.read<HomeViewModel>().getAllNewsfeeds(context);
        break;
      case 2:
        context.read<JobSeekViewModel>().fetchJobs();
        break;
      case 3:
        break;
      default:
    }
    notifyListeners();
  }
}
