import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';

abstract class OrdersRepository {
  Future<SuppliesOrdersData> getIPSuppliesOrders(dynamic variables);

}
