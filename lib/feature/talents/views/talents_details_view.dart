import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/job_seek/view/enquiry_foam.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:di360_flutter/widgets/certificates_view.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/custom_chip_view.dart';
import 'package:di360_flutter/widgets/education_data_withicon.dart';
import 'package:di360_flutter/widgets/exerinace_info_icons.dart';
import 'package:di360_flutter/widgets/experience_info.dart';
import 'package:di360_flutter/widgets/header_image.dart';
import 'package:di360_flutter/widgets/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TalentsDetailsView extends StatefulWidget {
  final JobProfile? talentList;

  const TalentsDetailsView({
    super.key,
    this.talentList,
  });

  @override
  State<TalentsDetailsView> createState() => _TalentsDetailsViewState();
}

class _TalentsDetailsViewState extends State<TalentsDetailsView>
    with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final talentViewModel = Provider.of<TalentsViewModel>(context);
    return Scaffold(
        body: HeaderImageView(
          logo: "",
          title: widget.talentList?.fullName ?? "",
          body: _buildBodyContent(context, talentViewModel),
        ),
        bottomNavigationBar: _bottomButtons(context));
  }

  Widget _buildBodyContent(
      BuildContext context, TalentsViewModel talentViewmodel) {
    final List<String> educationList = widget.talentList?.educations
            .map((e) => e.qualification ?? '')
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];
    String profleImage = '';
    if (widget.talentList!.profileImage.isNotEmpty) {
      profleImage = widget.talentList!.profileImage.first.url ?? '';
    }
    return Column(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LogoWithTitle(
                  title: widget.talentList?.fullName ?? "",
                  showTime: false,
                  createdAt: widget.talentList?.createdAt ?? "",
                  role: widget.talentList?.jobDesignation ?? "",
                  imageUrl: profleImage,
                ),
              ),
              if ((widget.talentList?.uploadResume.isNotEmpty ?? false))
                CustomRoundedButton(
                  height: 36,
                  text: 'View CV',
                  onPressed: () {
                    navigationService.push(HorizantalPdf(
                      fileUrl: widget.talentList!.uploadResume.first.url ?? '',
                      fileName: '',
                      isfullScreen: true,
                    ));
                  },
                  backgroundColor: AppColors.timeBgColor,
                  textColor: AppColors.primaryColor,
                ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExerinaceInfoIcons(
                  icon: Icons.work,
                  text:
                      '${widget.talentList?.yearOfExperience ?? 0} Yrs Experience'),
              SizedBox(height: 12),
              ExerinaceInfoIcons(
                  icon: Icons.location_on,
                  text: '${widget.talentList?.location ?? ''}'),
              SizedBox(height: 12),
              ExerinaceInfoIcons(
                  icon: Icons.call,
                  text: '${widget.talentList?.mobileNumber ?? ''}'),
              SizedBox(height: 12),
              ExerinaceInfoIcons(
                  icon: Icons.business,
                  text: '${widget.talentList?.currentCompany ?? ''}'),
              SizedBox(height: 12),
              ExerinaceInfoIcons(
                  icon: Icons.email,
                  text: '${widget.talentList?.emailAddress ?? ''}'),
              SizedBox(height: 12),
              ExerinaceInfoIcons(
                  icon: Icons.language,
                  text: '${widget.talentList?.languagesSpoken ?? ''}'),
              SizedBox(height: 12),
              ExerinaceInfoIcons(
                  icon: Icons.build,
                  text: '${widget.talentList?.areasExpertise ?? ''}'),
            ],
          ),
          Divider(
            color: AppColors.geryColor,
          ),
          SizedBox(height: 16),
          const SizedBox(height: 16),
          EducationDataWithIcon(
            iconPath: ImageConst.graduationSvg,
            title: 'Education',
            educationList: widget.talentList?.educations ?? [],
          ),
          const SizedBox(height: 16),
         _sectionHeader(
            "Skills"
          ),
          const SizedBox(height: 6),
          CustomChipView(typesList: widget.talentList?.skills ?? []),
          const SizedBox(height: 16),
          _sectionHeader("Work Type"),
          const SizedBox(height: 6),
          CustomChipView(typesList: widget.talentList?.workType ?? []),
          const SizedBox(height: 10),
           _sectionHeader("ABN Number"),
           ExerinaceInfoIcons(
                  icon: Icons.call,
            text: widget.talentList?.abnNumber ?? '',
          ),
          const SizedBox(height: 16),
         _sectionHeader("Profession Type"),
          const SizedBox(height: 6),
            ExerinaceInfoIcons(
                  icon: Icons.work_history_outlined,
              text:'${widget.talentList?.professionType?? ''}' ),
          const SizedBox(height: 10),
           _sectionHeader("AHPRA Number"),
          ExerinaceInfoIcons(
                  icon: Icons.call,
            text: widget.talentList?.aphraNumber ?? '',
          ),
          const SizedBox(height: 16),
          _sectionHeader("Work Rights"),
          const SizedBox(height: 6),
           ExerinaceInfoIcons(
                  icon: Icons.assessment,
              text:'${widget.talentList?.workRights?? ''}' ),
          const Divider(),
          _sectionHeader("About me / Profile Summary"),
          _sectionText(widget.talentList?.aboutYourself ?? ''),
          const Divider(),
          _sectionHeader("Work Experience"),
          const SizedBox(height: 16),
          _buildJobExperiencesList(talentViewmodel),
          const SizedBox.shrink(),
          const SizedBox(height: 16),
          _sectionHeader("Certifications"),
          CertificatesView(certificates: widget.talentList?.certificate),
          const SizedBox(height: 16),
          _sectionHeader("Cover Letter"),
          CertificatesView(certificates: widget.talentList?.coverLetter),
          const SizedBox(height: 16),
          _sectionHeader('Job Location'),
          Text(widget.talentList?.location ?? ''),
          locationView(context),
        ]),
      ],
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Container(
      height: getSize(context).height * 0.1,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.87),
          blurRadius: 5.0,
        )
      ], color: AppColors.whiteColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomRoundedButton(
                height: 42,
                text: 'Enquiry',
                onPressed: () {
                  _showEnquiryForm(context);
                  // handle Enquiry
                },
                backgroundColor: AppColors.timeBgColor,
                textColor: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomRoundedButton(
                text: 'Hire Me',
                height: 42,
                onPressed: () async {
                  final userId =
                      await LocalStorage.getStringVal(LocalStorageConst.userId);
                  final provider =
                      Provider.of<TalentsViewModel>(context, listen: false);
                  final hireRequest = HireMeRequest(
                      dentalProfessionalId: userId,
                      dentalSupplierId: null,
                      message: '',
                      attachments: []);
                  await provider.hireMe(hireRequest);
                  ToastMessage.show('Hire Me Request sent successfully!');
                },
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
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
    // Safely extract the location and ensure it's non-null/non-empty
    final location = widget.talentList?.location;
    if (location == null || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final encodedLocation = Uri.encodeComponent(location);
    final googleMapsApp = 'google.navigation:q=$encodedLocation';
    final googleMapsWeb =
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation';

    try {
      final appUri = Uri.parse(googleMapsApp);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (e) {
      debugPrint('Google Maps app not available: $e');
    }

    try {
      final webUri = Uri.parse(googleMapsWeb);
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching maps: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open maps application'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildJobExperiencesList(TalentsViewModel talentViewmodel) {
    final experiences = widget.talentList?.jobExperiences ?? [];

    if (experiences.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(6),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = experiences[index];

        return ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          onTap: () => talentViewmodel.toggleIndex(index),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.companyName?.isNotEmpty ?? false)
                Text(
                  item.companyName!,
                  style: TextStyles.medium2(),
                ),
              if (item.jobTitle?.isNotEmpty ?? false)
                Text(
                  item.jobTitle!,
                  style: TextStyles.regular1(),
                ),
              Text(
                "${item.startMonth ?? ''} ${item.startYear ?? ''} - "
                "${item.stillInRole == true ? 'Present' : '${item.endMonth ?? ''} ${item.endYear ?? ''}'}",
                style: TextStyles.medium1(),
              ),
              if (talentViewmodel.expandedIndex == index &&
                  item.jobDescription?.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    item.jobDescription!,
                    style: TextStyles.regular1(),
                  ),
                ),
            ],
          ),
          trailing: Icon(
            talentViewmodel.expandedIndex == index
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Colors.orange,
          ),
        );
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title, style: TextStyles.bold2()),
    );
  }

  Widget _sectionText(String text) {
    return Text(text,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(color: AppColors.locationTextColor));
  }

  void _showEnquiryForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16),
          insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          actions: [
            CustomRoundedButton(
              text: "Send",
              onPressed: () async {
                navigationService.goBack();
                final provider =
                    Provider.of<TalentsViewModel>(context, listen: false);
                final userId =
                    await LocalStorage.getStringVal(LocalStorageConst.userId);
                final enquire = EnquiryRequest(
                    enquiryDescription: provider.enquiryData ?? '',
                    talentId: widget.talentList?.id ?? '',
                    enquiryFrom: userId);
                await provider.enquire(enquire);
                ToastMessage.show('Enquiry sent successfully!');
              },
              backgroundColor: Colors.orange,
              textColor: Colors.white,
            ),
          ],
          content: SizedBox(
              width: 320,
              child: EnquiryForm(
                onChange: (String onchageValue) {
                  final provider =
                      Provider.of<TalentsViewModel>(context, listen: false);
                  provider.onChangeEnquireData(onchageValue);
                },
              )),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<TalentsViewModel>(context, listen: false);
    provider.isShowBottomeActionss(widget.talentList?.id ?? '');
  }
}
