 
import 'package:di360_flutter/feature/my_orders/model/get_all_dental_suppliers_res.dart';
import 'package:di360_flutter/feature/my_orders/model/supplies_orders_res.dart';

abstract class MyOrdersRepository {

  Future<SuppliesOrdersData> getSuppliesOrders(dynamic variables);
  Future<AllDentalSuppliersData> getAllDentalSuppliers();
}