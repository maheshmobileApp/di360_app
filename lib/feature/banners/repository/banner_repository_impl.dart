import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/banners/model/banners_count_model.dart';
import 'package:di360_flutter/feature/banners/model/edit_banner_model.dart';
import 'package:di360_flutter/feature/banners/model/approve_banner_model.dart';

import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/quary/add_banner_quary.dart';
import 'package:di360_flutter/feature/banners/quary/banner_count_query.dart';
import 'package:di360_flutter/feature/banners/quary/category_quary.dart';
import 'package:di360_flutter/feature/banners/quary/delete_banner_query.dart';
import 'package:di360_flutter/feature/banners/quary/edit_banner_view.dart';
import 'package:di360_flutter/feature/banners/quary/get_approve_banner.dart';
import 'package:di360_flutter/feature/banners/quary/get_banners_query.dart';
import 'package:di360_flutter/feature/banners/quary/update_banner_query.dart';
import 'package:di360_flutter/feature/banners/repository/banners_repository.dart';

class BannerRepositoryImpl extends BannersRepository {
  final HttpService http = HttpService();

  @override
  Future<List<BannerCategories>> bannerCategotyList() async {
    final bannerCategoriesData = await http.query(bannersCategoryQuery);
    final result = BannersCategoriesData.fromJson(bannerCategoriesData);
    return result.bannerCategories??[];
  }

  @override
  Future<List<Banners>?> getMyBanners(variables) async {
   final bannersData =
        await http.query(getBannersQuery, variables: variables);
    final result = BannersData.fromJson(bannersData);
    return result.banners?? [];
  }
  
 
  @override
  Future<dynamic> addBanners(dynamic variables) async {
    final data = await http.mutation(addBannerQuery, variables);
    return data;
  }
   @override
  Future<dynamic> deleteBanner(String? id) async {
    final deleteBannerData = await http.mutation(deleteBannerQuery, {"id": id});
    return deleteBannerData;
  }

  @override
  Future<BannersByPk?> editBannerView(String? id) async{
     final editbannerViewData =
        await http.query(editBannerViewQuary, variables: {"id": id});
    final result = BannerViewData.fromJson(editbannerViewData);
    return result.bannersByPk;
  }
  
  @override
  Future<dynamic> updateBanner(variables) async {
    final data = await http.mutation(updateBannerQuary, variables);
    return data;
  }
@override
  Future<BannersCountData> bannersCounts() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final data = await http.query(getBannersCountQuery,
        variables: {"from_id": userId}
        );
    final result = BannersCountData.fromJson(data);
    return result;
  }
 
  
 @override
  Future<ApproveBannerResp> getApprovedBanners(
      {dynamic variables = const {
        "limit": 100,
        "offset": 0,
      }}) async {
    
    final response = await http.query(
      approveBannerQuary,
      variables: {
        "limit": 100,
        "offset": 0,
      },
    );

    if (response != null && response['banners'] != null) {
      return ApproveBannerResp.fromJson(response);
    } else {
      throw Exception("Empty response received from server");
    }
  }
}
