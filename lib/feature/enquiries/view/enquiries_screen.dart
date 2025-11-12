import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/enquiries/view/enquiries_card.dart';
import 'package:di360_flutter/feature/enquiries/view_model/enquiries_view_model.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnquiriesScreen extends StatefulWidget {
  const EnquiriesScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    final vm = Provider.of<EnquiriesViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppbarTitleBackIconWidget(title: 'Enquiries'),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          itemCount: vm.enquiriesListData?.jobEnquiries?.length,
          itemBuilder: (_, index) {
            final job = vm.enquiriesListData?.jobEnquiries?[index];
            return Text(
                "Pending"); /*EnquiriesCard(
              appliedJob: job,
              index: index,
            );*/
          },
        ));
  }
}
