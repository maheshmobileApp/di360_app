import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/supplies/model/dental_professional_address_res.dart';
import 'package:di360_flutter/feature/supplies/model/favourites_keys_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_account_towards_supplier_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/model/supplier_account_res.dart';
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
  List<DentalProfessionalAddresses>? dentalProfessionalAddress;

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
  final contactPersonController = TextEditingController();
  final phoneController = TextEditingController();
  final abnController = TextEditingController();
  final billingAddressController = TextEditingController();
  final notesController = TextEditingController();

  FavouritesKeysData? favouritesKeysData;

  String? addressType;
  String selectedType = "";
  String accountPayType = "";
  String billingType = "NEW";

  void setAccountPayType(String value) {
    accountPayType = value;
    notifyListeners();
  }

  void setBillingType(String value) {
    billingType = value;
    notifyListeners();
  }

  String shippingMethod = "standard";

  void setShippingMethod(String value) {
    shippingMethod = value;
    notifyListeners();
  }

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

  int totalAvailableOptionPrice = 0;

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
    Loaders.circularShowLoader(context);

    final variables = {
      "supply_carts": {
        "supply_id": supplyId,
        "supply_variant_id": supplyVariantId,
        "quantity": quantity,
      }
    };

    print("Add to cart variables: $variables");
    final res = await repo.addToCart(variables);
    Loaders.circularHideLoader(context);
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
    await getDentalProfessionalAddress(context);
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

  Future<void> increaseQuantityById(BuildContext context, String id, int amount,
      {bool showLoader = true, bool refreshCart = true}) async {
    if (showLoader) {
      Loaders.circularShowLoader(context);
    }
    final variables = {"id": id, "amount": amount};

    await repo.increaseQuantityById(variables);
    if (refreshCart) {
      suppliesCartData = await repo.getSupplyCarts();
    }
    if (showLoader) {
      Loaders.circularHideLoader(context);
    }

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

  Future<void> addMultipleProductsToCart(
    BuildContext context,
    String supplyId,
    List<SupplyVariants> variants,
  ) async {
    final selectedVariants = variants.where((variant) {
      return variant.id != null &&
          variant.id!.isNotEmpty &&
          getQuantity(variant.id!) > 0;
    }).toList();

    if (supplyId.isEmpty || selectedVariants.isEmpty) {
      scaffoldMessenger("Select a quantity for at least one option");
      return;
    }

    Loaders.circularShowLoader(context);
    try {
      suppliesCartData = await repo.getSupplyCarts();
      final existingCartItems = {
        for (final item in suppliesCartData?.supplyCarts ?? [])
          if (item.supplyId == supplyId &&
              item.supplyVariantId != null &&
              item.id != null)
            item.supplyVariantId!: item,
      };
      final newObjects = <Map<String, Object>>[];

      for (final variant in selectedVariants) {
        final variantId = variant.id!;
        final quantity = getQuantity(variantId);
        final existingCartItem = existingCartItems[variantId];

        if (existingCartItem?.id != null) {
          await increaseQuantityById(
            context,
            existingCartItem!.id!,
            quantity,
            showLoader: false,
            refreshCart: false,
          );
        } else {
          newObjects.add({
            "supply_id": supplyId,
            "supply_variant_id": variantId,
            "quantity": quantity,
          });
        }
      }

      if (newObjects.isNotEmpty) {
        await repo.addMultipleProductsToCart({"objects": newObjects});
      }
      suppliesCartData = await repo.getSupplyCarts();
      navigationService.goBack();
    } finally {
      Loaders.circularHideLoader(context);
    }

    notifyListeners();
  }

  double get selectedProductsTotalPrice {
    final cartItems = suppliesCartData?.supplyCarts ?? [];

    double total = 0;

    for (final item in cartItems) {
      final isSelected = _selectedProducts[item.id] ?? false;

      if (isSelected) {
        final price = item.supplyVariant?.calaculatedPrice ?? 0;
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

  DentalProfessionalAddresses? get selectedProfessionalAddress  {
    final addresses = dentalProfessionalAddress;

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

  bool checkAddressDetails() {
    if (selectedProfessionalAddress == null) {
      scaffoldMessenger("Please select address");
      return false;
    }
    return true;
  }

  bool checkPaymentDetails() {
    return accountPayType == "yes" || billingType == "EXISTING"
        ? checkAccountPayDetails()
        : checkPaymentDetailsFields();
  }

  bool checkAccountPayDetails() {
    if (compNameController.text.trim().isEmpty ||
        compCompanyNameController.text.trim().isEmpty ||
        accountNumberController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      scaffoldMessenger("Please enter payment details");
      return false;
    }

    return true;
  }

  bool checkPaymentDetailsFields() {
    if (contactPersonController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      scaffoldMessenger("Please enter payment details");
      return false;
    }

    return true;
  }

  AccountData? accountTowardsSupplier;

  Future<void> getAccountTowardsSupplier(
      BuildContext context, String supplierId, String companyName) async {
    final email = await LocalStorage.getStringVal(LocalStorageConst.emailId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    Loaders.circularShowLoader(context);
    final variables = {"supplier_id": supplierId};
    print("****getAccountTowardsSupplier************$variables");

    final res = await repo.getAccountTowardsSupplier(variables);
    if (res.supplierAccounts?.isEmpty == true) {
      scaffoldMessenger("No account found for this supplier");
      setBillingType("NEW");
      Loaders.circularHideLoader(context);
    } else {
      setBillingType("EXISTING");
      accountTowardsSupplier = res;
      accountNumberController.text =
          accountTowardsSupplier?.supplierAccounts?.first.accountNumber ?? "";

      navigationService.goBack();
      Loaders.circularHideLoader(context);

      notifyListeners();
    }
    compCompanyNameController.text = companyName;
    emailController.text = email;
    compNameController.text = name;
  }

  Future<void> addFavourites(
      String supplyId, String supplyVariantId, BuildContext context) async {
    Loaders.circularShowLoader(context);

    final variables = {
      "supply_favorites": {
        "supply_id": supplyId,
        "supply_variant_id": supplyVariantId
      }
    };
    final res = await repo.addFavourite(variables);
    await getFavouriteKeys();
    Loaders.circularHideLoader(context);

    if (res != null) {
      scaffoldMessenger("Added to Favourites");
    }
  }

  Future<void> deleteFavourites(
      String supplyId, String supplyVariantId, BuildContext context) async {
    Loaders.circularShowLoader(context);
    final variables = {
      "supplyId": supplyId,
      "supplyVariantId": supplyVariantId
    };
    final res = await repo.deleteFavourite(variables);
    await getFavouriteKeys();
    Loaders.circularHideLoader(context);

    if (res != null) {
      scaffoldMessenger("Removed from Favourites");
    }
  }

  Future<void> getFavouriteKeys() async {
    final variables = {};
    final res = await repo.getFavouritesKeys(variables);

    if (res != null) {
      favouritesKeysData = res;
      notifyListeners();
    }
  }

  SupplierAccountData? supplierAccountData;

  Future<void> addSupplierAccountRequest(BuildContext context) async {
    Loaders.circularShowLoader(context);
    print("*********addSupplierAccount**********");

    final cartItem = suppliesCartData?.supplyCarts?.firstWhere(
      (item) => _selectedProducts[item.id] ?? false,
      orElse: () => SupplyCarts(),
    );
    final supplierId = cartItem?.supply?.dentalSuppliersId ?? "";
    final variables = {
      "supplier_account_request": {
        "supplier_id": supplierId,
        "practice_name": null,
        "name": contactPersonController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "abn_number": abnController.text,
        "billing_address": billingAddressController.text,
        "notes": notesController.text,
        "status": "PENDING"
      }
    };
    final res = await repo.addSupplierAccountRequest(variables);

    if (res != null) {
      supplierAccountData = res;
      Loaders.circularHideLoader(context);

      notifyListeners();
    }
  }

  Future<void> addSupplierAccount(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final cartItem = suppliesCartData?.supplyCarts?.firstWhere(
      (item) => _selectedProducts[item.id] ?? false,
      orElse: () => SupplyCarts(),
    );
    final supplierId = cartItem?.supply?.dentalSuppliersId ?? "";
    final variables = {
      "supplier_account": {
        "supplier_id": supplierId,
        "account_number": accountNumberController.text,
        "dental_professional_id": userId
      }
    };
    final res = await repo.addSupplierAccount(variables);

    if (res != null) {
      supplierAccountData = res;
      print("*******------$supplierAccountData");
      Loaders.circularHideLoader(context);

      notifyListeners();
    }
  }

  Future<bool> addOrder(BuildContext context) async {
    final email = await LocalStorage.getStringVal(LocalStorageConst.emailId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    Loaders.circularShowLoader(context);
    try {
      print("*********add Order**********");

      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      final userType = await LocalStorage.getStringVal(LocalStorageConst.type);
      final cartItem = suppliesCartData?.supplyCarts?.firstWhere(
        (item) => _selectedProducts[item.id] ?? false,
        orElse: () => SupplyCarts(),
      );

      final subTotal = cartItem?.supplyVariant?.calaculatedPrice ??
          0 * (cartItem?.quantity ?? 0);
      final totalAmount = subTotal + (shippingMethod == "standard" ? 15 : 25);

      final suppliesOrderItems = [
        for (final cartItem in suppliesCartData?.supplyCarts ?? [])
          if (_selectedProducts[cartItem.id] ?? false)
            {
              "supply_id": cartItem.supplyId,
              "supply_variant_id": cartItem.supplyVariantId,
              "price": cartItem.supply.priceType == "inclusive"
                  ? cartItem.supplyVariant?.sellingPrice ?? 0
                  : cartItem.supplyVariant?.calaculatedPrice ?? 0,
              "quantity": cartItem.quantity ?? 0,
              "free_quantity": 0
            }
      ];
      final variables = {
        "supplies_orders": {
          "suppliers_id": cartItem?.supply?.dentalSuppliersId ?? "",
          "coupon_discount": 0,
          "sub_total": subTotal,
          "total_amount": totalAmount,
          "tax_amount": 0,
          "tax_percentage": 0,
          "delivery_charge": shippingMethod == "standard" ? 15 : 25,
          "shipping_method":
              shippingMethod == "standard" ? "STANDARD" : "EXPRESS",
          "estimated_delivery_in_days": 0,
          "status": "VERIFICATION_PENDING",
          "payment_status": "PENDING",
          "payment_mode": "ACCOUNT_PAY",
          "billing_address": selectedProfessionalAddress,
          "shipping_address": selectedProfessionalAddress,
          "order_notes": "",
          "requested_delivery_date": null,
          "role": userType,
          "user_id": userId,
          "supplies_order_items": suppliesOrderItems,
          "billing_type": billingType,
          "account_pay_details": billingType == "EXISTING"
              ? {
                  "payment_mode": "ACCOUNT_PAY",
                  "clinic_name": compNameController.text,
                  "company_name": compCompanyNameController.text,
                  "account_number": accountNumberController.text,
                  "email": emailController.text,
                  "new_practice_name": null,
                  "new_contact_person": null,
                  "new_phone": null,
                  "new_abn": null,
                  "new_billing_address": null,
                  "new_notes": null
                }
              : null,
          if (billingType == "NEW")
            "supplier_account_request_id":
                supplierAccountData?.insertSupplierAccountRequestsOne?.id ?? ""
        }
      };
      print("/////********$variables");
      final res = await repo.addOrder(variables);
      return res != null;
    } finally {
      Loaders.circularHideLoader(context);
    }
  }

  bool checkFavouriteKey(String id) {
    return favouritesKeysData?.supplyFavorites
            ?.any((item) => item.supplyId?.toString() == id) ??
        false;
  }
}
