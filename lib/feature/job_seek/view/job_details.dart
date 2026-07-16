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
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/custom_chip_view.dart';
import 'package:di360_flutter/widgets/gallary_view.dart';
import 'package:di360_flutter/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsScreen extends StatefulWidget {
  final Jobs job;
  const JobDetailsScreen({super.key, required this.job});

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

  void _showEnquiryForm(BuildContext context, JobSeekViewModel provider) {
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
                if (provider.enquiryData != null) {
                  navigationService.goBack();
                  await Provider.of<JobSeekViewModel>(context, listen: false)
                      .jobEnquire(widget.job.id!);
                  ToastMessage.show('Enquiry sent successfully!');
                } else {
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
    final provider = Provider.of<JobSeekViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Job Detail View",
            style: TextStyles.medium2(),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.job.bannerImage?.url != null &&
                widget.job.bannerImage?.url != "")
              CachedNetworkImageWidget(
                imageUrl: widget.job.bannerImage?.url ?? "",
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: _buildBodyContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
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
                      child: Image.asset(
                        ImageConst.directorProfile,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.job.title != "" && widget.job.title != null)
                    customHeadTexter("Job Title", widget.job.title ?? ''),
                  if (widget.job.jRole != "" && widget.job.jRole != null)
                    customHeadTexter("Role", widget.job.jRole ?? ''),
                  if (widget.job.companyName != "" &&
                      widget.job.companyName != null)
                    customHeadTexter(
                        "Company Name", widget.job.companyName ?? ''),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _timeChip(
            "${DateFormatUtils.formatTwoDateTime(widget.job.createdAt ?? "")}"),
        SizedBox(height: 10),
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
        SizedBox(height: 10),
        if (widget.job.availabilityDate != null &&
            widget.job.availabilityDate?.isNotEmpty == true &&
            widget.job.availabilityDate?.length == 2 &&
            widget.job.availabilityDate?[0] != "" &&
            widget.job.availabilityDate?[1] != "")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dates Required :",
                style: TextStyles.medium2(color: AppColors.black),
              ),
              Text(
                "${widget.job.availabilityDate![0]} to ${widget.job.availabilityDate![1]}",
                style: TextStyles.medium2(color: AppColors.primaryColor),
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
        if (widget.job.yearsOfExperience?.isNotEmpty == true)
          InfoItem(
              iconPath: ImageConst.briefcaseSvg,
              title: 'Experience Level',
              subtitle: '${widget.job.yearsOfExperience}'),
        if (widget.job.noOfPeople != null)
          InfoItem(
              iconPath: ImageConst.peopleSvg,
              title: 'No. Positions',
              subtitle: '${widget.job.noOfPeople}'),
        if (widget.job.rateBilling?.isNotEmpty == true)
          InfoItem(
              iconPath: ImageConst.briefcurrencySvg,
              title: 'Rate',
              subtitle: '${widget.job.rateBilling}'),
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
              _sectionHeader("Benefits"),
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
        if ((widget.job.dentalSupplier?.directories?.isNotEmpty == true &&
                widget.job.dentalSupplier?.directories?.first.description
                        ?.isNotEmpty ==
                    true) ||
            (widget.job.dentalPractice?.directories?.isNotEmpty == true &&
                widget.job.dentalPractice?.directories?.first.description
                        ?.isNotEmpty ==
                    true)) ...[
          Divider(height: 4),
          _sectionHeader('About Company'),
          _sectionText(
              '${widget.job.dentalSupplier?.directories?.first.description ?? widget.job.dentalPractice?.directories?.first.description}'),
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

  Widget customHeadTexter(String key, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 12, color: AppColors.geryColor),
        ),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
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
              onPressed: () => _showEnquiryForm(context, provider),
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
    } catch (e) {}

    try {
      final Uri webUri = Uri.parse(googleMapsWeb);
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open maps application'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _timeChip(String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Colors.grey.shade300,
            ],
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Posted on : ",
                style: TextStyles.medium1(
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text: time,
                style: TextStyles.medium1(
                  color: AppColors.geryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    return HtmlWidget(text);
  }
}





/*
Query
mutataion 

 */