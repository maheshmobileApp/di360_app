import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/shipping_address/model/get_shipping_addresses_professional_res.dart';
import 'package:di360_flutter/feature/shipping_address/repository/shipping_address_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class ShippingAddressViewModel extends ChangeNotifier {
  final ShippingAddressRepoImpl repo = ShippingAddressRepoImpl();

  List<DentalProfessionalAddresses>? shippingAddressesProfessionalData;
  static const int _addressPageSize = 10;
  int _addressOffset = 0;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  String? addressType;
  dynamic? latitude;
  dynamic? longitude;

  bool editMode = false;
  String editId = "";

  final otherTypeController = TextEditingController();
  final locationController = TextEditingController();
  final nameController = TextEditingController();
  final practiceNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressline1Controller = TextEditingController();
  final addressline2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postcodeController = TextEditingController();

  void setAddressType(String value) {
    addressType = value;
    notifyListeners();
  }

  void setEditId(String value) {
    editId = value;
    notifyListeners();
  }

  void setEditMode(bool value) {
    editMode = value;
    notifyListeners();
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

  Future<void> getShippingAddressesProfessional(
    BuildContext context, {
    bool isLoadMore = false,
  }) async {
    if (isLoading || isLoadingMore || (isLoadMore && !hasMoreData)) return;

    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isLoading = true;
      _addressOffset = 0;
      hasMoreData = true;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();

    try {
      final variables = {
        "search": "%%",
        "limit": _addressPageSize,
        "offset": _addressOffset,
      };
      final res = await repo.getShippingAddressesProfessional(variables);
      final newAddresses = res;

      if (isLoadMore) {
        shippingAddressesProfessionalData?.addAll(newAddresses);
      } else {
        shippingAddressesProfessionalData = res;
      }

      _addressOffset += newAddresses.length;
      hasMoreData = newAddresses.length == _addressPageSize;
    } catch (error) {
      scaffoldMessenger('Unable to load shipping addresses');
    } finally {
      if (isLoadMore) {
        isLoadingMore = false;
      } else {
        isLoading = false;
        Loaders.circularHideLoader(context);
      }
      notifyListeners();
    }
  }

  Future<void> deleteShippingAddress(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    final res = await repo.deleteShippingAddressProfessional(variables);
    await getShippingAddressesProfessional(context);
    navigationService.goBack();
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<bool> checkValidFields() async {
    final requiredFields = <String, String>{
      'address type': addressType ?? '',
      if (addressType == 'Other') 'other type': otherTypeController.text,
      'contact name': nameController.text,
      'email': emailController.text,
      'address line 1': addressline1Controller.text,
      'landmark': landmarkController.text,
      'city': cityController.text,
      'state': selectedState,
      'country': selectedCountry,
      'postcode': postcodeController.text,
    };

    for (final field in requiredFields.entries) {
      if (field.value.trim().isEmpty) {
        scaffoldMessenger('Please enter ${field.key}');
        return false;
      }
    }

    return true;
  }

  Future<void> addShippingAddress(BuildContext context) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (!await checkValidFields()) return;

    Loaders.circularShowLoader(context);
    final variables = type == UserRole.professional.value
        ? {
            "dental_professional_addressees": {
              "type": addressType,
              "other_type_name": otherTypeController.text,
              "email": emailController.text,
              "short_name": nameController.text,
              "line_1": addressline1Controller.text,
              "line_2": addressline2Controller.text,
              "landmark": landmarkController.text,
              "city": cityController.text,
              "state": selectedState,
              "country": selectedCountry,
              "postal_code": postcodeController.text,
              "latitude": latitude,
              "longitude": longitude,
              "google_place_id":
                  "EjNOU1cgQ29hc3RsaW5lIEN5Y2xld2F5LCBXb29ub25hIE5TVyAyNTE3LCBBdXN0cmFsaWEiLiosChQKEglb3g4Dpx8TaxFF2qfcB8lFghIUChIJ2cUq4eQeE2sRUOcyFmh9AQU",
              "make_default": true
            }
          }
        : {
            "dental_practice_addressees": {
              "type": addressType,
              "other_type_name": otherTypeController.text,
              "practice_name": practiceNameController.text,
              "email": emailController.text,
              "short_name": nameController.text,
              "line_1": addressline1Controller.text,
              "line_2": addressline2Controller.text,
              "landmark": landmarkController.text,
              "city": cityController.text,
              "state": selectedState,
              "country": selectedCountry,
              "postal_code": postcodeController.text,
              "latitude": latitude,
              "longitude": longitude,
              "google_place_id":
                  "EjNOU1cgQ29hc3RsaW5lIEN5Y2xld2F5LCBXb29ub25hIE5TVyAyNTE3LCBBdXN0cmFsaWEiLiosChQKEglb3g4Dpx8TaxFF2qfcB8lFghIUChIJ2cUq4eQeE2sRUOcyFmh9AQU",
              "make_default": true
            }
          };
    print("**************variables $variables");
    final res = await repo.addShippingAddress(variables);
    Loaders.circularHideLoader(context);

    await getShippingAddressesProfessional(context);
    navigationService.goBack();
    notifyListeners();
  }

  Future<void> updateShippingAddress(BuildContext context, String id) async {
    if (!await checkValidFields()) return;

    Loaders.circularShowLoader(context);
    final variables = {
      "id": id,
      "dental_professional_addresses": {
        "id": id,
        "type": addressType,
        "other_type_name": otherTypeController.text,
        "email": emailController.text,
        "short_name": nameController.text,
        "line_1": addressline1Controller.text,
        "line_2": addressline2Controller.text,
        "landmark": landmarkController.text,
        "city": cityController.text,
        "state": selectedState,
        "country": selectedCountry,
        "postal_code": postcodeController.text,
        "latitude": latitude,
        "longitude": longitude,
        "google_place_id":
            "EjNOU1cgQ29hc3RsaW5lIEN5Y2xld2F5LCBXb29ub25hIE5TVyAyNTE3LCBBdXN0cmFsaWEiLiosChQKEglb3g4Dpx8TaxFF2qfcB8lFghIUChIJ2cUq4eQeE2sRUOcyFmh9AQU",
        "make_default": true
      }
    };
    print("**************variables $variables");
    final res = await repo.updateShippingAddress(variables);
    setEditId("");
    setEditMode(false);
    Loaders.circularHideLoader(context);

    await getShippingAddressesProfessional(context);
    navigationService.goBack();
    notifyListeners();
  }

  clearControllers() {
    otherTypeController.clear();
    locationController.clear();
    nameController.clear();
    emailController.clear();
    addressline1Controller.clear();
    addressline2Controller.clear();
    landmarkController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
    postcodeController.clear();
    selectedCountry = "";
    selectedState = "";
    addressType = "";
  }

  fillController(DentalProfessionalAddresses address) {
    otherTypeController.text = address.otherTypeName ?? "";
    practiceNameController.text = address.practiceName ?? "";
    locationController.text = "";
    nameController.text = address.shortName ?? "";
    emailController.text = address.email ?? "";
    addressline1Controller.text = address.line1 ?? "";
    addressline2Controller.text = address.line2 ?? "";
    landmarkController.text = address.landmark ?? "";
    cityController.text = address.city ?? "";
    stateController.text = address.state ?? "";
    countryController.text = address.country ?? "";
    postcodeController.text = address.postalCode ?? "";
    selectedCountry = address.country ?? "";
    selectedState = address.state ?? "";
    addressType = address.type ?? "";
    latitude = address.latitude ?? 0.0;
    longitude = address.longitude ?? 0.0;
    notifyListeners();
  }
}
