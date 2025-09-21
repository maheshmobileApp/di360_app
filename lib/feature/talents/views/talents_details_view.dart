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
import 'package:di360_flutter/widgets/expended_view.dart';
import 'package:di360_flutter/widgets/experience_info.dart';
import 'package:di360_flutter/widgets/header_image.dart';
import 'package:di360_flutter/widgets/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoWithTitle(
                title: widget.talentList?.fullName ?? "",
                showTime: false,
                createdAt: widget.talentList?.createdAt ?? "",
                role: widget.talentList?.jobDesignation ?? "",
                imageUrl: profleImage),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExperienceInfo(
                    svgPath: ImageConst.briefcaseSvg,
                    text:
                        '${widget.talentList?.yearOfExperience ?? 0} Yrs Experience'),
                SizedBox(height: 12),
                ExperienceInfo(
                    svgPath: ImageConst.locationsvg,
                    text: '${widget.talentList?.location ?? ''}'),
              ],
            ),
            Divider(
              color: AppColors.geryColor,
            ),
            SizedBox(height: 16),
            EducationDataWithicon(
                iconPath: ImageConst.graduationSvg,
                title: 'Education',
                educationList: educationList),
            SizedBox(height: 16),
            Text("Skils"),
            SizedBox(height: 6),
            CustomChipView(typesList: widget.talentList?.skills ?? []),
            SizedBox(height: 12),
            Divider(
              color: AppColors.geryColor,
            ),
            SizedBox(height: 12),
            _sectionHeader("About me / Profile Summary"),
            SizedBox(height: 6),
            _sectionText("${widget.talentList?.aboutYourself ?? ""}"),
            Divider(
              color: AppColors.geryColor,
            ),
            _sectionHeader("Key Responsibilities"),
            SizedBox(height: 6),
            // _sectionText("${talentList?. ?? ""}"),
            SizedBox(height: 16),
            _sectionHeader("Work Experience"),
            SizedBox(height: 8),
            (widget.talentList?.jobExperiences.isNotEmpty ?? false)
                ? ExperienceAccordionItem(
                    details: ListView.separated(
                      padding: EdgeInsets.all(6),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = widget.talentList?.jobExperiences[index];
                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                          onTap: () => talentViewmodel.toggleIndex(index),
                          title: Text(
                            "${item?.startYear}",
                            style: TextStyles.medium2(),
                          ),
                          subtitle: talentViewmodel.expandedIndex == index
                              ? Text(item?.jobTitle ?? "",
                                  style: TextStyles.regular1())
                              : null,
                          trailing: Icon(
                            talentViewmodel.expandedIndex == index
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.orange,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: widget.talentList!.jobExperiences.length,
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 16),
            _sectionHeader("Certifications"),
            SizedBox(height: 6),
            CertificatesView(certificates: widget.talentList?.certificate),
            SizedBox(height: 16),
            _sectionHeader("Cover Letter"),
            SizedBox(height: 6),
            CertificatesView(certificates: widget.talentList?.coverLetter),
            //  CustomChipView(typesList: talentList?.certificate),
            SizedBox(height: 20),
            _sectionHeader("View CV"),
            if (widget.talentList?.uploadResume != null)
              InkWell(
                onTap: () {
                  navigationService.push(HorizantalPdf(
                    // key: ValueKey(
                    //   pdf?.url ?? '',
                    // ),
                    fileUrl: widget.talentList!.uploadResume.isNotEmpty
                        ? widget.talentList!.uploadResume.first.url ?? ''
                        : '',
                    fileName: '',
                    isfullScreen: true,
                  ));
                },
                child: SvgPicture.asset(
                  ImageConst.certificate_img,
                  height: 55,
                  width: 55,
                  color: AppColors.primaryColor,
                ),
              )
          ],
        ),
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

  Widget _sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title, style: TextStyles.medium2()),
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
