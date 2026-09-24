import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/supplies/model/dental_professional_address_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_account_towards_supplier_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/repository/supplies_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class SuppliesViewModel extends ChangeNotifier {
  final SuppliesRepoImpl repo = SuppliesRepoImpl();

  getSupplyData? supplyData;
  Supplies? suppliesDetailsData;
  SupplyCartData? suppliesCartData;
  DentalProfessionalAddressesData? dentalProfessionalAddress;

  final locationController = TextEditingController();
  final otherTypeController = TextEditingController();
  final nameController = TextEditingController();
  final addressline1Controller = TextEditingController();
  final addressline2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final companyNameController = TextEditingController();
  final postcodeController = TextEditingController();
  final compNameController = TextEditingController();
  final compCompanyNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final emailController = TextEditingController();
  final deliveryDateController = TextEditingController();

  String? addressType;
  String selectedType = "";

  void setSelectedType(String value) {
    selectedType = value;
    notifyListeners();
  }

  void setAddressType(String value) {
    addressType = value;
    notifyListeners();
  }

  int _supplyLimit = 20;
  int _supplyOffset = 0;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  int selectedTotal = 0;

  //cart quantity
  final Map<String, int> _cartQuantity = {};

  int getQuantity(String productId) {
    return _cartQuantity[productId] ?? 0;
  }

  void increaseQuantity(String productId) {
    _cartQuantity[productId] = getQuantity(productId) + 1;
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (getQuantity(productId) > 0) {
      _cartQuantity[productId] = getQuantity(productId) - 1;

      if (_cartQuantity[productId] == 0) {
        _cartQuantity.remove(productId);
      }

      notifyListeners();
    }
  }

  void resetQuantity(String productId) {
    _cartQuantity.remove(productId);
    notifyListeners();
  }

  Map<String, bool> get selectedProducts => _selectedProducts;

  final Map<String, bool> _selectedProducts = {};
  String? _selectedSupplier;

  void clearSelectedSuppliersAndProducts() {
    _selectedSupplier = null;
    _selectedProducts.clear();

    notifyListeners();
  }

  bool isProductSelected(String cartId) {
    return _selectedProducts[cartId] ?? false;
  }

  void toggleProduct(
    SupplyCarts item,
    bool value,
  ) {
    final supplier = item.supply?.dentalSupplier?.businessName ?? "";

    // Switching supplier
    if (_selectedSupplier != supplier) {
      _selectedProducts.clear();
      _selectedSupplier = supplier;
    }

    _selectedProducts[item.id!] = value;

    // If no products remain selected, clear supplier
    final hasSelected = _selectedProducts.values.any((e) => e);

    if (!hasSelected) {
      _selectedSupplier = null;
    }

    notifyListeners();
  }

  void toggleSupplier(
    String supplierName,
    bool value,
  ) {
    final carts = suppliesCartData?.supplyCarts ?? [];

    _selectedProducts.clear();

    if (value) {
      _selectedSupplier = supplierName;

      // Select all products of this supplier
      for (final item in carts) {
        if (item.supply?.dentalSupplier?.businessName == supplierName) {
          _selectedProducts[item.id!] = true;
        }
      }
    } else {
      _selectedSupplier = null;
    }

    notifyListeners();
  }

  bool isSupplierSelected(String supplierName) {
    return _selectedSupplier == supplierName &&
        _selectedProducts.values.any((e) => e);
  }

  String? resolveSupplierIdForGroup(String supplierName) {
    final carts = suppliesCartData?.supplyCarts ?? [];

    for (final item in carts) {
      final businessName = item.supply?.dentalSupplier?.businessName ?? '';
      if (businessName == supplierName) {
        final supplierId = item.supply?.dentalSupplier?.id;
        if (supplierId != null && supplierId.isNotEmpty) {
          return supplierId;
        }
      }
    }

    return null;
  }

  bool? supplierCheckboxValue(String supplierName) {
    final carts = suppliesCartData?.supplyCarts ?? [];

    final supplierItems = carts.where(
      (e) => e.supply?.dentalSupplier?.businessName == supplierName,
    );

    final total = supplierItems.length;

    final selected = supplierItems
        .where(
          (e) => _selectedProducts[e.id] ?? false,
        )
        .length;

    if (selected == 0) return false;

    if (selected == total) return true;

    return null;
  }

  Future<void> getSuppliers(
    BuildContext context, {
    bool isLoadMore = false,
  }) async {
    if (isLoading || isLoadingMore) return;
    if (isLoadMore && !hasMoreData) return;

    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isLoading = true;
      _supplyOffset = 0;
      hasMoreData = true;
      Loaders.circularShowLoader(context);
    }

    final variables = {
      "andList": [
        {
          "status": {"_eq": "APPROVED"}
        },
        {
          "product_status": {"_eq": "ACTIVE"}
        },
        {
          "name": {"_ilike": "%%"}
        },
        {
          "supply_brand": {
            "status": {"_eq": "ACTIVE"}
          }
        },
        {
          "supply_category": {
            "status": {"_eq": "ACTIVE"}
          }
        },
        {
          "supply_sub_category": {
            "status": {"_eq": "ACTIVE"}
          }
        },
        {
          "supply_variants": {
            "make_default": {"_eq": true}
          }
        }
      ],
      "limit": _supplyLimit,
      "offset": _supplyOffset,
    };

    final res = await repo.getSuppliers(variables);

    final newItems = res.supplies ?? [];

    if (isLoadMore) {
      supplyData?.supplies?.addAll(newItems);
    } else {
      supplyData = res;
    }

    if (newItems.length < _supplyLimit) {
      hasMoreData = false;
    } else {
      _supplyOffset += _supplyLimit;
    }

    if (!isLoadMore) {
      Loaders.circularHideLoader(context);
      isLoading = false;
    } else {
      isLoadingMore = false;
    }

    notifyListeners();
  }

//add to cart
  Future<void> addToCart(BuildContext context, String supplyId,
      String supplyVariantId, int quantity) async {
    final variables = {
      "supply_carts": {
        "supply_id": supplyId,
        "supply_variant_id": supplyVariantId,
        "quantity": quantity,
      }
    };

    print("Add to cart variables: $variables");
    final res = await repo.addToCart(variables);
  }

  Future<void> getSuppliesDetails(BuildContext context, String supplyId) async {
    Loaders.circularShowLoader(context);

    final variables = {"id": supplyId};

    final res = await repo.getSuppliesDetails(variables);
    suppliesDetailsData = res.supplies?.firstOrNull;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> getSuppliesCart(BuildContext context) async {
    Loaders.circularShowLoader(context);

    final res = await repo.getSupplyCarts();
    suppliesCartData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> getDentalProfessionalAddress(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final res = await repo.dentalProfessionalAddress();
    dentalProfessionalAddress = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> addAddress(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final variables = {
      "dental_professional_addressees": {
        "type": addressType,
        "other_type_name": otherTypeController.text,
        "short_name": nameController.text,
        "line_1": addressline1Controller.text,
        "line_2": addressline2Controller.text,
        "landmark": landmarkController.text,
        "city": cityController.text,
        "state": selectedState,
        "country": selectedCountry,
        "postal_code": postcodeController.text,
        "latitude": 0,
        "longitude": 0,
        "google_place_id": "PLACE_ID123",
        "make_default": true
      }
    };

    final res = await repo.addAddress(variables);
    getDentalProfessionalAddress(context);
    navigationService.goBack();
    clearAddressFields();
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  clearAddressFields() {
    locationController.clear();
    otherTypeController.clear();
    nameController.clear();
    addressline1Controller.clear();
    addressline2Controller.clear();
    landmarkController.clear();
    cityController.clear();
    companyNameController.clear();
    postcodeController.clear();
    compNameController.clear();
    compCompanyNameController.clear();
    accountNumberController.clear();
    emailController.clear();

    selectedState = "";
    selectedCountry = "";
  }

  SupplyCarts? getCartItemBySupplyId(String supplyId) {
    return suppliesCartData?.supplyCarts?.cast<SupplyCarts?>().firstWhere(
          (item) => item?.supplyId == supplyId,
          orElse: () => null,
        );
  }

  Future<void> increaseQuantityById(
      BuildContext context, String id, int amount) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id, "amount": amount};

    final res = await repo.increaseQuantityById(variables);
    await getSuppliesCart(context);
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> decreaseQuantityById(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};

    final res = await repo.decreaseQuantityById(variables);
    await getSuppliesCart(context);
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> deleteCartItem(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    print("****************$variables");

    final res = await repo.deleteCartItem(variables);
    await getSuppliesCart(context);
    navigationService.goBack();
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  double get selectedProductsTotalPrice {
    final cartItems = suppliesCartData?.supplyCarts ?? [];

    double total = 0;

    for (final item in cartItems) {
      final isSelected = _selectedProducts[item.id] ?? false;

      if (isSelected) {
        final price = item.supplyVariant?.sellingPrice ?? 0;
        final quantity = item.quantity ?? 0;

        total += price * quantity;
      }
    }

    return total;
  }

  List<String> filterStates = [
    "Australian Capital Territory",
    "New South Wales",
    "Northern Territory",
    "Queensland",
    "South Australia",
    "Western Australia",
    "Victoria",
  ];

  List<String> filterCountry = [
    "Australia",
  ];

  String selectedState = "";
  void setSelectedState(String value) {
    selectedState = value;
    notifyListeners();
  }

  String selectedCountry = "";
  void setSelectedCountry(String value) {
    selectedCountry = value;
    notifyListeners();
  }

  String? selectedAddressId;

  DentalProfessionalAddresses? get selectedAddress {
    final addresses = dentalProfessionalAddress?.dentalProfessionalAddresses;

    if (addresses == null || addresses.isEmpty) {
      return null;
    }

    if (selectedAddressId == null) {
      return addresses.first;
    }

    for (final address in addresses) {
      if (address.id == selectedAddressId) {
        return address;
      }
    }

    return addresses.first;
  }

  void setSelectedAddress(String addressId) {
    selectedAddressId = addressId;
    notifyListeners();
  }

  checkPaymentDetails() {
    if (compNameController.text.isEmpty ||
        compCompanyNameController.text.isEmpty ||
        accountNumberController.text.isEmpty ||
        emailController.text.isEmpty) {
      return scaffoldMessenger("Please fill all the payment details");
    }
    return true;
  }

  AccountData? accountTowardsSupplier;

  Future<void> getAccountTowardsSupplier(
      BuildContext context, String supplierId, String companyName) async {
    final email = await LocalStorage.getStringVal(LocalStorageConst.emailId);
    Loaders.circularShowLoader(context);
    final variables = {"supplier_id": supplierId};
    print("****getAccountTowardsSupplier************$variables");

    final res = await repo.getAccountTowardsSupplier(variables);
    if (res.supplierAccounts?.isEmpty == true) {
      scaffoldMessenger("No account found for this supplier");
      Loaders.circularHideLoader(context);
    } else {
      accountTowardsSupplier = res;
      compNameController.text = accountTowardsSupplier
              ?.supplierAccounts?.first.dentalProfessional?.name ??
          "";
      compCompanyNameController.text = companyName;
      accountNumberController.text =
          accountTowardsSupplier?.supplierAccounts?.first.accountNumber ?? "";
      emailController.text = email;

      navigationService.goBack();
      Loaders.circularHideLoader(context);

      notifyListeners();
    }
  }
}
