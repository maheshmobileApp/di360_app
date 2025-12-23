import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/job_seek/model/job_info_item.dart';
import 'package:di360_flutter/feature/job_seek/view/chip_view.dart';
import 'package:di360_flutter/feature/job_seek/view/enquiry_foam.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/custom_chip_view.dart';
import 'package:di360_flutter/widgets/gallary_view.dart';
import 'package:di360_flutter/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsScreen extends StatefulWidget {
  final Jobs job;
  const JobDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    getJobApplyStatus();
    super.initState();
  }

  void getJobApplyStatus() async {
    final provider = Provider.of<JobSeekViewModel>(context, listen: false);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    provider.getApplyJobStatus(widget.job.id ?? "", userId);
  }

  void _showEnquiryForm(BuildContext context,JobSeekViewModel provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          actions: [
            CustomRoundedButton(
              text: "Send",
              onPressed: () async {
                if (provider.enquiryData != null){
                   navigationService.goBack();
                await Provider.of<JobSeekViewModel>(context, listen: false)
                    .jobEnquire(widget.job.id!);
                ToastMessage.show('Enquiry sent successfully!');

                }else{
                    ToastMessage.show('Please enter enquiry message');

                }
               
              },
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
            ),
          ],
          content: SizedBox(
              width: 320,
              child: EnquiryForm(
                onChange: (String onchageValue) {
                  final provider =
                      Provider.of<JobSeekViewModel>(context, listen: false);
                  provider.onChangeEnquireData(onchageValue);
                },
              )),
        );
      },
    );
  }

  void _showApplyForm(BuildContext context) {
    Provider.of<JobSeekViewModel>(context, listen: false)
        .setSelectedJob(widget.job);
    NavigationService().navigateTo(
      RouteList.applyJob,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final isCollapsed =
                    top <= kToolbarHeight + MediaQuery.of(context).padding.top;
                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: isCollapsed
                      ? Text(
                          widget.job.title ?? '',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      : null,
                  background: CachedNetworkImageWidget(
                    imageUrl: widget.job.bannerImage?.url ?? '',
                    width: double.infinity,
                  ),
                );
              },
            ),
            leading: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final isCollapsed =
                    top <= kToolbarHeight + MediaQuery.of(context).padding.top;

                return isCollapsed
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back,
                            size: 24, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColors.whiteColor,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 20, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
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
                ClipOval(
                  child: widget.job.logo != null && widget.job.logo!.isNotEmpty
                      ? CachedNetworkImageWidget(
                          imageUrl: widget.job.logo!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade300,
                          child:
                              const Icon(Icons.business, color: Colors.white),
                        ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.job.companyName ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.job.jRole ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade50, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.job.createdAt?.isNotEmpty == true
                    ? Jiffy.parse(widget.job.createdAt!).fromNow()
                    : 'Recently posted',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        if (widget.job.yearsOfExperience != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              jobInfoItem(ImageConst.briefcaseSvg,
                  '${widget.job.yearsOfExperience} Yrs Experience'),
              SizedBox(height: 12),
            ],
          ),
        /*if ((widget.job.payMin != null && widget.job.payMin! > 0) || 
            (widget.job.payMax != null && widget.job.payMax! > 0))
          Column(
            children: [
              jobInfoItem(ImageConst.briefcurrencySvg,
                  '${widget.job.payMin ?? 0} - ${widget.job.payMax ?? 0}'),
              SizedBox(height: 12),
            ],
          ),*/
        if (widget.job.typeofEmployment?.isNotEmpty == true)
          Column(
            children: [
              Wrap(
                spacing: 1,
                runSpacing: 2,
                children: widget.job.typeofEmployment!
                    .map((type) => customFilterChip(type.toString()))
                    .toList(),
              ),
            ],
          ),
        Divider(height: 30),
        if (widget.job.hiringPeriod?.isNotEmpty == true)
          InfoItem(
              iconPath: ImageConst.hiringSvg,
              title: 'Looking for hire',
              subtitle: '${widget.job.hiringPeriod}'),
        if (widget.job.education?.isNotEmpty == true)
          InfoItem(
              iconPath: ImageConst.graduationSvg,
              title: 'Education Level',
              subtitle: '${widget.job.education}'),
        if (widget.job.noOfPeople != null)
          InfoItem(
              iconPath: ImageConst.peopleSvg,
              title: 'No. Positions',
              subtitle: '${widget.job.noOfPeople}'),
        if (widget.job.rateBilling?.isNotEmpty == true)
          InfoItem(
              iconPath: ImageConst.briefcurrencySvg,
              title: 'Rate',
              subtitle:
                  '${widget.job.rateBilling}'),
        if ((widget.job.payMin != null || widget.job.payMax != null))
          InfoItem(
              iconPath: ImageConst.briefcurrencySvg,
              title: 'Pay',
              subtitle:
                  '\$ ${widget.job.payMin ?? 0} - \$ ${widget.job.payMax ?? 0}'),

        //_sectionHeader('Benefits'),
        //_sectionText('${widget.job.offeredBenefits?.isNotEmpty == true ? widget.job.offeredBenefits!.first : 'No benefits listed'}'),
        //Divider(height: 10),
        if (widget.job.offeredBenefits?.length != 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 4),
              _sectionHeader("Benifits"),
              CustomChipView(typesList: widget.job.offeredBenefits ?? []),
            ],
          ),
        if (widget.job.description?.isNotEmpty == true) ...[
          Divider(height: 4),
          _sectionHeader('Job Description'),
          _sectionText('${widget.job.description}'),
        ],
        if (widget.job.location?.isNotEmpty == true) ...[
          Divider(height: 4),
          _sectionHeader('Job Location'),
          Text('${widget.job.location}'),
          locationView(context),
        ],
        if (widget.job.description?.isNotEmpty == true) ...[
          Divider(height: 4),
          _sectionHeader('About Company'),
          _sectionText('${widget.job.description}'),
        ],
        if (widget.job.clinicLogo != null && widget.job.clinicLogo!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader('Gallery'),
              GalleryView(
                  mediaList: widget.job.clinicLogo!
                      .map((e) => PostImage(
                          url: e.url, type: e.type, extension: e.extension))
                      .toList(),
                  imageUrls:
                      widget.job.clinicLogo!.map((e) => e.url ?? '').toList()),
            ],
          ),
        if ((widget.job.facebookUrl?.isNotEmpty == true) ||
            (widget.job.instagramUrl?.isNotEmpty == true) ||
            (widget.job.linkedinUrl?.isNotEmpty == true))
          _sectionHeader('Social Media Handles'),
        Row(
          children: [
            if (widget.job.websiteUrl?.isNotEmpty == true)
              IconButton(
                  icon: SvgPicture.asset(ImageConst.webSvg,
                      width: 30, height: 46),
                  onPressed: () async {
                    final Uri appUri = Uri.parse(widget.job.websiteUrl!);
                    if (await canLaunchUrl(appUri)) {
                      await launchUrl(appUri,
                          mode: LaunchMode.externalApplication);
                      return;
                    }
                  }),
            if (widget.job.facebookUrl?.isNotEmpty == true)
              IconButton(
                  icon: ImageWidget(imageUrl: ImageConst.facebookSvg),
                  onPressed: () async {
                    final Uri appUri = Uri.parse(widget.job.facebookUrl!);
                    if (await canLaunchUrl(appUri)) {
                      await launchUrl(appUri,
                          mode: LaunchMode.externalApplication);
                      return;
                    }
                  }),
            if (widget.job.instagramUrl?.isNotEmpty == true)
              IconButton(
                  icon: ImageWidget(imageUrl: ImageConst.instagramSvg),
                  onPressed: () async {
                    final Uri appUri = Uri.parse(widget.job.instagramUrl!);
                    if (await canLaunchUrl(appUri)) {
                      await launchUrl(appUri,
                          mode: LaunchMode.externalApplication);
                      return;
                    }
                  }),
            if (widget.job.linkedinUrl?.isNotEmpty == true)
              IconButton(
                  icon: ImageWidget(imageUrl: ImageConst.linkedinSvg),
                  onPressed: () async {
                    final Uri appUri = Uri.parse(widget.job.linkedinUrl!);
                    if (await canLaunchUrl(appUri)) {
                      await launchUrl(appUri,
                          mode: LaunchMode.externalApplication);
                      return;
                    }
                  }),
          ],
        ),
        if (widget.job.video?.isNotEmpty == true) ...[
          _sectionHeader('Video Link'),
          GestureDetector(
              onTap: () async {
                final Uri appUri = Uri.parse(widget.job.video!);
                if (await canLaunchUrl(appUri)) {
                  await launchUrl(appUri, mode: LaunchMode.externalApplication);
                  return;
                }
              },
              child: Text(
                widget.job.video ?? '',
                style: TextStyles.medium2(color: AppColors.primaryColor),
              )),
        ],
        SizedBox(height: 20),
        actionsWidget(context),
        SizedBox(height: 20),
      ],
    );
  }

  Widget actionsWidget(BuildContext context) {
    final provider = Provider.of<JobSeekViewModel>(context);
    if (provider.isHidleFolatingButton) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomRoundedButton(
              text: 'Enquiry',
              onPressed: () => _showEnquiryForm(context,provider),
              backgroundColor: const Color(0xFFFFF3E8),
              textColor: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomRoundedButton(
              text: provider.isJobApplied ? 'Applied' : 'Apply',
              onPressed: () =>
                  provider.isJobApplied ? null : _showApplyForm(context),
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
            ),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget locationView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openLocationInMaps(context);
      },
      child: Container(
        height: 180,
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.grey[300],
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
    if (widget.job.location == null || widget.job.location!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String location = Uri.encodeComponent(widget.job.location!);
    final String googleMapsApp = 'google.navigation:q=$location';
    final String googleMapsWeb =
        'https://www.google.com/maps/search/?api=1&query=$location';

    try {
      final Uri appUri = Uri.parse(googleMapsApp);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (e) {
      print('Google Maps app not available: $e');
    }

    try {
      final Uri webUri = Uri.parse(googleMapsWeb);
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error launching maps: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open maps application'),
          backgroundColor: Colors.red,
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
          colorFilter: const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _sectionText(String text) {
    return Text(text, style: TextStyle(color: Colors.grey[700]));
  }
}





/*
Query
mutataion 

 */