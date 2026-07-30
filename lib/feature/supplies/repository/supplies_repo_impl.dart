import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies.dart';
import 'package:di360_flutter/feature/supplies/repository/supplies_repository.dart';

class SuppliesRepoImpl extends SuppliesRepository {
  final http = HttpService();
  @override
  Future<getSupplyData> getSuppliers(variables) async {
    final res = await http.query(getSupplies, variables: variables);
    return getSupplyData.fromJson(res);
  }
}
