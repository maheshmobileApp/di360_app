import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

const googleApiKey = "AIzaSyCN0aBdq3Yw6y7w7aBRb3uzLLGx3Zk7G70";

class JobLocationView extends StatelessWidget with ValidationMixins {
  const JobLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Job Location"),
            const SizedBox(height: 16),
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
                  textEditingController: jobCreateVM.locationSearchController,
                  googleAPIKey: "AIzaSyCN0aBdq3Yw6y7w7aBRb3uzLLGx3Zk7G70",
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
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    // this method will return latlng with place detail
                    print("placeDetails" + prediction.lng.toString());
                  }, // this callback is called when isLatLngRequired is true
                  itemClick: (Prediction prediction) async {
                    final placeId = prediction.placeId;
                    if (placeId != null) {
                      await getPlaceDetails(placeId, jobCreateVM);
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
            const SizedBox(height: 10),
            // _buildCountryList(jobCreateVM),
            InputTextField(
              controller: jobCreateVM.countryController,
              hintText: "Enter country",
              title: "Country",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter country'
                  : null,
            ),
            const SizedBox(height: 10),
            InputTextField(
              controller: jobCreateVM.stateController,
              hintText: "Enter state",
              title: "State",
              isRequired: true,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter state' : null,
            ),
            const SizedBox(height: 10),
            InputTextField(
              controller: jobCreateVM.cityPostCodeController,
              hintText: "Enter city / Post code",
              title: "City / Post Code",
              maxLength: 4,
              isRequired: true,
              validator: validatePostalCode,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDetails(
      String placeId, JobCreateViewModel jobCreateVM) async {
    final String apiKey = googleApiKey;
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["status"] == "OK") {
          final result = data["result"];

          String? city;
          String? state;
          String? country;
          String? postalCode;
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
          jobCreateVM.locationSearchController.text =
              result["formatted_address"] ?? "";
          jobCreateVM.countryController.text = country ?? "";
          jobCreateVM.stateController.text = state ?? "";
          jobCreateVM.cityPostCodeController.text = postalCode ?? "";
          print("City: $city");
          print("State: $state");
          print("Country: $country");
          print("Postal Code: $postalCode");
          print("Latitude: $lat, Longitude: $lng");
        } else {
          print("Error: ${data["status"]}");
        }
      }
    } catch (e) {
      print("Dio error: $e");
    }
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildCountryList(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectCountry,
      title: "Country",
      onChanged: (v) {
        jobCreateVM.setSelectedCountry(v as String);
      },
      items:
          jobCreateVM.countryList.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Country",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select a country'
          : null,
    );
  }
}
