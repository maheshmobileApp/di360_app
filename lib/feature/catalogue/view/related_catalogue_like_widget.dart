import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatedCatalogueLikeWidget extends StatelessWidget {
  final CatalogData? cat;
  RelatedCatalogueLikeWidget({super.key, this.cat});

  @override
  Widget build(BuildContext context) {
    final feedVM = Provider.of<NewsFeedViewModel>(context);
    final catalogVM = Provider.of<CatalogueViewModel>(context);
    final isLiked = isLikedByCurrentUser(feedVM.userID ?? '');
    return GestureDetector(
      onTap: () => isLiked
          ? catalogVM.relatedCatalogueUnLike(cat?.id ?? '')
          : catalogVM.releatedCatalogueLike(cat?.id ?? ''),
      child: CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.buttomBarColor,
          child: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: AppColors.primaryColor, size: 16)),
    );
  }

  bool isLikedByCurrentUser(String userId) {
    return cat?.catalogueFavorites?.any((e) =>
            e.dentalPracticeId == userId ||
            e.dentalProfessionalId == userId ||
            e.dentalSupplierId == userId) ??
        false;
  }
}
