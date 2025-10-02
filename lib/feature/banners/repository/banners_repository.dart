import 'package:di360_flutter/feature/banners/model/banners_count_model.dart';
import 'package:di360_flutter/feature/banners/model/edit_banner_model.dart';
import 'package:di360_flutter/feature/banners/model/approve_banner_model.dart';
import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';

abstract class BannersRepository {
  Future<List<Banners>?> getMyBanners(dynamic variables);
  Future<List<BannerCategories>?> bannerCategotyList();
  Future<dynamic> addBanners(dynamic variables);
  Future<void> deleteBanner(String? id);
  Future<BannersByPk?> editBannerView(String? id);
  Future<dynamic> updateBanner(dynamic variables);
  Future<BannersCountData> bannersCounts();
  Future<ApproveBannerResp> getApprovedBanners({dynamic variables});
}
