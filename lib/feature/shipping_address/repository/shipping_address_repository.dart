import 'package:di360_flutter/feature/shipping_address/model/get_shipping_addresses_professional_res.dart';

abstract class ShippingAddressRepository {
  Future<ShippingAddressesProfessionalData> getShippingAddressesProfessional(
      dynamic variables);
  Future<dynamic> addShippingAddress(dynamic variables);
  Future<dynamic> updateShippingAddress(dynamic variables);
  Future<dynamic> deleteShippingAddressProfessional(dynamic variables);
}
