import 'package:app_links/app_links.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/feature/notifications/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/talent_enquiries/view_model/talent_enquiry_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeepLinkService {
  static final _appLinks = AppLinks();
  static Uri? _pendingUri;

  static void init() async {
    final uri = await _appLinks.getInitialAppLink();
    if (uri != null) _pendingUri = uri;
    _appLinks.uriLinkStream.listen((uri) {
      final context = navigatorKey.currentContext;
      if (context != null) _handleUri(uri, context);
    });
  }

  static void consumePendingLink() {
    if (_pendingUri == null) return;
    final uri = _pendingUri ?? Uri();
    _pendingUri = null;
    Future.delayed(const Duration(milliseconds: 500), () {
      final context = navigatorKey.currentContext;
      if (context != null) _handleUri(uri, context);
    });
  }

  static void _handleUri(Uri uri, BuildContext context) {
    final segments = uri.pathSegments;
    final type = segments.length >= 2 ? segments[segments.length - 2] : '';
    final id = segments.isNotEmpty ? segments.last : '';
    _handleNavigation(type, id, context);
  }

  static void _handleNavigation(String type, String id, BuildContext context) {
    //final navigator = navigatorKey.currentState;
    final urlType = FeedType.values.cast<FeedType?>().firstWhere(
          (e) => e?.name == type,
          orElse: () => null,
        );
    if (urlType == null) return;
    print(
        '********************DeepLinkService: Navigating to $urlType with ID $id');

    switch (urlType) {
      case FeedType.jobs:
        Provider.of<NewsFeedViewModel>(context, listen: false)
            .getJobDetailsByIds(context, id);
        break;
      case FeedType.newsfeed:
        Provider.of<NotificationViewModel>(context, listen: false)
            .getNewsFeedData(context, id);
        break;

      case FeedType.learnhub:
        () async {
          final courseListingVM =
              Provider.of<CourseListingViewModel>(context, listen: false);
          await courseListingVM.getCourseDetails(
            context,
            id,
          );
          if (courseListingVM.courseDetails.isNotEmpty) {
            navigationService.navigateTo(RouteList.courseDetailScreen);
          } else {
            scaffoldMessenger('This course details not found');
          }
        }();
        break;

      case FeedType.talents:
        () async {
          final talentEnqVM =
              Provider.of<TalentEnquiryViewModel>(context, listen: false);
          await talentEnqVM.getTalentEnqPreviewData(context, id);
          if (talentEnqVM.talentEnqPreviewData.isNotEmpty) {
            navigationService.navigateToWithParams(RouteList.talentPreview,
                params: talentEnqVM.talentEnqPreviewData.first);
          } else {
            scaffoldMessenger('This talent post has been deleted.');
          }
        }();
        break;
      case FeedType.catalogue:
        () async {
          final catalogueVM =
              Provider.of<CatalogueViewModel>(context, listen: false);
          await catalogueVM.getCatalogDetails(context, id);
          final catId =
              catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
          await catalogueVM.getReletedCatalog(context, catId);
          if (catalogueVM.cataloguesByIdData != null) {
            navigationService.navigateTo(RouteList.catalogueDetails);
          } else {
            scaffoldMessenger('This catalogue is not available.');
          }
        }();

        break;
      case FeedType.course:
        () async {
          final courseVM =
              Provider.of<CourseListingViewModel>(context, listen: false);
          await courseVM.getCourseDetails(context, id);
          if (courseVM.courseDetails.isNotEmpty) {
            navigationService.navigateTo(RouteList.courseDetailScreen);
          } else {
            scaffoldMessenger('This course is not available.');
          }
        }();
        break;
      case FeedType.joinCommunity:
      case FeedType.profile:
      case FeedType.directory:
        () async {
          final directoryVM =
              Provider.of<DirectoryViewModel>(context, listen: false);
          await directoryVM.GetDirectorDetails(id);
          if (directoryVM.directorDetails != null) {
            navigationService.navigateTo(RouteList.directoryDetailsScreen);
          } else {
            scaffoldMessenger('This directory is not available.');
          }
        }();
        break;
      case FeedType.banners:
      case FeedType.campaign:
        break;
    }
  }
}
