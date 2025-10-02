import 'package:flutter/material.dart';
import 'package:di360_flutter/services/banner_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';

const double _bannerGridPadding = 16.0;
const double _bannerGridItemHeight = 180.0;
const int _bannerGridCrossAxisCount = 2;

class BannerGrid extends StatelessWidget {
  final int pageIndex;
  final int itemsPerPage;
  const BannerGrid({Key? key, required this.pageIndex, this.itemsPerPage = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final banners = BannerServices.instance.listBanner;
    if (banners == null || banners.isEmpty) {
      return SizedBox.shrink();
    }
    final int start = pageIndex * itemsPerPage;
    final int end = (start + itemsPerPage).clamp(0, banners.length);
    if (start >= banners.length) {
      return SizedBox.shrink();
    }
    final items = banners.sublist(start, end);
    return Padding(
      padding: const EdgeInsets.all(_bannerGridPadding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _bannerGridCrossAxisCount,
          mainAxisSpacing: _bannerGridPadding,
          crossAxisSpacing: _bannerGridPadding,
          childAspectRatio: 1.2,
        ),
        itemCount: items.length,
        itemBuilder: (context, idx) {
          final banner = items[idx];
          final String? imageUrl = (banner.image != null && banner.image!.isNotEmpty)
              ? banner.image!.first.url
              : null;
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (imageUrl != null && imageUrl.isNotEmpty)
                  Expanded(
                    child: CachedNetworkImageWidget(imageUrl: imageUrl),
                  ),
                // Add title/description widgets here if needed
              ],
            ),
          );
        },
      ),
    );
  }
}
