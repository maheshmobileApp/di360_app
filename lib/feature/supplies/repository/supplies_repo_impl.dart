import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/my_favourites/queries/delete_favourite_query.dart';
import 'package:di360_flutter/feature/supplies/model/dental_professional_address_res.dart';
import 'package:di360_flutter/feature/supplies/model/favourites_keys_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_account_towards_supplier_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_dental_suppliers.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_categories.dart';
import 'package:di360_flutter/feature/supplies/model/shipping_charges_res.dart';
import 'package:di360_flutter/feature/supplies/model/supplier_account_practice.dart';
import 'package:di360_flutter/feature/supplies/model/supplier_account_res.dart';
import 'package:di360_flutter/feature/supplies/model/supply_brands_res.dart';
import 'package:di360_flutter/feature/supplies/queries/add_address_query.dart';
import 'package:di360_flutter/feature/supplies/queries/add_favourite_query.dart';
import 'package:di360_flutter/feature/supplies/queries/add_multiple_products_to_cart_query.dart';
import 'package:di360_flutter/feature/supplies/queries/add_order_query.dart';
import 'package:di360_flutter/feature/supplies/queries/add_supplier_account_query.dart';
import 'package:di360_flutter/feature/supplies/queries/add_supplier_account_request.dart';
import 'package:di360_flutter/feature/supplies/queries/add_to_cart_query.dart';
import 'package:di360_flutter/feature/supplies/queries/decrease_quantity_query.dart';
import 'package:di360_flutter/feature/supplies/queries/delete_cart_item.dart';
import 'package:di360_flutter/feature/supplies/queries/dental_practice_addresses_query.dart';
import 'package:di360_flutter/feature/supplies/queries/dental_professional_address.dart';
import 'package:di360_flutter/feature/supplies/queries/favourites_keys_query.dart';
import 'package:di360_flutter/feature/supplies/queries/get_account_towards_supplier.dart';
import 'package:di360_flutter/feature/supplies/queries/get_dental_suppliers_query.dart';
import 'package:di360_flutter/feature/supplies/queries/get_shipping_charges_query.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies_cart_query.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supplies_details_query.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supply_brands.dart';
import 'package:di360_flutter/feature/supplies/queries/get_supply_categories.dart';
import 'package:di360_flutter/feature/supplies/queries/increase_quantity_query.dart';
import 'package:di360_flutter/feature/supplies/repository/supplies_repository.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class SuppliesRepoImpl extends SuppliesRepository {
  final http = HttpService();
  @override
  Future<GetSupplyData> getSuppliers(variables) async {
    print("***calling supplies");
    final res = await http.query(getSupplies, variables: variables);
    if (res == null || res['_error'] != null) return GetSupplyData();
    return GetSupplyData.fromJson(res);
  }

  @override
  Future<dynamic> addToCart(variables) async {
    final res = await http.mutation(addToCartQuery, variables);
    return res;
  }

  @override
  Future<dynamic> increaseQuantityById(variables) async {
    final res = await http.mutation(increaseQuantityQuery, variables);
    return res;
  }

  @override
  Future<dynamic> decreaseQuantityById(variables) async {
    final res = await http.mutation(decreaseQuantityQuery, variables);
    return res;
  }

  @override
  Future<GetSupplyData> getSuppliesDetails(variables) async {
    final res = await http.query(getSuppliesDetailsQuery, variables: variables);
    return GetSupplyData.fromJson(res);
  }

  @override
  Future<SupplyCartData> getSupplyCarts() async {
    final res = await http.query(
      getSuppliesCartQuery,
    );
    return SupplyCartData.fromJson(res);
  }

  @override
  Future<dynamic> deleteCartItem(variables) async {
    final res = await http.mutation(deleteCartItemQuery, variables);
    return res;
  }

  @override
  Future<List<DentalProfessionalAddresses>> dentalProfessionalAddress() async {
    final type = await LocalStorage.getStringVal(
      LocalStorageConst.type,
    );

    final isProfessional = type == UserRole.professional.value;

    final query = isProfessional
        ? dentalProfessionalAddressQuery
        : dentalPracticeAddressesQuery;

    final res = await http.query(query);

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
  Future<dynamic> addAddress(variables) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final isProfessional = type == UserRole.professional.value;
    final res = await http.mutation(
        isProfessional ? addAddressQuery : addPracticeAddressQuery, variables);
    return res;
  }

  @override
  Future<AccountData> getAccountTowardsSupplier(variables) async {
    final res =
        await http.query(getAccountTowardsSupplierQuery, variables: variables);
    return AccountData.fromJson(res);
  }

  @override
  Future<dynamic> addFavourite(variables) async {
    final res = await http.mutation(addFavouriteQuery, variables);
    return res;
  }

  @override
  Future<dynamic> deleteFavourite(variables) async {
    final res = await http.mutation(deleteFavouriteQuery, variables);
    return res;
  }

  @override
  Future<dynamic> addMultipleProductsToCart(variables) async {
    final res = await http.mutation(addMultipleProductstoCartQuery, variables);
    return res;
  }

  @override
  Future<FavouritesKeysData> getFavouritesKeys(variables) async {
    final res = await http.query(favouritesKeysQuery);
    return FavouritesKeysData.fromJson(res);
  }

  @override
  Future<dynamic> addOrder(variables) async {
    final res = await http.mutation(addOrderQuery, variables);
    return res;
  }

  @override
  Future<SupplierAccountData> addSupplierAccountRequest(variables) async {
    final res = await http.mutation(addSupplierAccountRequestQuery, variables);
    return SupplierAccountData.fromJson(res);
  }

  @override
  Future<SupplierAccountPracticeData> addSupplierAccount(dynamic variables) async {
    final res = await http.mutation(addSupplierAccountQuery, variables);
    return SupplierAccountPracticeData.fromJson(res);
  }

  @override
  Future<ShippingChargesData> getShippingCharges(variables) async {
    final res = await http.query(getShippingChargesQuery, variables: variables);
    return ShippingChargesData.fromJson(res);
  }

  @override
  Future<SupplyBrandsData> getSupplyBrands(variables) async {
    final res = await http.query(getSupplyBrandsQuery);
    return SupplyBrandsData.fromJson(res);
  }

  @override
  Future<SupplyCategoriesData> getSupplyCategories(variables) async {
    final res = await http.query(getSupplyCategoriesQuery);
    return SupplyCategoriesData.fromJson(res);
  }

  @override
  Future<DentalSuppliersData> getDentalSuppliers(variables) async {
    final res = await http.query(getDentalSuppliersQuery);
    return DentalSuppliersData.fromJson(res);
  }
}
