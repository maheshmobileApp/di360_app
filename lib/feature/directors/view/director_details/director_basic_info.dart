import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/feature/directors/view/director_details/custom_grid.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_appointmentform.dart';
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
            _sectionTitle('BASIC INFO',
                _description(directionalVM.directorDetails?.description ?? ''),
                key: directionalVM.sectionKeys['Basic Info']),
          addVertical(8),
          if (directionalVM.directorDetails?.directoryServices?.isNotEmpty ??
              false)
            _sectionTitle('SERVICES', _serviceButtons(context, directionalVM),
                key: directionalVM.sectionKeys['Services']),
          addVertical(16),
          if (directionalVM.directorDetails?.directoryTeamMembers?.isNotEmpty ??
              false)
            _sectionTitle('OUR TEAMS', _teamcard(directionalVM),
                key: directionalVM.sectionKeys['Team']),
          addVertical(16),
          if (directionalVM.directorDetails?.directoryPartners?.isNotEmpty ??
              false)
            _sectionTitle('Our Partners', _partnercard(directionalVM, context),
                key: directionalVM.sectionKeys['Partner']),
          if ((directionalVM
                      .directorDetails?.directoryGalleryPosts?.isNotEmpty ??
                  false) &&
              (directionalVM.directorDetails?.directoryGalleryPosts?.first.image
                      ?.isNotEmpty ??
                  false))
            _sectionTitle('GALLERY', _galleryCard(directionalVM),
                key: directionalVM.sectionKeys['Gallery']),
          if (directionalVM.directorDetails?.directoryDocuments?.isNotEmpty ??
              false)
            _sectionTitle('OUR DOCUMENT', _documentCard(directionalVM),
                key: directionalVM.sectionKeys['Document']),
          if (directionalVM
                  .directorDetails?.directoryAchievements?.isNotEmpty ??
              false)
            _sectionTitle('OUR ACHIEVEMENTS', _archievementcard(directionalVM),
                key: directionalVM.sectionKeys['Achievements']),
          if (directionalVM
                  .directorDetails?.directoryCertifications?.isNotEmpty ??
              false)
            _sectionTitle(
                'OUR CERTIFICATIONS', _certificationcard(directionalVM),
                key: directionalVM.sectionKeys['Certifications']),
          if (directionalVM
                  .directorDetails?.directoryAppointmentSlots?.isNotEmpty ??
              false)
            _sectionTitle('Book an appointment with <Clinic Name>',
                DirectorAppointmentform(),
                key: directionalVM.sectionKeys['Book Appointment']),
          addVertical(10),
          if (directionalVM
                  .directorDetails?.directoryTestimonials?.isNotEmpty ??
              false)
            _sectionTitle(
                'HOW TESTLS HAS HELPED OTHERS', _testimonialCard(directionalVM),
                key: directionalVM.sectionKeys['Testimonials']),
          if (directionalVM.directorDetails?.directoryFaqs?.isNotEmpty ?? false)
            _sectionTitle('FAQ', _faqSection(directionalVM),
                key: directionalVM.sectionKeys['FAQ']),
          if (directionalVM.directorDetails?.directoryLocations?.isNotEmpty ??
              false)
            _sectionTitle('GET IN TOUCH', _contactFAQs(directionalVM, context),
                key: directionalVM.sectionKeys['Contact Us']),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, Widget? child, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              height: 2,
              width: 40,
              color: Colors.orange,
            ),
            Expanded(
              child: Container(
                height: 2,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(child: child)
      ],
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            side: BorderSide(color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(vertical: 16),
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
                            fit: BoxFit.fill)),
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
      ],
    );
  }

  Widget _showMoreWidget(bool directorName, Function()? onTap) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        addVertical(10),
        InkWell(
          onTap: onTap,
          child: Row(children: [
            Text(directorName ? 'Show Less' : 'Show More',
                style: TextStyles.medium2(color: AppColors.black)),
            addHorizontal(5),
            Icon(
                directorName
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.black,
                size: 20)
          ]),
        )
      ]),
    );
  }

  Widget _partnercard(DirectoryViewModel vm, BuildContext context) {
    return CustomGrid(
      childAspectRatio: 1.0,
      children: List.generate(
          vm.directorDetails?.directoryPartners?.length ?? 0, (index) {
        final partnerData = vm.directorDetails?.directoryPartners?[index];
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
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
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
    );
  }

  void _viewPromotion(BuildContext context, DirectoryPartners partner) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(partner.name ?? '',
                        style: TextStyles.bold6(color: AppColors.black)),
                  ),
                  GestureDetector(
                    onTap: () => navigationService.goBack(),
                    child:
                        const Icon(Icons.close, color: AppColors.primaryColor),
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

    final images = galleryPosts.first.image;
    if (images == null || images.isEmpty) return SizedBox.shrink();

    return Padding(
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
                }).toList())));
  }

  Widget _documentCard(DirectoryViewModel vm) {
    return CustomGrid(
      childAspectRatio: 0.80,
      children: List.generate(
          vm.directorDetails?.directoryDocuments?.length ?? 0, (index) {
        final doc = vm.directorDetails?.directoryDocuments?[index];
        return Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.HINT_COLOR),
              borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          color: AppColors.hintColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageConst.pdf),
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
                      child: Icon(
                        Icons.download,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _archievementcard(DirectoryViewModel vm) {
    return CustomGrid(
      children: List.generate(
          vm.directorDetails?.directoryAchievements?.length ?? 0, (index) {
        final achieve = vm.directorDetails?.directoryAchievements?[index];
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
                      height: 170,
                      fit: BoxFit.fill)),
              Divider(),
              Text(
                achieve?.title ?? '',
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
        _showMoreWidget(vm.showMoreOurCertification,
            () => vm.toggleShowMore(vm.showMoreOurCertification))
      ],
    );
  }

  Widget _testimonialCard(DirectoryViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
          children: vm.directorDetails!.directoryTestimonials!
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
      children: vm.directorDetails!.directoryFaqs!
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
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.email, color: Colors.black),
              SizedBox(width: 10),
              Text(
                vm.directorDetails?.email ?? '',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.black),
              SizedBox(width: 10),
              Text(
                vm.directorDetails?.phone ?? '',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Icon(Icons.facebook, color: Colors.black),
              SizedBox(width: 15),
              Icon(Icons.camera_alt, color: Colors.black),
              SizedBox(width: 15),
              Icon(Icons.link, color: Colors.black),
              SizedBox(width: 15),
              Icon(Icons.shop, color: Colors.black),
            ],
          ),
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
              children: vm.directorDetails!.directoryLocations!
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
