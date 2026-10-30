
import 'package:di360_flutter/feature/shipping_charges/model/shipping_charges_res.dart';

abstract class ShippingChargesRepository {
  Future<ShippingChargesData> getShippingCharges(dynamic variables);
}