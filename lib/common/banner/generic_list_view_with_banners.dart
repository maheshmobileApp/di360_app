import 'package:flutter/material.dart';

/// A generic ListView.builder that injects banners (or any widget) at specified indices.
class GenericListViewWithBanners<T> extends StatelessWidget {
	final List<T> items;
	final List<int> bannerIndices;
	final Widget Function(BuildContext context, int dataIndex) itemBuilder;
	final Widget Function(BuildContext context, int bannerPosition) bannerBuilder;
	final Axis scrollDirection;
	final bool shrinkWrap;
	final ScrollPhysics? physics;

	const GenericListViewWithBanners({
		Key? key,
		required this.items,
		required this.bannerIndices,
		required this.itemBuilder,
		required this.bannerBuilder,
		this.scrollDirection = Axis.vertical,
		this.shrinkWrap = false,
		this.physics,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final totalCount = items.length + bannerIndices.length;
		return ListView.builder(
			itemCount: totalCount,
			scrollDirection: scrollDirection,
			shrinkWrap: shrinkWrap,
			physics: physics,
			itemBuilder: (context, index) {
				// If this index is a banner position, show banner
				final bannerPos = bannerIndices.indexOf(index);
				if (bannerPos != -1) {
					return bannerBuilder(context, bannerPos);
				}
				// Calculate the actual data index, skipping banners before this index
				int numBannersBefore = bannerIndices.where((b) => b < index).length;
				final dataIndex = index - numBannersBefore;
				if (dataIndex < 0 || dataIndex >= items.length) {
					return const SizedBox.shrink();
				}
				return itemBuilder(context, dataIndex);
			},
		);
	}
}
