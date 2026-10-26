import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';
import 'package:di360_flutter/feature/orders/querys/get_orders_query.dart';
import 'package:di360_flutter/feature/orders/repository/orders_repository.dart';

class OrdersRepoImpl extends OrdersRepository {
  final HttpService http = HttpService();

  @override
  Future<SuppliesOrdersData> getIPSuppliesOrders(variables) async {
    final res = await http.query(suppliesIPOrdersQuery, variables: variables);
    final result = SuppliesOrdersData.fromJson(res);
    return result;
  }
}
