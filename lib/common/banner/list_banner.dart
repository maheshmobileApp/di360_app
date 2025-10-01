import 'package:flutter/material.dart';
import 'package:di360_flutter/services/banner_services.dart';

class ListBanner extends StatelessWidget {
	final int pageIndex;
	const ListBanner({Key? key, required this.pageIndex}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final banners = BannerServices.instance.listBanner;
		if (banners == null || banners.isEmpty) {
			return SizedBox.shrink();
		}
		final int start = pageIndex * 5;
		final int end = (start + 5).clamp(0, banners.length);
		if (start >= banners.length) {
			return SizedBox.shrink();
		}
		final items = banners.sublist(start, end);
		return SizedBox(
			height: 220,
			child: ListView.separated(
				scrollDirection: Axis.horizontal,
				padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
				itemCount: items.length,
				separatorBuilder: (_, __) => SizedBox(width: 12),
				itemBuilder: (context, idx) {
					final banner = items[idx];
					final String? imageUrl = (banner.image != null && banner.image!.isNotEmpty)
							? banner.image!.first.url
							: null;
					return SizedBox(
						width: 180,
						child: Card(
							color: Colors.amber[100],
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: [
									if (imageUrl != null && imageUrl.isNotEmpty)
										ClipRRect(
											borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
											child: Image.network(
												imageUrl,
												height: 100,
												fit: BoxFit.cover,
												errorBuilder: (context, error, stackTrace) => Container(
													height: 100,
													color: Colors.grey[300],
													child: Icon(Icons.broken_image, size: 48),
												),
											),
										),
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: Text(
											banner.bannerName ?? 'Banner',
											style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
											maxLines: 1,
											overflow: TextOverflow.ellipsis,
										),
									),
									if (banner.companyName != null || banner.categoryName != null)
										Padding(
											padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
											child: Text(
												banner.companyName ?? banner.categoryName ?? '',
												style: TextStyle(fontSize: 13),
												maxLines: 1,
												overflow: TextOverflow.ellipsis,
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
