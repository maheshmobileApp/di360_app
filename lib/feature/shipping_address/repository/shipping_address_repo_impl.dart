import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/shipping_address/model/get_shipping_addresses_professional_res.dart';
import 'package:di360_flutter/feature/shipping_address/querys/add_shipping_address_query.dart';
import 'package:di360_flutter/feature/shipping_address/querys/delete_professional_shipping_address_query.dart';
import 'package:di360_flutter/feature/shipping_address/querys/get_shipping_addresses_query.dart';
import 'package:di360_flutter/feature/shipping_address/querys/update_shipping_address_query.dart';
import 'package:di360_flutter/feature/shipping_address/repository/shipping_address_repository.dart';

class ShippingAddressRepoImpl extends ShippingAddressRepository {
  final HttpService http = HttpService();

  @override
  Future<ShippingAddressesProfessionalData> getShippingAddressesProfessional(
      variables) async {
    final res = await http.query(getShippingAddressesProfessionalQuery,
        variables: variables);
    return ShippingAddressesProfessionalData.fromJson(res);
  }

  @override
  Future<dynamic> addShippingAddress(variables) async {
    final res = await http.mutation(addShippingAddressQuery, variables);
    return res;
  }

  @override
  Future<dynamic> updateShippingAddress(variables) async {
    final res = await http.mutation(updateShippingAddressQuery, variables);
    return res;
  }

  @override
  Future<dynamic> deleteShippingAddressProfessional(variables) async {
    final res =
        await http.mutation(deleteProfessionalShippingAddressQuery, variables);
    return res;
  }
}
