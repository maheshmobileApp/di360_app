import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/shipping_address/model/get_shipping_addresses_professional_res.dart';
import 'package:di360_flutter/feature/shipping_address/querys/add_shipping_address_query.dart';
import 'package:di360_flutter/feature/shipping_address/querys/delete_professional_shipping_address_query.dart';
import 'package:di360_flutter/feature/shipping_address/querys/get_shipping_addresses_query.dart';
import 'package:di360_flutter/feature/shipping_address/querys/update_shipping_address_query.dart';
import 'package:di360_flutter/feature/shipping_address/repository/shipping_address_repository.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class ShippingAddressRepoImpl extends ShippingAddressRepository {
  final HttpService http = HttpService();

  @override
  Future<List<DentalProfessionalAddresses>> getShippingAddressesProfessional(
      variables) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final isProfessional = type == UserRole.professional.value;
    final query = isProfessional
        ? getShippingAddressesProfessionalQuery
        : getShippingAddressesPracticeQuery;
    final res = await http.query(query, variables: variables);
    final List<dynamic> data = isProfessional
        ? (res['dental_professional_addresses'] ?? [])
        : (res['dental_practice_addresses'] ?? []);

    return data
        .map(
          (e) => DentalProfessionalAddresses.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<dynamic> addShippingAddress(variables) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final isProfessional = type == UserRole.professional.value;
    final query = isProfessional
        ? addShippingAddressQuery
        : addShippingAddressPracticeQuery;
    final res = await http.mutation(query, variables);
    return res;
  }

  @override
  Future<dynamic> updateShippingAddress(variables) async {
    final res = await http.mutation(updateShippingAddressQuery, variables);
    return res;
  }

  @override
  Future<dynamic> deleteShippingAddressProfessional(variables) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final isProfessional = type == UserRole.professional.value;
    final query = isProfessional
        ? deleteProfessionalShippingAddressQuery
        : deletePracticeShippingAddressQuery;
    final res = await http.mutation(query, variables);
    return res;
  }
}
