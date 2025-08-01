import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view/director_details/custom_grid.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_appointmentform.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class DirectorBasicInfo extends StatelessWidget with BaseContextHelpers {
  const DirectorBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final directionalVM = Provider.of<DirectorViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('BASIC INFO',
              key: directionalVM.sectionKeys['Basic Info']),
          addVertical(8),
          _description(directionalVM.directorDetails?.description ?? ''),
          _sectionTitle('SERVICES', key: directionalVM.sectionKeys['Services']),
          addVertical(16),
          _serviceButtons(context,directionalVM),
          _sectionTitle('OUR TEAMS', key: directionalVM.sectionKeys['Team']),
          _teamcard(),
          _sectionTitle('GALLERY', key: directionalVM.sectionKeys['Gallery']),
          _galleryCard(ImageConst.dentalgallery),
          _sectionTitle('OUR ACHIEVEMENTS',
              key: directionalVM.sectionKeys['Achievements']),
          _archievementcard(),
          _sectionTitle('OUR CERTIFICATIONS',
              key: directionalVM.sectionKeys['Certifications']),
          _certificationcard(),
          _sectionTitle('Book an appointment with <Clinic Name>',
              key: directionalVM.sectionKeys['Book Appointment']),
          addVertical(10),
          DirectorAppointmentform(),
          _sectionTitle('HOW TESTLS HAS HELPED OTHERS',
              key: directionalVM.sectionKeys['Testimonials']),
          _testimonialCard(),
          _certificationcard(),
          _sectionTitle('FAQ', key: directionalVM.sectionKeys['FAQ']),
          _faqSection(),
          _sectionTitle('GET IN TOUCH',
              key: directionalVM.sectionKeys['Contact Us']),
          _contactFAQs(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, {Key? key}) {
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
      ],
    );
  }

  Widget _description(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: HtmlWidget(text,
            textStyle: TextStyles.regular3(color: AppColors.black)),
      );

  Widget _serviceButtons(BuildContext context,DirectorViewModel vm) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: 
          //vm.directorDetails?.directoryServices?.map((ser) => _outlinedButton(context, 'Product Consultation')).toList() ?? []
          [
            _outlinedButton(context, 'Clinic Setup'),
            const SizedBox(width: 12),
            _outlinedButton(context, 'Clinic Setup'),
          ],
        ),
      );
  Widget _outlinedButton(BuildContext context, String label) => Expanded(
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
                        Text(
                          label,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close, color: Colors.orange),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Text(
                      '$label test',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: BorderSide(color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      );

  Widget _teamcard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            ImageConst.teamcard,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        CustomGrid(
          children: List.generate(4, (index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 1,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.asset(
                        ImageConst.prfImg,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "TEAM A",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Position",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "CANBERRA",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _galleryCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
        ),
      ),
    );
  }

  Widget _archievementcard() {
    return CustomGrid(
      children: List.generate(4, (index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 48,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "THERACOL",
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
                    onTap: () {},
                    child: const CircleAvatar(
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

  Widget _certificationcard() {
    return CustomGrid(
      children: List.generate(4, (index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    ImageConst.cerificatecard,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'SMILE TECH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Scheduled catalogue',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 16,
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

  Widget _testimonialCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "“The course content was amazing and thorough. I gained a lot of value and would recommend this to every developer serious about frontend frameworks.”",
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 8,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "MEENA K.",
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
    );
  }

  Widget _faqSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 16, bottom: 6),
          ),
          _faqItem("1. Test Ques1", "Test Ans1."),
        ],
      );

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

  Widget _contactFAQs() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.location_on, color: Colors.black),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Airport Service Rd,\nInternational Airport, Dum Dum,\nKolkata, West Bengal 700052, India',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: const [
                Icon(Icons.email, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  'smiletech@yopmail.com',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: const [
                Icon(Icons.phone, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  '0430 972 666',
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                ImageConst.mapsPng,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: const [
                Text(
                  'MON TO WED',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '10:00 AM – 4:00 PM',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Text(
                  'THURSDAY',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  '10:00 AM – 7:00 PM',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
