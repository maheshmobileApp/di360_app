import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/my_favourites/model/supply_favourites_res.dart';
import 'package:di360_flutter/feature/my_favourites/queries/delete_favourite_query.dart';
import 'package:di360_flutter/feature/my_favourites/queries/supply_favourites_query.dart';
import 'package:di360_flutter/feature/my_favourites/repository/my_favourites_repository.dart';

class MyFavouritesRepoImpl extends MyFavouritesRepository {
  final HttpService http = HttpService();
  @override
  Future<SupplyFavouritesData> getSupplyFavourites(variables) async {
    final res = await http.query(supplyFavouritesQuery, variables: variables);
    final result = SupplyFavouritesData.fromJson(res);
    return result;
  }

  @override
  Future<dynamic> deleteFavourite(variables) async {
    final res = await http.mutation(deleteFavouriteQuery, variables);

    return res;
  }
}
