import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/shipping_charges/model/shipping_charges_res.dart';
import 'package:di360_flutter/feature/shipping_charges/querys/get_shipping_charges_query.dart';
import 'package:di360_flutter/feature/shipping_charges/repository/shipping_charges_repository.dart';

class ShippingChargesRepoImpl implements ShippingChargesRepository {
  final HttpService http = HttpService();

  @override
  Future<ShippingChargesData> getShippingCharges(dynamic variables) async {
    final res = await http.query(getShippingChargesQuery, variables: variables);
    return ShippingChargesData.fromJson(res);
  }
}
