import 'package:di360_flutter/feature/purchased_products/model/purchased_order_items_res.dart';

abstract class PurchasedOrderItemsRepository {
  Future<PurchasedOrderItemsData> getPurchasedOrderItems(dynamic variables);
}
