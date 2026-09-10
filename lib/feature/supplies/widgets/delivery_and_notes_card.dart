import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/supplies/model/dental_professional_address_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/address_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryAndNotesCard extends StatelessWidget {
  final DentalProfessionalAddressesData? address;
  const DeliveryAndNotesCard({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    final address =
        vm.dentalProfessionalAddress?.dentalProfessionalAddresses?.first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery & Notes',
                      style: TextStyles.clashSemiBold(fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigationService
                              .navigateTo(RouteList.addNewsAddressView);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                "+ Add New Address",
                                style: TextStyles.medium2(),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  AddressCard(
                    title: address?.shortName,
                    line1: address?.line1,
                    line2: address?.line2,
                    city: address?.city,
                    state: address?.state,
                    postalCode: address?.postalCode,
                    country: address?.country,
                  )
                ]),
          )),
    );
  }
}
