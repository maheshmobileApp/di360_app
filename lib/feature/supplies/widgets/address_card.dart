import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String? title;
  final String? line1;
  final String? line2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  const AddressCard({
    super.key,
    this.title,
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 4,
      ),
      elevation: 1,
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasValue(title))
              Text(
                title ?? "",
                style: TextStyles.bold3(),
              ),
            if (_hasValue(title)) const SizedBox(height: 8),
            if (_hasValue(line1)) _addressText(line1 ?? ""),
            if (_hasValue(line2)) _addressText(line2 ?? ""),
            if (_hasValue(city)) _addressText(city ?? ""),
            if (_hasCityStatePostal)
              _addressText(
                "$city, $state - $postalCode",
              ),
            if (_hasValue(country)) _addressText(country!),
          ],
        ),
      ),
    );
  }

  Widget _addressText(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        value,
        style: TextStyles.regular2(
          color: AppColors.black,
        ),
      ),
    );
  }

  bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  bool get _hasCityStatePostal {
    return _hasValue(city) && _hasValue(state) && _hasValue(postalCode);
  }
}
