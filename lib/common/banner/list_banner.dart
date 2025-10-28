import 'dart:async';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/services/banner_services.dart';

const double _bannerHorizontalPadding = 24.0;
const double _bannerHeight = 180.0;
const double _bannerListHeight = 190.0;
const int _bannerScrollDuration = 3; //Duration in Seconds
// const int _bannerVisibleItems = 2;

class ListBanner extends StatefulWidget {
  const ListBanner({Key? key}) : super(key: key);

  @override
  State<ListBanner> createState() => _ListBannerState();
}

class _ListBannerState extends State<ListBanner> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  static const Duration _scrollDuration = Duration(milliseconds: 500);
  static const Duration _timerDuration =
      Duration(seconds: _bannerScrollDuration);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(_timerDuration, (_) {
      if (!mounted) return;
      final banners = BannerServices.instance.listBanner;
      if (banners == null || banners.length <= 1) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % banners.length;
      });
      final screenWidth = MediaQuery.of(context).size.width;
      final bannerWidth = (screenWidth - (_bannerHorizontalPadding * 2));
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _currentIndex * (bannerWidth + 12), // 12 is separator width
          duration: _scrollDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banners = BannerServices.instance.listBanner;
    if (banners == null || banners.isEmpty) {
      return SizedBox.shrink();
    }
    final shuffledBanners = List.of(banners)..shuffle();
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerWidth = (screenWidth - (_bannerHorizontalPadding * 2));
    return SizedBox(
      height: _bannerListHeight,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: shuffledBanners.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, idx) {
          final banner = shuffledBanners[idx];
          final String? imageUrl =
              (banner.image != null && banner.image!.isNotEmpty)
                  ? banner.image!.first.url
                  : null;
          return SizedBox(
            width: bannerWidth,
            height: _bannerHeight,
            child: Card(
              elevation: 4,
              color: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImageWidget(imageUrl: imageUrl),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
