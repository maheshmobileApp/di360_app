import 'dart:convert';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedDetails extends StatelessWidget with BaseContextHelpers {
  final Newsfeeds? newsfeeds;
  const FeedDetails({super.key, required this.newsfeeds});

  @override
  Widget build(BuildContext context) {
    final needFeedViewModel = Provider.of<NewsFeedViewModel>(context);
    final catalogueViewModel = Provider.of<CatalogueViewModel>(context);
    return Container(
      color: AppColors.whiteColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        addVertical(10),
        _buildImageRow(),
        addVertical(10),
        (newsfeeds?.videoUrl == '' || newsfeeds?.videoUrl == null)
            ? SizedBox.shrink()
            : _mediaCard(
                child: LazyYoutubePlayer(youtubeUrl: newsfeeds?.videoUrl ?? ''),
                isFullWidth: true),
        addVertical(22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (newsfeeds?.description == null || newsfeeds?.description == '')
                    ? newsfeeds?.title ?? ''
                    : newsfeeds?.description ?? '',
                style: TextStyles.regular2(color: AppColors.black),
              ),
              addVertical(10),
              if (newsfeeds?.webUrl != null && newsfeeds!.webUrl!.isNotEmpty)
                webSiteText(newsfeeds?.webUrl ?? ''),
              if (newsfeeds?.webUrl != null && newsfeeds!.webUrl!.isNotEmpty)
                addVertical(8),
              if (newsfeeds?.feedType == 'CATALOGUE')
                _buildCatalogueRow(catalogueViewModel, context),
              Divider(color: AppColors.dividerColor),
              addVertical(4),
              _buildStatsRow(
                  '${newsfeeds?.newsfeedsLikesAggregate?.aggregate?.count ?? 0}',
                  '${newsfeeds?.newsFeedsCommentsAggregate?.aggregate?.count ?? 0}',
                  needFeedViewModel,
                  context),
              addVertical(10)
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildImageRow() {
    final mediaList = newsfeeds?.postImage ?? [];

    if (mediaList.isEmpty) return SizedBox();

    Widget buildMediaContent(media) {
      final type = media.type ?? media.mimeType ?? '';
      final url = media.url ?? '';
      final name = media.name ?? '';

      // Helper: check if base64
      bool isBase64Image(String data) => data.startsWith('data:image/');

      if (type.startsWith('image/') ||
          type.startsWith('application/octet-stream')) {
        if (isBase64Image(url)) {
          try {
            final decodedBytes = base64Decode(url.split(',').last);
            return Image.memory(decodedBytes, fit: BoxFit.cover);
          } catch (e) {
            return Icon(Icons.broken_image);
          }
        } else if (name.endsWith('.pdf')) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConst.pdf),
              addVertical(11),
              Text(name,
                  style: TextStyles.regular1(color: AppColors.lightGeryColor),
                  textAlign: TextAlign.center),
            ],
          );
        } else {
          return CachedNetworkImageWidget(imageUrl: url);
        }
      } else if (type == 'video/mp4') {
        return InlineVideoPlayer(videoUrl: url);
      } else if (type == 'application/pdf') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConst.pdf),
            addVertical(11),
            Text(name,
                style: TextStyles.regular1(color: AppColors.lightGeryColor),
                textAlign: TextAlign.center),
          ],
        );
      } else if (type == 'application/msword') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wordpress, size: 40),
            addVertical(11),
            Text(name,
                style: TextStyles.regular1(color: AppColors.lightGeryColor),
                textAlign: TextAlign.center),
          ],
        );
      } else {
        return CachedNetworkImageWidget(imageUrl: url);
      }
    }

    if (mediaList.length == 1) {
      final media = mediaList.first;
      return _mediaCard(
        child: buildMediaContent(media),
        onTap: () {
          navigationService.push(ImageViewerScreen(postImage: mediaList));
        },
        isFullWidth: true,
      );
    }

    // Multiple items
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: mediaList.map<Widget>((media) {
          return _mediaCard(
            child: buildMediaContent(media),
            onTap: () {
              navigationService.push(ImageViewerScreen(postImage: mediaList));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _mediaCard({
    required Widget child,
    VoidCallback? onTap,
    bool isFullWidth = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: isFullWidth ? double.infinity : 300,
            height: 300,
            color: Colors.grey[200],
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(String likeCount, String commentCount,
      NewsFeedViewModel viewModel, BuildContext context) {
    final isLiked = isLikedByCurrentUser(newsfeeds, viewModel.userID ?? '');

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            isLiked
                ? viewModel.removeNewsFeedLike(context, newsfeeds?.id ?? '')
                : viewModel.addNewsFeedLike(context, newsfeeds?.id ?? '');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                children: [
                  Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.primaryColor,
                  ),
                  addHorizontal(8),
                  Text('$likeCount Likes',
                      style: TextStyles.regular2(color: AppColors.black)),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Image.asset(ImageConst.comment),
                addHorizontal(8),
                Text('$commentCount comments',
                    style: TextStyles.regular3(color: AppColors.black))
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool isLikedByCurrentUser(Newsfeeds? newsfeed, String userId) {
    return newsfeed?.newsfeedsLikes?.any((e) =>
            e.adminUser?.id == userId ||
            e.dentalPractice?.id == userId ||
            e.dentalProfessional?.id == userId ||
            e.dentalSupplier?.id == userId) ??
        false;
  }

  
  Widget _buildCatalogueRow(
      CatalogueViewModel catalogueVM, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.email_outlined, color: AppColors.primaryColor),
                addHorizontal(6),
                Text(newsfeeds?.dentalSupplier?.email ?? '',
                    style: TextStyles.regular1(color: AppColors.black)),
              ],
            ),
            addVertical(8),
            Row(
              children: [
                Icon(Icons.phone, color: AppColors.primaryColor),
                addHorizontal(6),
                Text(newsfeeds?.dentalSupplier?.phone ?? '',
                    style: TextStyles.regular1(color: AppColors.black)),
              ],
            )
          ],
        ),
        AppButton(
            text: 'View',
            height: 40,
            width: 100,
            onTap: () async {
              await catalogueVM.getCatalogDetails(
                  context, newsfeeds?.payload?.catalogueId ?? '');
              final id =
                  catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
              await catalogueVM.getReletedCatalog(context, id);
              await navigationService.navigateTo(RouteList.catalogueDetails);
            })
      ],
    );
  }
}
