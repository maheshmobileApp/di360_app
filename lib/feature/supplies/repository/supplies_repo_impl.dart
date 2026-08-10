import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/queries/add_to_cart_query.dart';
import 'package:di360_flutter/feature/supplies/queries/decrease_quantity_query.dart';
import 'package:di360_flutter/feature/supplies/queries/delete_cart_item.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies_cart_query.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies_details_query.dart';
import 'package:di360_flutter/feature/supplies/queries/increase_quantity_query.dart';
import 'package:di360_flutter/feature/supplies/repository/supplies_repository.dart';

class SuppliesRepoImpl extends SuppliesRepository {
  final http = HttpService();
  @override
  Future<getSupplyData> getSuppliers(variables) async {
    final res = await http.query(getSupplies, variables: variables);
    return getSupplyData.fromJson(res);
  }

  @override
  Future<dynamic> addToCart(variables) async {
    final res = await http.mutation(addToCartQuery, variables);
    return res;
  }

  @override
  Future<dynamic> increaseQuantityById(variables) async {
    final res = await http.mutation(increaseQuantityQuery, variables);
    return res;
  }

  @override
  Future<dynamic> decreaseQuantityById(variables) async {
    final res = await http.mutation(decreaseQuantityQuery, variables);
    return res;
  }

  @override
  Future<getSupplyData> getSuppliesDetails(variables) async {
    final res = await http.query(getSuppliesDetailsQuery, variables: variables);
    return getSupplyData.fromJson(res);
  }

  @override
  Future<SupplyCartData> getSupplyCarts() async {
    final res = await http.query(
      getSuppliesCartQuery,
    );
    return SupplyCartData.fromJson(res);
  }

  @override
  Future<dynamic> deleteCartItem(variables) async {
    final res = await http.mutation(deleteCartItemQuery, variables);
    return res;
  }
}
