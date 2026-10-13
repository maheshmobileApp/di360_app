import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/widgets/pdf_view_widget.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/feature/directors/view/director_details/custom_grid.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_appointmentform.dart';
import 'package:di360_flutter/feature/directors/view/director_details/hobbies_education_workat_widget.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/location_view_widget.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectorBasicInfo extends StatelessWidget with BaseContextHelpers {
  const DirectorBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final directionalVM = Provider.of<DirectoryViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (directionalVM.directorDetails?.description != null)
            sectionTitle('ABOUT US',
                _description(directionalVM.directorDetails?.description ?? ''),
                key: directionalVM.sectionKeys['Basic Info']),
          HobbiesEducationWorkatWidget(),
          addVertical(8),
          if (directionalVM.directorDetails?.directoryServices?.isNotEmpty ??
              false)
            sectionTitle('SERVICES', _serviceButtons(context, directionalVM),
                key: directionalVM.sectionKeys['Services']),
          addVertical(16),
          if (directionalVM.directorDetails?.directoryTeamMembers?.isNotEmpty ??
              false)
            sectionTitle('OUR TEAMS', _teamcard(directionalVM),
                key: directionalVM.sectionKeys['Team']),
          addVertical(16),
          if (directionalVM.directorDetails?.directoryPartners?.isNotEmpty ??
              false)
            sectionTitle('OUR PARTNERS', _partnercard(directionalVM, context),
                key: directionalVM.sectionKeys['Partner']),
          if ((directionalVM
                      .directorDetails?.directoryGalleryPosts?.isNotEmpty ??
                  false) &&
              (directionalVM.directorDetails?.directoryGalleryPosts?.first.image
                      ?.isNotEmpty ??
                  false))
            sectionTitle('GALLERY', _galleryCard(directionalVM),
                key: directionalVM.sectionKeys['Gallery']),
          if (directionalVM.directorDetails?.directoryDocuments?.isNotEmpty ??
              false)
            sectionTitle('OUR DOCUMENT', _documentCard(directionalVM),
                key: directionalVM.sectionKeys['Document']),
          if (directionalVM
                  .directorDetails?.directoryAchievements?.isNotEmpty ??
              false)
            sectionTitle('OUR ACHIEVEMENTS', _archievementcard(directionalVM),
                key: directionalVM.sectionKeys['Achievements']),
          if (directionalVM
                  .directorDetails?.directoryCertifications?.isNotEmpty ??
              false)
            sectionTitle(
                'OUR CERTIFICATIONS', _certificationcard(directionalVM),
                key: directionalVM.sectionKeys['Certifications']),
          if (directionalVM
                  .directorDetails?.directoryAppointmentSlots?.isNotEmpty ??
              false)
            sectionTitle(
                'Book an appointment with <${directionalVM.directorDetails?.name?.toUpperCase() ?? 'Clinic Name'}>',
                DirectorAppointmentform(),
                key: directionalVM.sectionKeys['Book Appointment']),
          addVertical(10),
          if (directionalVM
                  .directorDetails?.directoryTestimonials?.isNotEmpty ??
              false)
            sectionTitle(
                'HOW ${directionalVM.directorDetails?.businessName?.toUpperCase() ?? ''} HAS HELPED OTHERS', _testimonialCard(directionalVM),
                key: directionalVM.sectionKeys['Testimonials']),
          if (directionalVM.directorDetails?.directoryFaqs?.isNotEmpty ?? false)
            sectionTitle('FAQ', _faqSection(directionalVM),
                key: directionalVM.sectionKeys['FAQ']),
          // if (directionalVM.directorDetails?.directoryLocations?.isNotEmpty ??
          //     false)
          sectionTitle('GET IN TOUCH', _contactFAQs(directionalVM, context),
              key: directionalVM.sectionKeys['Contact Us']),
        ],
      ),
    );
  }

  Widget _description(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: HtmlWidget(text,
            textStyle: TextStyles.regular3(color: AppColors.black)),
      );

  Widget _serviceButtons(BuildContext context, DirectoryViewModel vm) {
    final services = vm.directorDetails?.directoryServices ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services
              .map((val) => _outlinedButton(context, val.name ?? ''))
              .toList()),
    );
  }

  Widget _outlinedButton(BuildContext context, String label) => Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 8),
        child: OutlinedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.all(20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(label,
                                style:
                                    TextStyles.bold6(color: AppColors.black)),
                          ),
                          GestureDetector(
                              onTap: () => navigationService.goBack(),
                              child: const Icon(Icons.close,
                                  color: AppColors.primaryColor))
                        ]),
                    const Divider(height: 20),
                    Text('$label ',
                        style: TextStyles.medium3(color: AppColors.black)),
                  ],
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide(color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyles.bold6(color: AppColors.black)),
          ),
        ),
      );

  Widget _teamcard(DirectoryViewModel vm) {
    final teamDataList = vm.showMoreOurTeam
        ? vm.directorDetails?.directoryTeamMembers
        : vm.directorDetails?.directoryTeamMembers?.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomGrid(
          childAspectRatio: 0.80,
          children: List.generate(teamDataList?.length ?? 0, (index) {
            final teamData = teamDataList?[index];
            return Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.HINT_COLOR),
                  borderRadius: BorderRadius.circular(16)),
              elevation: 1,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 110,
                        child: CachedNetworkImageWidget(
                            imageUrl: teamData?.image?.url ?? '',
                            fit: BoxFit.contain)),
                    const SizedBox(height: 5),
                    Text(teamData?.name ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black)),
                    const SizedBox(height: 4),
                    Text(teamData?.specialization ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Divider(),
                    Text(teamData?.location ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
              ),
            );
          }),
        ),
        addVertical(10),
        if ((vm.directorDetails?.directoryTeamMembers?.length ?? 0) > 2)
          _showMoreWidget(vm.showMoreOurTeam, vm.toggleShowMoreTeam)
      ],
    );
  }

  Widget _showMoreWidget(bool directorName, VoidCallback onTap) {
    return Center(
        child: InkWell(
            onTap: onTap,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(directorName ? 'Show Less' : 'Show More',
                      style: TextStyles.medium2(color: AppColors.black)),
                  addHorizontal(5),
                  Icon(
                      directorName
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.black,
                      size: 20)
                ]))));
  }

  Widget _partnercard(DirectoryViewModel vm, BuildContext context) {
    final partnerList = vm.showMoreOurPartner
        ? vm.directorDetails?.directoryPartners
        : vm.directorDetails?.directoryPartners?.take(2).toList();
    return Column(children: [
      CustomGrid(
        childAspectRatio: 1.0,
        children: List.generate(partnerList?.length ?? 0, (index) {
          final partnerData = partnerList?[index];
          return InkWell(
            onTap: () =>
                _viewPromotion(context, partnerData ?? DirectoryPartners()),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.HINT_COLOR),
                  borderRadius: BorderRadius.circular(16)),
              elevation: 1,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 110,
                          child: CachedNetworkImageWidget(
                              imageUrl: partnerData?.image?.url ?? '',
                              fit: BoxFit.fill)),
                      Divider(),
                      Text(partnerData?.name ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black))
                    ]),
              ),
            ),
          );
        }),
      ),
      addVertical(10),
      if ((vm.directorDetails?.directoryPartners?.length ?? 0) > 2)
        _showMoreWidget(vm.showMoreOurPartner, vm.toggleShowMorePartner)
    ]);
  }

  void _viewPromotion(BuildContext context, DirectoryPartners partner) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(partner.name ?? '',
                        style: TextStyles.bold4(color: AppColors.black)),
                  ),
                  Row(
                    children: [
                      /*GestureDetector(
                        onTap: () => navigationService.push(
                        ImageViewerScreen(postImage: partner.attachments)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            size: 20,
                            Icons.visibility_outlined,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),*/
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => navigationService.goBack(),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 20),
              HtmlWidget('${partner.description}',
                  textStyle: TextStyles.medium3(color: AppColors.black)),
              if (partner.showCommunityUser == true) ...[
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => navigationService.push(
                        ImageViewerScreen(postImage: partner.attachments)),
                    child: Container(
                      width: 160,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(children: [
                        SizedBox(width: 2),
                        Icon(Icons.remove_red_eye,
                            color: AppColors.whiteColor, size: 20),
                        SizedBox(width: 8),
                        Text('View Promotion',
                            style: TextStyles.regular2(
                                color: AppColors.whiteColor))
                      ]),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      );

  Widget _galleryCard(DirectoryViewModel vm) {
    final galleryPosts = vm.directorDetails?.directoryGalleryPosts;
    if (galleryPosts == null || galleryPosts.isEmpty) return SizedBox.shrink();

    final images = vm.showMoreOurGallery
        ? galleryPosts.first.image
        : galleryPosts.first.image?.take(2).toList();
    if (images == null || images.isEmpty) return SizedBox.shrink();

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomGrid(
                    childAspectRatio: 0.95,
                    children: images.map((url) {
                      return CachedNetworkImageWidget(
                        imageUrl: url.url ?? '',
                        fit: BoxFit.fill,
                      );
                    }).toList()))),
        addVertical(10),
        if (images.length > 2)
          _showMoreWidget(vm.showMoreOurGallery, vm.toggleShowMoreGallery)
      ],
    );
  }

  Widget _documentCard(DirectoryViewModel vm) {
    final docList = vm.showMoreOurDocument
        ? vm.directorDetails?.directoryDocuments
        : vm.directorDetails?.directoryDocuments?.take(2).toList();
    return Column(
      children: [
        CustomGrid(
            childAspectRatio: 0.78,
            children: List.generate(docList?.length ?? 0, (index) {
              final doc = docList?[index];
              return GestureDetector(
                onTap: () => navigationService.push(PdfViewWidget(
                    url: doc?.attachment?.url ?? "", name: doc?.name ?? "")),
                child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.HINT_COLOR),
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                    color: AppColors.hintColor,
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Stack(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Image.asset(ImageConst.pdf)),
                              const SizedBox(height: 12),
                              Divider(),
                              Text(
                                doc?.name ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                  onTap: () async {
                                    final url = doc?.attachment?.url ?? '';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(
                                        Uri.parse(url),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  },
                                  child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.black,
                                      child: Icon(Icons.download,
                                          size: 16, color: Colors.white))))
                        ]))),
              );
            })),
        addVertical(10),
        if ((vm.directorDetails?.directoryDocuments?.length ?? 0) > 2)
          _showMoreWidget(vm.showMoreOurDocument, vm.toggleShowMoreDocument)
      ],
    );
  }

  Widget _archievementcard(DirectoryViewModel vm) {
    final achieveList = vm.showMoreOurCertification
        ? vm.directorDetails?.directoryAchievements
        : vm.directorDetails?.directoryAchievements?.take(2).toList();
    return Column(
      children: [
        CustomGrid(
          childAspectRatio: 0.75,
          children: List.generate(achieveList?.length ?? 0, (index) {
            final achieve = achieveList?[index];
            return Container(
              decoration: BoxDecoration(
                  color: AppColors.hintColor,
                  border: Border.all(color: AppColors.HINT_COLOR),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImageWidget(
                          imageUrl: achieve?.attachments?.url ?? '',
                          height: 150,
                          fit: BoxFit.contain)),
                  Divider(height: 8),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      achieve?.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        addVertical(10),
        if ((vm.directorDetails?.directoryAchievements?.length ?? 0) > 2)
          _showMoreWidget(
              vm.showMoreOurAchievement, vm.toggleShowMoreAchievement)
      ],
    );
  }

  Widget _certificationcard(DirectoryViewModel vm) {
    final certificateList = vm.showMoreOurCertification
        ? vm.directorDetails?.directoryCertifications
        : vm.directorDetails?.directoryCertifications?.take(2).toList();
    return Column(
      children: [
        CustomGrid(
          children: List.generate(certificateList?.length ?? 0, (index) {
            final certificate = certificateList?[index];
            return Container(
              decoration: BoxDecoration(
                  color: AppColors.hintColor,
                  border: Border.all(color: AppColors.HINT_COLOR),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImageWidget(
                          imageUrl: certificate?.attachments?.url ?? '',
                          height: 170,
                          fit: BoxFit.fill)),
                  Divider(),
                  Text(
                    certificate?.title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        addVertical(10),
        if ((vm.directorDetails?.directoryCertifications?.length ?? 0) > 2)
          _showMoreWidget(
              vm.showMoreOurCertification, vm.toggleShowMoreCertification)
      ],
    );
  }

  Widget _testimonialCard(DirectoryViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
          children: (vm.directorDetails?.directoryTestimonials ?? [])
              .map(
                (data) => Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.message ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 23,
                              child: CircleAvatar(
                                radius: 22,
                                child: ClipOval(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CachedNetworkImageWidget(
                                      imageUrl: data.profileImage?.url ?? '',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              data.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }

  Widget _faqSection(DirectoryViewModel vm) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: (vm.directorDetails?.directoryFaqs ?? [])
          .map((val) => Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  ),
                  _faqItem(val.question ?? "", val.answer ?? ""),
                ],
              ))
          .toList());

  Widget _faqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.fromLTRB(20, 0, 16, 12),
            title: Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      answer,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactFAQs(DirectoryViewModel vm, BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: Colors.black),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  vm.directorDetails?.address ?? '',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          if (vm.directorDetails?.businessEmail != null) ...[
            addVertical(8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Business Email :',
                  style: TextStyles.medium2(
                      color: AppColors.bottomNavUnSelectedColor)),
              addVertical(2),
              Text(vm.directorDetails?.businessEmail ?? '')
            ])
          ],
          if (vm.directorDetails?.mobileNumber != null) ...[
            addVertical(8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Business Phone :',
                  style: TextStyles.medium2(
                      color: AppColors.bottomNavUnSelectedColor)),
              addVertical(2),
              Text(vm.directorDetails?.mobileNumber ?? '')
            ])
          ],
          if (vm.emailVisibility) ...[
            addVertical(15),
            Row(children: [
              Icon(Icons.email, color: Colors.black),
              SizedBox(width: 10),
              Text(
                vm.directorDetails?.email ?? '',
                style: TextStyle(fontSize: 14),
              )
            ])
          ],
          if (vm.phoneVisibility) ...[
            addVertical(15),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  vm.directorDetails?.phone ?? '',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            )
          ],
          addVertical(20),
          Row(
              children: (vm.directorDetails?.directoryLocations ?? [])
                  .where((e) => ['facebook', 'instagram', 'linkedin', 'twitter']
                      .contains(e.mediaName?.toLowerCase()))
                  .map((social) {
            String icon;
            switch (social.mediaName?.toLowerCase()) {
              case 'facebook':
                icon = ImageConst.facebookSvg;
                break;
              case 'instagram':
                icon = ImageConst.instagramSvg;
                break;
              case 'linkedin':
                icon = ImageConst.linkedinSvg;
                break;
              case 'twitter':
                icon = ImageConst.twitterSvg;
                break;
              default:
                icon = ImageConst.facebookSvg;
            }
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                  onTap: () async {
                    final url = social.mediaLink ?? '';
                    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Image.asset(icon, height: 25)),
            );
          }).toList()),
          const SizedBox(height: 20),
          InkWell(
              onTap: () => openLocationInMaps(
                  context, vm.directorDetails?.address ?? ''),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(ImageConst.mapsPng,
                      fit: BoxFit.cover, width: double.infinity, height: 180))),
          const SizedBox(height: 25),
          Column(
              children: (vm.directorDetails?.directoryLocations ?? [])
                  .map((val) => Row(
                        children: [
                          Text(
                            val.weekName ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            val.clinicTime ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ))
                  .toList()),
        ]),
      );
}

Widget sectionTitle(String title, Widget? child, {Key? key}) {
  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      Row(
        children: [
          Container(height: 2, width: 40, color: Colors.orange),
          Expanded(child: Container(height: 2, color: Colors.grey.shade300))
        ],
      ),
      SizedBox(height: 10),
      Container(child: child)
    ],
  );
}
