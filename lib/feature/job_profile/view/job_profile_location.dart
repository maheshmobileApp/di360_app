import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
const googleApiKey = "AIzaSyCN0aBdq3Yw6y7w7aBRb3uzLLGx3Zk7G70";
class JobProfileLocation extends StatelessWidget  with BaseContextHelpers{
  const JobProfileLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileCreateViewModel>(context);
     return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Job Location"),
           addVertical(16),
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
                addVertical(10),
                GooglePlaceAutoCompleteTextField(
                  textEditingController: jobProfileVM.locationController,
                  googleAPIKey: "AIzaSyCN0aBdq3Yw6y7w7aBRb3uzLLGx3Zk7G70",
                  inputDecoration: InputDecoration(),
                  debounceTime: 800, 
                  isLatLngRequired:
                      true, 
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                  }, 
                  itemClick: (Prediction prediction) async {
                    final placeId = prediction.placeId;
                    if (placeId != null) {
                      await getPlaceDetails(placeId,  jobProfileVM);
                    }
                  },
                  itemBuilder: (context, index, Prediction prediction) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                         addHorizontal(7),
                          Expanded(
                              child: Text("${prediction.description ?? ""}"))
                        ],
                      ),
                    );
                  },
                  seperatedBuilder: Divider(),
                  isCrossBtnShown: true,
                  containerHorizontalPadding: 10,
                  placeType: PlaceType.geocode,
                ),
              ],
            ),
          addVertical(16),
            InputTextField(
              controller:  jobProfileVM.countryController,
              hintText: "Enter country",
              title: "Country",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter country'
                  : null,
            ),
            addVertical(16),
            InputTextField(
              controller:  jobProfileVM.stateController,
              hintText: "Enter state",
              title: "State",
              isRequired: true,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter state' : null,
            ),
           addVertical(16),
            InputTextField(
              controller:  jobProfileVM.cityPostCodeController,
              hintText: "Enter city / Post code",
              title: "City / Post Code",
               keyboardType: TextInputType.number,
                inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ),
      ),
    );
  }



Future<void> getPlaceDetails(
      String placeId, JobProfileCreateViewModel jobProfileVM) async {
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
          jobProfileVM.locationController.text =
              result["formatted_address"] ?? "";
          jobProfileVM.countryController.text = country ?? "";
         jobProfileVM.stateController.text = state ?? "";
          jobProfileVM.cityPostCodeController.text = postalCode ?? "";
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


}
