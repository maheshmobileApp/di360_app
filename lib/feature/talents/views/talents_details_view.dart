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
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:di360_flutter/widgets/certificates_view.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/custom_chip_view.dart';
import 'package:di360_flutter/widgets/exerinace_info_icons.dart';
import 'package:di360_flutter/widgets/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TalentsDetailsView extends StatefulWidget with BaseContextHelpers {
  final JobProfiles? talentList;

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
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () {
              navigationService.goBack();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Talent Preview",
          style: TextStyles.medium2(),
        )),
       body: _buildBodyContent(context, talentViewModel),
       bottomNavigationBar: FutureBuilder<String>(
         future: LocalStorage.getStringVal(LocalStorageConst.type),
         builder: (context, snapshot) {
           if (snapshot.hasData && snapshot.data == "SUPPLIER" || snapshot.data == "PRACTICE") {
             return _bottomButtons(context);
           }
           return const SizedBox.shrink();
         },
       ));
  }

  Widget _buildBodyContent(
      BuildContext context, TalentsViewModel talentViewmodel) {
    String profleImage = '';
    if (widget.talentList!.profileImage.isNotEmpty) {
      profleImage = widget.talentList!.profileImage.first.url ?? '';
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          
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
                      width: 90,
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
              addVertical(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExerinaceInfoIcons(
                      icon: Icons.work,
                      text:
                          '${widget.talentList?.yearOfExperience ?? 0} Yrs Experience'),
                  addVertical(12),
                  ExerinaceInfoIcons(
                      icon: Icons.location_on,
                      text: '${widget.talentList?.location ?? ''}'),
                  addVertical(12),
                  ExerinaceInfoIcons(
                      icon: Icons.call,
                      text: '${widget.talentList?.mobileNumber ?? ''}'),
                  addVertical(12),
                  ExerinaceInfoIcons(
                      icon: Icons.business,
                      text: '${widget.talentList?.currentCompany ?? ''}'),
                  addVertical(12),
                  ExerinaceInfoIcons(
                      icon: Icons.email,
                      text: '${widget.talentList?.emailAddress ?? ''}'),
                  addVertical(12),
                  ExerinaceInfoIcons(
                    icon: Icons.language,
                    text: (widget.talentList?.languagesSpoken != null)
                        ? widget.talentList!.languagesSpoken.join(", ")
                        : '',
                  ),
                  addVertical(12),
                  ExerinaceInfoIcons(
                    icon: Icons.build,
                    text: (widget.talentList?.areasExpertise != null)
                        ? widget.talentList!.areasExpertise.join(", ")
                        : '',
                  ),
                ],
              ),
              Divider(color: AppColors.geryColor),
              
              // Professional Details Section
              if (_hasAnyProfessionalData())
                _buildProfessionalSection(),
              
              // Skills Section
              if (widget.talentList?.skills?.isNotEmpty == true) ...[
                addVertical(10),
                _sectionHeader("Skills"),
                addVertical(6),
                CustomChipView(typesList: widget.talentList!.skills!),
              ],
              
              // Work Type Section
              if (widget.talentList?.workType?.isNotEmpty == true) ...[
                addVertical(10),
                _sectionHeader("Work Type"),
                addVertical(6),
                CustomChipView(typesList: widget.talentList!.workType!),
              ],
              
              // About Section
              if (widget.talentList?.aboutYourself?.isNotEmpty == true) ...[
                const Divider(),
                _sectionHeader("About me / Profile Summary"),
                _sectionText(widget.talentList!.aboutYourself!),
              ],
              
              // Work Experience Section
              if (widget.talentList?.jobExperiences?.isNotEmpty == true) ...[
                const Divider(),
                _sectionHeader("Work Experience"),
                addVertical(10),
                _buildJobExperiencesList(talentViewmodel),
              ],
              
              // Certifications Section
              if (widget.talentList?.certificate.isNotEmpty == true) ...[
                addVertical(16),
                _sectionHeader("Certifications"),
                CertificatesView(certificates: widget.talentList?.certificate),
              ],
              
              // Cover Letter Section
              if (widget.talentList?.coverLetter.isNotEmpty == true) ...[
                addVertical(16),
                _sectionHeader("Cover Letter"),
                CertificatesView(certificates: widget.talentList?.coverLetter),
              ],
              
              // Location Section
              if (widget.talentList?.location?.isNotEmpty == true) ...[
                addVertical(16),
                _sectionHeader('Job Location'),
                Text(widget.talentList!.location!),
                locationView(context),
              ],
            ]),
          ],
        ),
      ),
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
            addHorizontal(16),
            Expanded(
              child: CustomRoundedButton(
                text: (widget.talentList?.jobHirings?.isNotEmpty == true && widget.talentList?.jobHirings?.first.id != null) ? 'Requested' : 'Hire Me',
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
      padding: EdgeInsets.only(top: 8.0, bottom: 8),
      child: Text(title, style: TextStyles.bold2()),
    );
  }

  Widget _sectionText(String text) {
    return Text(text,
        maxLines: null,
        overflow: TextOverflow.visible,
        style: TextStyles.regular1(color: AppColors.locationTextColor));
  }
  
  bool _hasAnyProfessionalData() {
    return (widget.talentList?.abnNumber?.isNotEmpty == true) ||
           (widget.talentList?.professionType?.isNotEmpty == true) ||
           (widget.talentList?.aphraNumber?.isNotEmpty == true) ||
           (widget.talentList?.workRights?.isNotEmpty == true);
  }
  
  Widget _buildProfessionalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVertical(16),
        _sectionHeader("Professional Details"),
        
        if (widget.talentList?.professionType?.isNotEmpty == true) ...[
           addVertical(10),
          Text("Profession Type", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.work_history_outlined,
            text: widget.talentList!.professionType!,
          ),
        ],
        
        if (widget.talentList?.abnNumber?.isNotEmpty == true) ...[
          addVertical(10),
          Text("ABN Number", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.business_center,
            text: widget.talentList!.abnNumber!,
          ),
        ],
        
        if (widget.talentList?.aphraNumber?.isNotEmpty == true) ...[
          addVertical(10),
          Text("AHPRA Number", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.verified_user,
            text: widget.talentList!.aphraNumber!,
          ),
        ],
        
        if (widget.talentList?.workRights?.isNotEmpty == true) ...[
          addVertical(10),
          Text("Work Rights", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.assessment,
            text: widget.talentList!.workRights!,
          ),
        ],
      ],
    );
  }

  void _showEnquiryForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
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
    super.initState();
    final provider = Provider.of<TalentsViewModel>(context, listen: false);
    provider.isShowBottomeActionss(widget.talentList?.id ?? '');
  }
}
