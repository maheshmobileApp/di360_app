import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/quary/category_quary.dart';
import 'package:di360_flutter/feature/banners/quary/get_banners_query.dart';
import 'package:di360_flutter/feature/banners/repository/banners_repository.dart';

class BannerRepositoryImpl extends BannersRepository {
  final HttpService http = HttpService();

  @override
  Future<List<BannerCategories>> bannerCategotyList() async {
    final bannerCategoriesData = await http.query(bannersCategoryQuery);
    final result = BannersCategoriesData.fromJson(bannerCategoriesData);
    return result.bannerCategories ?? [];
  }

  @override
  Future<List<Banners>?> getMyBanners(variables) async {
   final bannersData =
        await http.query(getBannersQuery, variables: variables);
    final result = BannersData.fromJson(bannersData);
    return result.banners?? [];
  }
}
