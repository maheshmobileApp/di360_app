import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_respo.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class  EnquiriesCard extends StatelessWidget with BaseContextHelpers {
  final EnquiriesJob appliedJob;
  final int? index;

  const EnquiriesCard({
    super.key,
    required this.appliedJob,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final EnquiryJob? job = appliedJob.job;
    final String time = _getShortTime(job?.createdAt ?? '') ?? '';
    final String logoUrl = (job?.clinicLogo != null &&
            job!.clinicLogo!.isNotEmpty &&
            job.clinicLogo!.first.url != null)
        ? job.clinicLogo!.first.url!
        : '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromRGBO(220, 224, 228, 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    context,
                    logoUrl,
                    job?.companyName ?? '',
                   
                  ),
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                          _EnquiriesTimeChip(time),
                          addHorizontal(4),
                         _EnquiriesMenu(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            addVertical(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _chipWidget(job?.typeofEmployment ?? []),
                ),
              ],
            ),
            addVertical(10),
            _descriptionWidget(job?.description ?? ''),
            const Divider(),
            Row(
              children: [
                _roundedButton("Message"),
                addHorizontal(15),
                _roundedButton("Enquiry"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
      BuildContext context, String logo,  String company) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.geryColor,
          backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
          radius: 22,
          child: logo.isEmpty
              ? const Icon(Icons.business,
                  size: 20, color: AppColors.lightGeryColor)
              : null,
        ),
        addHorizontal(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVertical(2),
              Text(company,
                  style: TextStyles.regular3(
                      color: AppColors.black)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description.isNotEmpty ? description : "",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(
          color: AppColors.bottomNavUnSelectedColor,
        ),
      ),
    );
  }

  Widget _EnquiriesTimeChip(String time) {
    return Container(
      height: 19,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerRight,
      child: Text(
        time,
        textAlign: TextAlign.right,
        style: TextStyles.semiBold(
            fontSize: 10, color: Color.fromRGBO(255, 112, 0, 1)),
      ),
    );
  }

  
  Widget _chipWidget(List<String> types) {
    if (types.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types.map((type) {
        final label = type.trim().isEmpty ? '' : type;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(label,
              style: TextStyles.regular1(
                  fontSize: 12, color: AppColors.primaryBlueColor)),
        );
      }).toList(),
    );
  }

  Widget _roundedButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(label == "Message" ? Icons.chat : Icons.live_help_outlined,
              size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyles.medium1(
                  fontSize: 13, color: AppColors.primaryColor)),
        ],
      ),
    );
  }
    Widget _EnquiriesMenu() {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Preview") {
        navigationService.navigateToWithParams(
  RouteList. EnquiriesDetailsScreen,
  params: appliedJob, 
);

        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
      
      ],
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        addHorizontal(8),
        Text(title, style: TextStyles.semiBold(fontSize: 14, color: color)),
      ],
    );
  }

  String? _getShortTime(String createdAt) {
    try {
      if (createdAt.isEmpty) return null;
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return null;
    }
  }
}
