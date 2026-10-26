import 'package:di360_flutter/feature/supplies/model/dental_practice_addresses_res.dart';
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

abstract class SuppliesRepository {
  Future<GetSupplyData> getSuppliers(dynamic variables);
  Future<dynamic> addToCart(dynamic variables);
  Future<dynamic> increaseQuantityById(dynamic variables);
  Future<dynamic> decreaseQuantityById(dynamic variables);
  Future<GetSupplyData> getSuppliesDetails(dynamic variables);
  Future<SupplyCartData> getSupplyCarts();
  Future<dynamic> deleteCartItem(dynamic variables);
  Future<List<DentalProfessionalAddresses>> dentalProfessionalAddress();
  Future<dynamic> addAddress(dynamic variables);
  Future<AccountData> getAccountTowardsSupplier(dynamic variables);
  Future<dynamic> addFavourite(dynamic variables);
  Future<dynamic> deleteFavourite(dynamic variables);
  Future<dynamic> addMultipleProductsToCart(dynamic variables);
  Future<FavouritesKeysData> getFavouritesKeys(dynamic variables);
  Future<dynamic> addOrder(dynamic variables);
  Future<SupplierAccountData> addSupplierAccountRequest(dynamic variables);
  Future<SupplierAccountPracticeData> addSupplierAccount(dynamic variables);
  Future<ShippingChargesData> getShippingCharges(dynamic variables);
  Future<SupplyBrandsData> getSupplyBrands(dynamic variables);
  Future<SupplyCategoriesData> getSupplyCategories(dynamic variables);
  Future<DentalSuppliersData> getDentalSuppliers(dynamic variables);
}
