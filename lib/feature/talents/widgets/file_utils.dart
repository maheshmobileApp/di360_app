import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class FileViewer {
  /// Get file extension
  static String getExtension(String? url) {
    if (url == null || url.isEmpty) return "";
    return url.split('.').last.toLowerCase().split('?').first;
  }

  /// File Types
  static bool isPdf(String? type) =>  ["pdf"].contains(getExtension(type));

  static bool isImage(String? type) =>
      ["jpg", "jpeg", "png", "webp", "gif"].contains(getExtension(type));

  static bool isWord(String? type) =>
      ["doc", "docx"].contains(getExtension(type));

  /// Icon
  static IconData getIcon(String? url) {
    if (isPdf(url)) return Icons.picture_as_pdf;
    if (isImage(url)) return Icons.image;
    if (isWord(url)) return Icons.description;

    return Icons.insert_drive_file;
  }

  /// Open File
  static Future<void> open({
    required BuildContext context,
    required String url,
    String fileName = "",
    required String type,
  }) async {
    if (isPdf(type)) {
      navigationService.push(
        HorizantalPdf(
          fileUrl: url,
          fileName: fileName,
          isfullScreen: true,
        ),
      );
      return;
    }

    if (isImage(type)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _ImageViewer(imageUrl: url),
        ),
      );
      return;
    }

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}

/// Internal Image Viewer
class _ImageViewer extends StatelessWidget {
  final String imageUrl;

  const _ImageViewer({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration:
              const BoxDecoration(color: Colors.black),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
        ),
      ),
    );
  }
}