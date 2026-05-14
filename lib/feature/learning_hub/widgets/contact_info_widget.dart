import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoWidget extends StatelessWidget {
  final String location;
  final String email;
  final String phoneNumber;
  final String website;
  final String user;

  const ContactInfoWidget({
    Key? key,
    required this.location,
    required this.email,
    required this.phoneNumber,
    required this.website,
    required this.user,
  }) : super(key: key);

  Widget _buildRow(IconData? iconPath, String text, bool underlined,
      {String? type}) {
    return GestureDetector(
      onTap: () {
        if (type == 'phone') {
          makePhoneCall(phoneNumber);
        }
        if (type == 'website') {
          openWebsite(website);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(
              iconPath,
              size: 18,
              color: AppColors.black,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyles.semiBold(
                color: AppColors.black,
                fontSize: 14,
                decoration:
                    underlined ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get in Touch",
          style: TextStyles.bold2(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 6),
        if (user.isNotEmpty) ...[
          _buildRow(Icons.person_outline, user, false),
        ],
        const SizedBox(height: 6),
        if (location.isNotEmpty) ...[
          _buildRow(Icons.location_on, location, false),
        ],
        const SizedBox(height: 6),
        if (email.isNotEmpty) ...[
          _buildRow(Icons.mail_outline, email, false),
        ],
        const SizedBox(height: 6),
        if (phoneNumber.isNotEmpty) ...[
          _buildRow(Icons.call_outlined, phoneNumber, true, type: 'phone'),
        ],
        const SizedBox(height: 6),
        if (website.isNotEmpty) ...[
          _buildRow(Icons.public, website, true, type: 'website'),
        ],
      ],
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> openWebsite(String? url) async {
    if (url == null || url.trim().isEmpty) return;

    final website = url.trim();

    final formattedUrl =
        website.startsWith('http://') || website.startsWith('https://')
            ? website
            : 'https://$website';

    final Uri uri = Uri.parse(formattedUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
