import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeatureButtonsWidget extends StatelessWidget {
  final String? communityMemberDirectorId;
  const FeatureButtonsWidget({super.key, this.communityMemberDirectorId});

  @override
  Widget build(BuildContext context) {
    final directoryVM = Provider.of<DirectoryViewModel>(context);
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ConstantData.featureStatus.length,
        itemBuilder: (context, index) {
          String status = ConstantData.featureStatus[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 2),
            child: AppButton(
                btnColor: AppColors.whiteColor,
                btnTextColor: AppColors.black,
                text: status,
                height: 45,
                width: 130,
                radius: 8,
                onTap: () async {
                  if (index == 0 || index == 1 || index == 2) {
                    Loaders.circularShowLoader(context);
                    await directoryVM.GetDirectorDetails(
                        communityMemberDirectorId ?? '');
                    Loaders.circularHideLoader(context);
                    final scrollTo = index == 1
                        ? 'Partner'
                        : index == 2
                            ? 'Contact Us'
                            : null;
                    await navigationService.navigateToWithParams(
                        RouteList.directoryDetailsScreen,
                        params: scrollTo);
                  } else if (index == 3) {
                  } else if (index == 4) {}
                }),
          );
        },
      ),
    );
  }
}
