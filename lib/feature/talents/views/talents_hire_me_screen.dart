import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/feature/job_seek/view/enquiry_foam.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/certificates_view.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/custom_chip_view.dart';
import 'package:di360_flutter/widgets/exerinace_info_icons.dart';
import 'package:di360_flutter/widgets/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TalentsHireMeScreen extends StatefulWidget with BaseContextHelpers {
  const TalentsHireMeScreen({super.key});

  @override
  State<TalentsHireMeScreen> createState() => _TalentsDetailsViewState();
}

class _TalentsDetailsViewState extends State<TalentsHireMeScreen>
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
              "Talent Detail View",
              style: TextStyles.medium2(),
            )),
        body: _buildBodyContent(context, talentViewModel),
        bottomNavigationBar: FutureBuilder<String>(
          future: LocalStorage.getStringVal(LocalStorageConst.type),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                (snapshot.data == UserRole.supplier.value ||
                    snapshot.data == UserRole.practice.value)) {
              return FutureBuilder<String>(
                future: LocalStorage.getStringVal(LocalStorageConst.userId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return _bottomButtons(context, userSnapshot.data!);
                  }
                  return const SizedBox.shrink();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }

  Widget _buildBodyContent(
      BuildContext context, TalentsViewModel talentViewmodel) {
    final talentList = talentViewmodel.talentListById?.firstOrNull;
    String profleImage = '';
    if (talentList?.profileImage.isNotEmpty ?? false) {
      profleImage = talentList!.profileImage.first.url ?? '';
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
                      title: talentList?.fullName ?? "",
                      showTime: false,
                      createdAt: talentList?.createdAt ?? "",
                      role: talentList?.professionType ?? "",
                      imageUrl: profleImage,
                      postAnonymously: talentList?.postAnonymously ?? false,
                    ),
                  ),
                  if ((talentList?.uploadResume.isNotEmpty ?? false))
                    CustomRoundedButton(
                      height: 36,
                      width: 90,
                      text: 'View CV',
                      onPressed: () {
                        navigationService.push(HorizantalPdf(
                          fileUrl: talentList!.uploadResume.first.url ?? '',
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
                  if (talentList?.yearOfExperience != null)
                    ExerinaceInfoIcons(
                        icon: Icons.work,
                        text: '${talentList!.yearOfExperience} Yrs Experience'),
                  if (talentList?.yearOfExperience != null) addVertical(12),
                  if (talentList?.location?.isNotEmpty == true)
                    ExerinaceInfoIcons(
                        icon: Icons.location_on, text: talentList!.location!),
                  if (talentList?.location?.isNotEmpty == true) addVertical(12),
                  if (talentList?.mobileNumber?.isNotEmpty == true && talentList?.postAnonymously == false) ...[
                    ExerinaceInfoIcons(
                        icon: Icons.call, text: talentList!.mobileNumber!),
                        addVertical(12),
                  ],
                  
                  if (talentList?.currentCompany?.isNotEmpty == true)
                    ExerinaceInfoIcons(
                        icon: Icons.business,
                        text: talentList!.currentCompany!),
                  if (talentList?.currentCompany?.isNotEmpty == true)
                    addVertical(12),
                  if (talentList?.emailAddress?.isNotEmpty == true)
                    ExerinaceInfoIcons(
                        icon: Icons.email, text: talentList!.emailAddress!),
                  if (talentList?.emailAddress?.isNotEmpty == true)
                    addVertical(12),
                  if (talentList?.languagesSpoken.isNotEmpty == true)
                    ExerinaceInfoIcons(
                      icon: Icons.language,
                      text: talentList!.languagesSpoken.join(", "),
                    ),
                  if (talentList?.languagesSpoken.isNotEmpty == true)
                    addVertical(12),
                  if (talentList?.areasExpertise.isNotEmpty == true)
                    ExerinaceInfoIcons(
                      icon: Icons.build,
                      text: talentList!.areasExpertise.join(", "),
                    ),
                ],
              ),
              Divider(color: AppColors.geryColor),

              // Professional Details Section
              if (_hasAnyProfessionalData()) _buildProfessionalSection(),

              // Skills Section
              if (talentList?.skills?.isNotEmpty == true) ...[
                addVertical(10),
                _sectionHeader("Skills"),
                addVertical(6),
                CustomChipView(typesList: talentList!.skills!),
              ],

              // Work Type Section
              if (talentList?.workType.isNotEmpty == true) ...[
                addVertical(10),
                _sectionHeader("Work Type"),
                addVertical(6),
                CustomChipView(typesList: talentList!.workType),
              ],

              // About Section
              if (talentList?.aboutYourself?.isNotEmpty == true) ...[
                const Divider(),
                _sectionHeader("About me / Profile Summary"),
                _sectionText(talentList!.aboutYourself!),
              ],

              // Work Experience Section
              if (talentList?.jobExperiences.isNotEmpty == true) ...[
                const Divider(),
                _sectionHeader("Work Experience"),
                addVertical(10),
                _buildJobExperiencesList(talentViewmodel),
              ],

              // Certifications Section
              if (talentList?.certificate.isNotEmpty == true) ...[
                addVertical(16),
                _sectionHeader("Certifications"),
                CertificatesView(certificates: talentList?.certificate),
              ],

              // Cover Letter Section
              if (talentList?.coverLetter.isNotEmpty == true) ...[
                addVertical(16),
                _sectionHeader("Cover Letter"),
                CertificatesView(certificates: talentList?.coverLetter),
              ],

              // Location Section
              if (talentList?.location?.isNotEmpty == true) ...[
                addVertical(16),
                _sectionHeader('Job Location'),
                Text(talentList!.location!),
                locationView(context, talentList),
              ],
            ]),
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons(BuildContext context, String userId) {
    final talentViewModel = Provider.of<TalentsViewModel>(context);
    final talentList = talentViewModel.talentListById?.firstOrNull;
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
                text: ((talentList?.jobHirings
                                .any((v) => v.dentalSupplierId == userId) ==
                            true) ||
                        (talentList?.jobHirings
                                .any((v) => v.dentalPracticeId == userId) ==
                            true))
                    ? 'Requested'
                    : 'Hire Me',
                height: 42,
                onPressed: () async {
                  final userId =
                      await LocalStorage.getStringVal(LocalStorageConst.userId);
                  if ((talentList?.jobHirings
                              .any((v) => v.dentalSupplierId == userId) ==
                          true) ||
                      (talentList?.jobHirings
                              .any((v) => v.dentalPracticeId == userId) ==
                          true)) {
                    ToastMessage.show(
                        'You have already sent a request to this talent!');
                  } else {
                    final provider =
                        Provider.of<TalentsViewModel>(context, listen: false);
                    await provider.hireMeTalent(talentList?.id ?? "",
                        talentList?.dentalProfessionalId ?? "");
                    await provider.getTalentListMutationById(
                        context, talentList?.dentalProfessionalId ?? "");
                    ToastMessage.show('Hire Me Request sent successfully!');
                  }
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

  Widget locationView(BuildContext context, JobProfiles? talentList) {
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
    final talentViewModel =
        Provider.of<TalentsViewModel>(context, listen: false);
    final talentList = talentViewModel.talentListById?.firstOrNull;
    final location = talentList?.location;
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
    final talentList = talentViewmodel.talentListById?.firstOrNull;
    final experiences = talentList?.jobExperiences ?? [];

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
    final talentViewModel =
        Provider.of<TalentsViewModel>(context, listen: false);
    final talentList = talentViewModel.talentListById?.firstOrNull;
    return (talentList?.abnNumber?.isNotEmpty == true) ||
        (talentList?.professionType?.isNotEmpty == true) ||
        (talentList?.aphraNumber?.isNotEmpty == true) ||
        (talentList?.workRights?.isNotEmpty == true);
  }

  Widget _buildProfessionalSection() {
    final talentViewModel =
        Provider.of<TalentsViewModel>(context, listen: false);
    final talentList = talentViewModel.talentListById?.firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVertical(16),
        _sectionHeader("Professional Details"),
        if (talentList?.professionType?.isNotEmpty == true) ...[
          addVertical(10),
          Text("Profession Type", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.work_history_outlined,
            text: talentList!.professionType!,
          ),
        ],
        if (talentList?.abnNumber?.isNotEmpty == true) ...[
          addVertical(10),
          Text("ABN Number", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.business_center,
            text: talentList!.abnNumber!,
          ),
        ],
        if (talentList?.aphraNumber?.isNotEmpty == true) ...[
          addVertical(10),
          Text("AHPRA Number", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.verified_user,
            text: talentList!.aphraNumber!,
          ),
        ],
        if (talentList?.workRights?.isNotEmpty == true) ...[
          addVertical(10),
          Text("Work Rights", style: TextStyles.medium2()),
          addVertical(4),
          ExerinaceInfoIcons(
            icon: Icons.assessment,
            text: talentList!.workRights!,
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
                final provider =
                    Provider.of<TalentsViewModel>(context, listen: false);
                final userId =
                    await LocalStorage.getStringVal(LocalStorageConst.userId);
                final type =
                    await LocalStorage.getStringVal(LocalStorageConst.type);
                final talentList = provider.talentListById?.firstOrNull;
                final enquire = EnquiryRequest(
                    enquiryDescription: provider.enquiryData ?? '',
                    talentId: talentList?.id ?? '',
                    enquirySenderId: userId,
                    enquirySenderType: type,
                    enquiryReceiverId: talentList?.dentalProfessionalId ?? "",
                    enquiryReceiverType: UserRole.professional.value);
                if (provider.enquiryData == null ||
                    provider.enquiryData?.isEmpty == true) {
                  ToastMessage.show(
                      'Please enter a message before sending an enquiry.');
                  return;
                } else {
                  await provider.enquire(enquire);
                  navigationService.goBack();

                  ToastMessage.show('Enquiry sent successfully!');
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
    final talentList = provider.talentListById?.firstOrNull;
    provider.isShowBottomeActionss(talentList?.id ?? '');
  }
}
