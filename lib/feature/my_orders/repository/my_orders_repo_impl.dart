import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';
import 'package:di360_flutter/feature/my_orders/queries/supplies_orders_query.dart';
import 'package:di360_flutter/feature/my_orders/repository/my_orders_repository.dart';

class MyOrdersRepoImpl extends MyOrdersRepository {
  final HttpService http = HttpService();

  @override
  Future<SuppliesOrdersData> getSuppliesOrders(variables) async {
    final res = await http.query(suppliesOrdersQuery, variables: variables);
    final result = SuppliesOrdersData.fromJson(res);
    return result;
  }
}
