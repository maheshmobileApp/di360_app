import 'package:app_links/app_links.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
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
  static bool get hasPendingLink => _pendingUri != null;
  static bool _isProcessing = false;

  static Future<void> init() async {
    print("DeepLinkService.init() calling");
    final uri = await _appLinks.getInitialAppLink();
    if (uri != null) {
      _pendingUri = uri;
      print('DeepLinkService.init(): initial app link found: $uri');
    } else {
      print('DeepLinkService.init(): no initial app link');
    }
    _appLinks.uriLinkStream.listen((uri) {
      print('DeepLinkService: received uriLinkStream event: $uri');
      final context = navigatorKey.currentContext;
      if (context != null) {
        _handleUri(uri, context);
      } else {
        print(
            'DeepLinkService: uriLinkStream event received with no navigator context');
      }
    });
  }

  static Future<void> consumePendingLink() async {
    print("consumePendingLink Calling");
    if (_pendingUri == null || _isProcessing) return;

    _isProcessing = true;

    try {
      final uri = _pendingUri!;
      _pendingUri = null;

      final context = navigatorKey.currentContext;

      if (context != null) {
        await _handleUri(uri, context);
      }
    } finally {
      _isProcessing = false;
    }
  }

  static Future<void> _handleUri(Uri uri, BuildContext context) async {
    final segments = uri.pathSegments;
    final type = segments.length >= 2 ? segments[segments.length - 2] : '';
    final id = segments.isNotEmpty ? segments.last : '';
    await _handleNavigation(type, id, context);
  }

  static Future<void> _handleNavigation(
      String type, String id, BuildContext context) async {
    final urlType = FeedType.values.cast<FeedType?>().firstWhere(
          (e) => e?.name == type,
          orElse: () => null,
        );
    if (urlType == null) return;
    print(
        '********************DeepLinkService: Navigating to $urlType with ID $id');

    switch (urlType) {
      case FeedType.jobs:
        await Provider.of<NewsFeedViewModel>(context, listen: false)
            .getJobDetailsByIds(context, id);
        break;
      case FeedType.newsfeed:
        await Provider.of<NotificationViewModel>(context, listen: false)
            .getNewsFeedData(context, id);
        break;
      case FeedType.learnhub:
        final courseListingVM = Provider.of<MarketPlaceLearningHubViewModel>(
            context,
            listen: false);
        await courseListingVM.getCourseDetails(
          context,
          id,
        );
        if (courseListingVM.courseDetails != null) {
          navigationService.navigateTo(RouteList.courseDetailScreen);
        } else {
          scaffoldMessenger('This course details not found');
        }
        break;
      case FeedType.talents:
        final talentEnqVM =
            Provider.of<TalentEnquiryViewModel>(context, listen: false);
        await talentEnqVM.getTalentEnqPreviewData(context, id);
        if (talentEnqVM.talentEnqPreviewData.isNotEmpty) {
          navigationService.navigateToWithParams(
            RouteList.talentPreview,
            params: talentEnqVM.talentEnqPreviewData.first,
          );
        } else {
          scaffoldMessenger('This talent post has been deleted.');
        }
        break;
      case FeedType.catalogue:
        final catalogueVM = Provider.of<CatalogueViewModel>(
          context,
          listen: false,
        );
        await catalogueVM.getCatalogDetails(context, id);
        final catId = catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
        await catalogueVM.getReletedCatalog(context, catId);
        if (catalogueVM.cataloguesByIdData != null) {
          navigationService.navigateTo(RouteList.catalogueDetails);
        } else {
          scaffoldMessenger('This catalogue is not available.');
        }
        break;
      case FeedType.course:
        final courseVM = Provider.of<MarketPlaceLearningHubViewModel>(
          context,
          listen: false,
        );
        await courseVM.getCourseDetails(context, id);
        if (courseVM.courseDetails != null) {
          navigationService.navigateTo(RouteList.courseDetailScreen);
        } else {
          scaffoldMessenger('This course is not available.');
        }
        break;
      case FeedType.joinCommunity:
      case FeedType.profile:
      case FeedType.directory:
        final directoryVM =
            Provider.of<DirectoryViewModel>(context, listen: false);
        await directoryVM.GetDirectorDetails(id);
        if (directoryVM.directorDetails != null) {
          navigationService.navigateTo(RouteList.directoryDetailsScreen);
        } else {
          scaffoldMessenger('This directory is not available.');
        }
        break;
      case FeedType.banners:
      case FeedType.campaign:
        break;
    }
  }
}
