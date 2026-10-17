import 'package:di360_flutter/feature/purchased_products/model/purchased_products_res.dart';

abstract class PurchasedProductsRepository {
  Future<PurchasedProductsData> purchasedProducts(dynamic variables); 
}