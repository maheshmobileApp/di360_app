import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';

abstract class SuppliesRepository {
  Future<getSupplyData> getSuppliers(dynamic variables);
  Future<dynamic> addToCart(dynamic variables);
  Future<dynamic> increaseQuantityById(dynamic variables);
  Future<getSupplyData> getSuppliesDetails(dynamic variables);
}
