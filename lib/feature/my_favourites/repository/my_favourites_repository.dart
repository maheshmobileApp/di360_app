import 'package:di360_flutter/feature/my_favourites/model/supply_favourites_res.dart';

abstract class MyFavouritesRepository {
  Future<SupplyFavouritesData> getSupplyFavourites(dynamic variables);
  Future<dynamic> deleteFavourite(dynamic variables);
}
