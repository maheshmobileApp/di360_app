import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddressAutoFillWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(Prediction)? getPlaceDetailWithLatLng;
  final Function(Prediction)? itemClick;
  final Color? borderColor;
  final double? borderRadius;
  const AddressAutoFillWidget(
      {super.key,
      required this.textEditingController,
      this.getPlaceDetailWithLatLng,
      this.itemClick,
      this.borderColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Address', style: TextStyles.regular3(color: AppColors.black)),
            Text(' *',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 10),
        GooglePlaceAutoCompleteTextField(
          textEditingController: textEditingController,
          googleAPIKey: "AIzaSyCN0aBdq3Yw6y7w7aBRb3uzLLGx3Zk7G70",
          inputDecoration: InputDecoration(
            hintText: "Search Address",
            hintStyle: TextStyles.regular4(color: AppColors.dropDownHint),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
          debounceTime: 800,
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: getPlaceDetailWithLatLng,
          itemClick: itemClick,
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 7),
                  Expanded(child: Text(prediction.description ?? ""))
                ],
              ),
            );
          },
          isCrossBtnShown: true,
          containerHorizontalPadding: 10,
        ),
      ],
    );
  }
}
