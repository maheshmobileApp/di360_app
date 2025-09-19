import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_seek/view/chip_view.dart';
import 'package:di360_flutter/feature/job_seek/view/job_details.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class JobListingDetailsScreen extends StatelessWidget with BaseContextHelpers {
  final JobsListingDetails job;
  const JobListingDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            backgroundColor: AppColors.whiteColor,
            iconTheme: const IconThemeData(color: AppColors.black),
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final isCollapsed =
                    top <= kToolbarHeight + MediaQuery.of(context).padding.top;
                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: isCollapsed
                      ? Text(
                          job.title ?? '',
                          style: TextStyles.medium2(color: AppColors.black),
                        )
                      : null,
                  background: CachedNetworkImageWidget(
                    imageUrl: job.logo ?? '',
                    width: double.infinity,
                  ),
                );
              },
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.whiteColor,
              padding: const EdgeInsets.all(16),
              child: _buildBodyContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.geryColor,
                  ),
                ),
                addHorizontal(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.companyName ?? '',
                      style: TextStyles.medium3(color: AppColors.black),
                    ),
                    addVertical(4),
                    Text(
                      job.jRole ?? '',
                      style: TextStyles.regular2(
                          color: AppColors.bottomNavUnSelectedColor),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.timeBgColor, AppColors.whiteColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                Jiffy.parse(job.createdAt ?? '').fromNow(),
                style: TextStyles.medium1(
                    color: AppColors.primaryColor, fontSize: 12),
              ),
            ),
          ],
        ),
        addVertical(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            jobInfoItem(ImageConst.briefcaseSvg,
                '${job.yearsOfExperience ?? 0} Yrs Experience'),
            const SizedBox(height: 12),
            jobInfoItem(ImageConst.briefcurrencySvg,
                '${job.payRange ?? 0} - ${job.payRange ?? 0}'),
          ],
        ),
        addVertical(12),
        Wrap(
          spacing: 1,
          runSpacing: 2,
          children: job.typeofEmployment
                  ?.map((type) => customFilterChip(type.toString()))
                  .toList() ??
              [],
        ),
        const Divider(height: 30),
        InfoItem(
          iconPath: ImageConst.graduationSvg,
          title: 'Education Level',
          subtitle: '${job.education}',
        ),
        const Divider(height: 30),
        _sectionHeader('Job Description'),
        _sectionText('${job.description ?? ''}'),
       addVertical(10),
        _sectionHeader('Key Responsibilities'),
        _sectionText('NA'),
       addVertical(10),
        _sectionHeader('About Company'),
        _sectionText('${job.companyName}'),
        addVertical(10),
        InkWell(
          onTap: () {},
          child: Text('${job.companyName ?? ''}',
              style: TextStyles.semiBold(
                color: AppColors.primaryColor,
              )),
        ),
       addVertical(20),
        _sectionHeader('Job Location'),
        Text('${job.location ?? ''}',
            style: TextStyles.regular2(color: AppColors.secondaryColor)),
        locationView(context),
        _sectionHeader('Gallery'),
        _sectionHeader('Social Media Handles'),
      ],
    );
  }

  Widget locationView(BuildContext context) {
    return GestureDetector(
      onTap: () => _openLocationInMaps(context),
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppColors.geryColor,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            ImageConst.mapsPng,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Future<void> _openLocationInMaps(BuildContext context) async {
    if (job.location == null || job.location!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location not available',
              style: TextStyles.regular1(color: AppColors.whiteColor)),
          backgroundColor: AppColors.redColor,
        ),
      );
      return;
    }

    final String location = Uri.encodeComponent(job.location!);
    final String googleMapsApp = 'google.navigation:q=$location';
    final String googleMapsWeb =
        'https://www.google.com/maps/search/?api=1&query=$location';
    try {
      final Uri appUri = Uri.parse(googleMapsApp);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}

    try {
      final Uri webUri = Uri.parse(googleMapsWeb);
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open maps application',
              style: TextStyles.regular1(color: AppColors.whiteColor)),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  Widget jobInfoItem(String svgPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
              AppColors.bottomNavUnSelectedColor, BlendMode.srcIn),
        ),
        addHorizontal(8),
        Expanded(
          child: Text(
            text,
            style:
                TextStyles.medium3(color: AppColors.bottomNavUnSelectedColor),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title, style: TextStyles.medium3(color: AppColors.black)),
    );
  }

  Widget _sectionText(String text) {
    return Text(text,
        style: TextStyles.regular2(color: AppColors.lightGeryColor));
  }
}
