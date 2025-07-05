import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizantalPdf extends StatefulWidget {
  final String fileUrl;
  final String fileName;

  const HorizantalPdf({
    super.key,
    required this.fileUrl,
    required this.fileName,
  });

  @override
  State<HorizantalPdf> createState() => _HorizantalPdfState();
}

class _HorizantalPdfState extends State<HorizantalPdf> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    downloadPdf();
  }

  @override
  void didUpdateWidget(covariant HorizantalPdf oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fileUrl != widget.fileUrl) {
      setState(() {
        isLoading = true;
        localPath = null;
      });
      downloadPdf();
    }
  }

  Future<void> downloadPdf() async {
    if (widget.fileUrl.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(widget.fileUrl));
      final dir = await getTemporaryDirectory();
      final filePath =
          "${dir.path}/${widget.fileName.isNotEmpty ? widget.fileName : 'temp.pdf'}";

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("PDF download error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  int? totalPages;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (localPath == null) {
      return const Center(child: Text("Failed to load PDF."));
    }

    return Column(
      children: [
        Expanded(
          child: PDFView(
            filePath: localPath!,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageSnap: true,
            pageFling: true,
            fitEachPage: true,
            onError: (error) {
              debugPrint("PDF View error: $error");
            },
            onRender: (_pages) {
              setState(() {
                totalPages = _pages;
              });
            },
            onPageChanged: (page, total) {
              setState(() {
                currentPage = page ?? 0;
              });
              debugPrint("Page changed: $page/$total");
            },
          ),
        ),
        if (totalPages != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
            child: SmoothPageIndicator(
              controller: PageController(initialPage: currentPage),
              count: totalPages!,
              effect: ScrollingDotsEffect(
                dotWidth: 10,dotHeight: 10,
                activeDotColor: AppColors.primaryColor
              ),
            ),
          ),
      ],
    );
  }
}
