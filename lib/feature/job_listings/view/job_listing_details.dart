import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
//import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class JobListingDetailsScreen extends StatelessWidget with BaseContextHelpers {
  final Jobs job;
  const JobListingDetailsScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            iconTheme: const IconThemeData(color: AppColors.black),
            flexibleSpace: FlexibleSpaceBar(
              background: job.bannerImage != null 
                  ? CachedNetworkImageWidget(
                      imageUrl:job.bannerImage!.url!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.image, size: 80)),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildBody(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: job.logo != null && job.logo!.isNotEmpty
                  ? CachedNetworkImageWidget(
                      imageUrl: job.logo!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.business, color: Colors.white),
                    ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.companyName ?? '',
                    style: TextStyles.medium3(color: AppColors.black)),
                const SizedBox(height: 4),
                Text(job.jRole ?? '',
                    style: TextStyles.regular2(
                        color: AppColors.bottomNavUnSelectedColor)),
              ],
            ),
            const Spacer(),
            Text(Jiffy.parse(job.createdAt ?? '').fromNow(),
                style: TextStyles.medium1(
                    color: AppColors.primaryColor, fontSize: 12)),
          ],
        ),

        const SizedBox(height: 16),

        jobInfoItem(ImageConst.briefcaseSvg,
            '${job.yearsOfExperience ?? ''} Yrs Experience'),
        const SizedBox(height: 12),
        jobInfoItem(ImageConst.briefcurrencySvg,
            '${job.payMin ?? 0} - ${job.payMax ?? 0}'),

        const Divider(height: 30),

        _sectionHeader('Job Description'),
        _sectionText(job.description ?? ''),

        const Divider(height: 30),

        _sectionHeader('Job Location'),
        Text(job.location ?? '',
            style: TextStyles.regular2(color: AppColors.secondaryColor)),
        const SizedBox(height: 10),
        locationView(context),
        const Divider(height: 30),
        _sectionHeader('Gallery'),
        if (job.clinicLogo != null && job.clinicLogo!.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: job.clinicLogo!.length,
              itemBuilder: (context, index) {
                final logo = job.clinicLogo![index];
                return GestureDetector(
                  onTap: () => _openGallery(context, index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: CachedNetworkImageWidget(
                      imageUrl: logo.url ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
        else
          Text('No images available',
              style: TextStyles.regular2(color: Colors.grey)),

        const Divider(height: 30),

        _sectionHeader('Social Media Handles'),
      ],
    );
  }

  /// ✅ Location map preview
  Widget locationView(BuildContext context) {
    return GestureDetector(
      onTap: () => _openLocationInMaps(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(ImageConst.mapsPng,
            width: double.infinity, height: 180, fit: BoxFit.cover),
      ),
    );
  }

  Future<void> _openGallery(BuildContext context, int index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CachedNetworkImageWidget(
              imageUrl: job.clinicLogo![index].url ?? '',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openLocationInMaps(BuildContext context) async {
    if (job.location == null || job.location!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location not available')),
      );
      return;
    }
    final location = Uri.encodeComponent(job.location!);
    final googleMapsUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$location');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    }
  }

  Widget jobInfoItem(String svgPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(svgPath, width: 20, height: 20),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _sectionHeader(String title) => Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8),
        child: Text(title, style: TextStyles.medium3(color: AppColors.black)),
      );

  Widget _sectionText(String text) =>
      Text(text, style: TextStyles.regular2(color: AppColors.lightGeryColor));
}
