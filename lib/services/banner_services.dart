import 'package:di360_flutter/feature/banners/model/approve_banner_model.dart';
import 'package:di360_flutter/feature/banners/repository/banner_repository_impl.dart';

class BannerServices {
	BannerServices._privateConstructor();
	static final BannerServices _instance = BannerServices._privateConstructor();
	static BannerServices get instance => _instance;

	final BannerRepositoryImpl _repository = BannerRepositoryImpl();

	List<ApproveBanners>? _listBanner;
	List<ApproveBanners>? get listBanner => _listBanner;

  	List<ApproveBanners>? _haderBanner;
  List<ApproveBanners>? get headderBanner => _haderBanner;

	Future<void> fetchListViewBanners(dynamic variables) async {
		final bannersData = await _repository.getApprovedBanners(variables);
		_listBanner = bannersData.data?.banners ?? [];
	}
  Future<void> fetchHeaderBanners(dynamic variables) async {
    final bannersData = await _repository.getApprovedBanners(variables);
    _haderBanner = bannersData.data?.banners ?? [];
  }
}
