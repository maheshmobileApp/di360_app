import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';

abstract class BannersRepository {
  Future<List<Banners>?> getMyBanners(dynamic variables);
  Future<List<BannerCategories>?> bannerCategotyList();
  Future<dynamic> addBanners(dynamic variables);
  Future<void> deleteBanner(String? id);
}
