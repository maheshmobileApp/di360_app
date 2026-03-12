import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddressAutoFillWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(Prediction)? getPlaceDetailWithLatLng;
  final Function(Prediction)? itemClick;

  const AddressAutoFillWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.getPlaceDetailWithLatLng,
    this.itemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Address',
              style: TextStyles.regular3(color: AppColors.black),
            ),
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          focusNode: focusNode,
          googleAPIKey: ApiConst.googleAPIKey,
          debounceTime: 600,
          inputDecoration: InputDecoration(
            hintText: "Search Address",
            hintStyle: TextStyles.regular4(color: AppColors.dropDownHint),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          ),
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: getPlaceDetailWithLatLng,
          itemClick: (Prediction prediction) {
            controller.text = prediction.description ?? "";
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
        
            if (itemClick != null) {
              itemClick!(prediction);
            }
        
            FocusScope.of(context).unfocus();
          },
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      prediction.description ?? "",
                      style: TextStyles.regular4(
                        color: AppColors.black,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          isCrossBtnShown: true,
          containerHorizontalPadding: 0,
        ),
      ],
    );
  }
}
