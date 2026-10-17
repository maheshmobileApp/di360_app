import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/purchased_products/model/purchased_products_res.dart';
import 'package:di360_flutter/feature/purchased_products/querys/purchased_items_query.dart';
import 'package:di360_flutter/feature/purchased_products/repository/purchased_products_repository.dart';

class PurchasedProductsRepoImpl extends PurchasedProductsRepository {
  final HttpService http = HttpService();
  @override
  Future<PurchasedProductsData> purchasedProducts(dynamic variables) async {
    final response =
        await http.query(purchasedItemsQuery, variables: variables);
    return PurchasedProductsData.fromJson(response);
  }
}
