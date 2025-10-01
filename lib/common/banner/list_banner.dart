import 'dart:async';

import 'package:flutter/material.dart';
import 'package:di360_flutter/services/banner_services.dart';

const double _bannerHorizontalPadding = 24.0;
const double _bannerHeight = 180.0;
const double _bannerListHeight = 200.0;

class ListBanner extends StatefulWidget {
  final int pageIndex;
  const ListBanner({Key? key, required this.pageIndex}) : super(key: key);

  @override
  State<ListBanner> createState() => _ListBannerState();
}

class _ListBannerState extends State<ListBanner> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  static const Duration _scrollDuration = Duration(milliseconds: 500);
  static const Duration _timerDuration = Duration(seconds: 3);
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
      if (banners == null || banners.isEmpty) return;
      final int start = widget.pageIndex * 5;
      final int end = (start + 5).clamp(0, banners.length);
      final items = banners.sublist(start, end);
      if (items.length <= 1) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % items.length;
      });
      final screenWidth = MediaQuery.of(context).size.width;
      final bannerWidth = (screenWidth - (_bannerHorizontalPadding * 2));
      _scrollController.animateTo(
        _currentIndex * (bannerWidth + 12), // 12 is separator width
        duration: _scrollDuration,
        curve: Curves.easeInOut,
      );
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
    final int start = widget.pageIndex * 5;
    final int end = (start + 5).clamp(0, banners.length);
    if (start >= banners.length) {
      return SizedBox.shrink();
    }
    final items = banners.sublist(start, end);
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerWidth = (screenWidth - (_bannerHorizontalPadding * 2));
    return SizedBox(
      height: 220,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, idx) {
          final banner = items[idx];
          final String? imageUrl =
              (banner.image != null && banner.image!.isNotEmpty)
                  ? banner.image!.first.url
                  : null;
          return SizedBox(
            width: bannerWidth,
            height: _bannerHeight,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Expanded(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.broken_image, size: 48),
                        ),
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
