import 'package:di360_flutter/feature/orders/model/orders_res.dart';
import 'package:di360_flutter/feature/orders/model/view_order_res.dart';

abstract class OrdersRepository {
  Future<OrdersData> getIPSuppliesOrders(dynamic variables);
  Future<ViewOrderData> viewOrderDetail(dynamic variables);
}
