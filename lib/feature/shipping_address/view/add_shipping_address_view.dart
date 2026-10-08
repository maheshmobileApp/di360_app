import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/shipping_address/view_model/shipping_address_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/address_type_radio_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

class AddShippingAddressView extends StatelessWidget with ValidationMixins {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ShippingAddressViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            vm.editMode ? "Edit Shipping Address" : "Add Shipping Address",
            style: TextStyles.medium2(),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressTypeRadioWidget(
                selectedAddressType: vm.addressType,
                onChanged: vm.setAddressType,
              ),
              if (vm.addressType == "Other")
                InputTextField(
                  controller: vm.otherTypeController,
                  hintText: "Enter other type",
                  keyboardType: TextInputType.name,
                  title: "Other Type",
                  maxLength: 70,
                  isRequired: true,
                ),
              SizedBox(height: 6),
              Text(
                "CONTACT DETAILS",
                textAlign: TextAlign.start,
                style: TextStyles.clashSemiBold(
                    fontSize: 16, color: AppColors.primaryColor),
              ),
              InputTextField(
                controller: vm.practiceNameController,
                hintText: "Enter practice name",
                keyboardType: TextInputType.name,
                title: "Practice Name",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.nameController,
                hintText: "Enter contact name",
                keyboardType: TextInputType.name,
                title: "Contact Name",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.emailController,
                hintText: "Enter email",
                keyboardType: TextInputType.emailAddress,
                title: "Email",
                maxLength: 70,
                validator: validateEmail,
                isRequired: true,
              ),
              SizedBox(height: 6),
              Text(
                "LOCATION",
                textAlign: TextAlign.start,
                style: TextStyles.clashSemiBold(
                    fontSize: 16, color: AppColors.primaryColor),
              ),
              SizedBox(height: 6),
              /*InputTextField(
                controller: vm.locationController,
                hintText: "Enter location",
                keyboardType: TextInputType.name,
                title: "Location",
                maxLength: 70,
                isRequired: true,
              ),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Location',
                        style: TextStyles.regular3(color: AppColors.black),
                      ),
                      Text(
                        ' *',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: vm.locationController,
                    googleAPIKey: ApiConst.staticGoogleAPIKey,
                    inputDecoration: InputDecoration(
                      hintText: "Search Location",
                      hintStyle:
                          TextStyles.regular4(color: AppColors.dropDownHint),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      isDense: true,
                    ),
                    debounceTime: 800, // default 600 ms,
                    // countries: ["in", "fr"], // optional by default null is set
                    isLatLngRequired:
                        true, // if you required coordinates from place detail
                    getPlaceDetailWithLatLng: (Prediction
                        prediction) {}, // this callback is called when isLatLngRequired is true
                    itemClick: (Prediction prediction) async {
                      final placeId = prediction.placeId;
                      if (placeId != null) {
                        await getPlaceDetails(placeId, vm);
                      }
                    },
                    // if we want to make custom list item builder
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        color: AppColors.whiteColor,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                                child: Text("${prediction.description ?? ""}"))
                          ],
                        ),
                      );
                    },
                    // want to show close icon
                    isCrossBtnShown: true,
                    // optional container padding
                    containerHorizontalPadding: 10,
                    // place type
                    placeType: PlaceType.geocode,
                    // keyboard type (defaults to TextInputType.streetAddress)
                    // keyboardType: TextInputType.text, // optional - defaults to streetAddress for better address input
                  ),
                ],
              ),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.addressline1Controller,
                hintText: "Enter address line 1",
                keyboardType: TextInputType.name,
                title: "Address Line 1",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.addressline2Controller,
                hintText: "Enter address line 2",
                keyboardType: TextInputType.name,
                title: "Address Line 2",
                maxLength: 70,
                isRequired: false,
              ),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.landmarkController,
                hintText: "Enter Landmark",
                keyboardType: TextInputType.name,
                title: "Landmark",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.cityController,
                hintText: "Enter city",
                keyboardType: TextInputType.name,
                title: "City",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 6),
              _buildStates(vm),
              SizedBox(height: 6),
              _buildCountry(vm),
              SizedBox(height: 6),
              InputTextField(
                controller: vm.postcodeController,
                hintText: "Enter pincode",
                keyboardType: TextInputType.name,
                title: "Pincode",
                maxLength: 70,
                isRequired: true,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      text: 'Cancel',
                      height: 40,
                      backgroundColor: AppColors.timeBgColor,
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        navigationService.goBack();
                        vm.clearControllers();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppButton(
                        borderRadius: 30,
                        height: 40,
                        title: "Save",
                        onPressed: () async {
                          vm.editMode
                              ? await vm.updateShippingAddress(
                                  context, vm.editId)
                              : await vm.addShippingAddress(context);
                        }),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  Widget _buildStates(ShippingAddressViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueStates = viewModel.filterStates.toSet().toList();

    return CustomDropDown(
      value: uniqueStates.contains(viewModel.selectedState)
          ? viewModel.selectedState
          : null,
      title: "Select State",
      onChanged: (v) {
        viewModel.setSelectedState(v as String);
      },
      items: uniqueStates.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select State",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select state'
          : null,
    );
  }

  Future<void> getPlaceDetails(
      String placeId, ShippingAddressViewModel vm) async {
    final String apiKey = ApiConst.staticGoogleAPIKey;
    ;
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["status"] == "OK") {
          final result = data["result"];
          print("**************$result");

          String? city;
          String? state;
          String? country;
          String? postalCode;
          String? landmark;
          double? lat;
          double? lng;

          for (var component in result["address_components"]) {
            var types = component["types"] as List;
            if (types.contains("locality")) {
              city = component["long_name"];
            } else if (types.contains("administrative_area_level_1")) {
              state = component["long_name"];
            } else if (types.contains("country")) {
              country = component["long_name"];
            } else if (types.contains("postal_code")) {
              postalCode = component["long_name"];
            }
          }
          lat = result["geometry"]["location"]["lat"];
          lng = result["geometry"]["location"]["lng"];
          vm.locationController.text = result["formatted_address"] ?? "";
          vm.countryController.text = country ?? "";
          vm.stateController.text = state ?? "";
          vm.postcodeController.text = postalCode ?? "";
          vm.cityController.text = city ?? "";
          vm.landmarkController.text = landmark ?? "";
          vm.longitude = lng ?? 0.0;
          vm.latitude = lat ?? 0.0;
        } else {}
      }
    } catch (e) {}
  }

  Widget _buildCountry(ShippingAddressViewModel viewModel) {
    // Remove duplicates from contactTypes
    final uniqueCountry = viewModel.filterCountry.toSet().toList();

    return CustomDropDown(
      value: uniqueCountry.contains(viewModel.selectedCountry)
          ? viewModel.selectedCountry
          : null,
      title: "Select Country",
      onChanged: (v) {
        viewModel.setSelectedCountry(v as String);
      },
      items: uniqueCountry.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Country",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select country'
          : null,
    );
  }
}
