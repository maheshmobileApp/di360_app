import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/purchased_products/model/purchased_order_items_res.dart';
import 'package:di360_flutter/feature/purchased_products/querys/purchased_order_items_query.dart';
import 'package:di360_flutter/feature/purchased_products/repository/purchased_order_items_repository.dart';

class PurchasedOrderItemsRepoImpl implements PurchasedOrderItemsRepository {
  final HttpService http = HttpService();

  @override
  Future<PurchasedOrderItemsData> getPurchasedOrderItems(variables) async {
    final res =
        await http.query(purchasedOrderItemsQuery, variables: variables);
    return PurchasedOrderItemsData.fromJson(res);
  }
}
