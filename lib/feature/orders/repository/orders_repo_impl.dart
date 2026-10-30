import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/orders/model/orders_res.dart';
import 'package:di360_flutter/feature/orders/model/view_order_res.dart';
import 'package:di360_flutter/feature/orders/querys/get_orders_query.dart';
import 'package:di360_flutter/feature/orders/querys/view_order_query.dart';
import 'package:di360_flutter/feature/orders/repository/orders_repository.dart';

class OrdersRepoImpl extends OrdersRepository {
  final HttpService http = HttpService();

  @override
  Future<OrdersData> getIPSuppliesOrders(variables) async {
    final res = await http.query(suppliesIPOrdersQuery, variables: variables);
    final result = OrdersData.fromJson(res);
    return result;
  }

  @override
  Future<ViewOrderData> viewOrderDetail(variables) async {
    final res = await http.query(viewOrderQuery, variables: variables);
    final result = ViewOrderData.fromJson(res);
    return result;
  }
}
