import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/directors/model_class/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';
import 'package:di360_flutter/feature/directors/querys/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/querys/get_all_banners.dart';
import 'package:di360_flutter/feature/directors/querys/get_director_based_on_catagory.dart';
import 'package:di360_flutter/feature/directors/querys/get_directors_query.dart';
import 'package:di360_flutter/feature/directors/respository/director_repository.dart';

class DirectorRepositoryImpl extends DirectorRepository {
  final HttpService http = HttpService();

  @override
  Future<List<Directories>> getDirectors(String catagoryId,String searchText) async {
    final res = (catagoryId.isEmpty && searchText.isEmpty)
        ? await http.query(getDirectorsQuery)
        : await http.query(GetDirectorBasedOnCatagoryQuery,
            variables: {"id": catagoryId, "name": "%$searchText%"});
    final result = DirectoriesData.fromJson(res);
    return result.directories ?? [];
  }

  @override
  Future<List<Banners>> getBannersList() async {
    final res = await http.query(getAllBannersQuery, variables: {
      "status": "APPROVED",
      "category_names": [
        "All Header Banners",
        "All Left Nav Small Banners",
        "All List View Large Banners"
      ],
      "banner_location": [
        "Web Header Directory",
        "Web Left Nav Directory",
        "Web Directory List View"
      ]
    });
    final result = BannersData.fromJson(res);
    return result.banners ?? [];
  }

  @override
  Future<List<DirectoryBusinessTypes>> directoriesCatagory() async {
    final res = await http.query(directoriesCatagoryQuery);
    final result = DirectoriesCatagoryData.fromJson(res);
    return result.directoryBusinessTypes ?? [];
  }
}
