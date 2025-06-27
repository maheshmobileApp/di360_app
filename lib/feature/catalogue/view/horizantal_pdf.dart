import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HorizantalPdfViewerScreen extends StatefulWidget {
  final String fileUrl;
  final String fileName;

  const HorizantalPdfViewerScreen({
    super.key,
    required this.fileUrl,
    required this.fileName,
  });

  @override
  State<HorizantalPdfViewerScreen> createState() => _HorizantalPdfViewerScreenState();
}

class _HorizantalPdfViewerScreenState extends State<HorizantalPdfViewerScreen> {
  final PdfViewerController _pdfController = PdfViewerController();

  bool _isLoading = true;
  int _totalPages = 0;
  late PdfScrollDirection _scrollDirection;

  @override
  void initState() {
    super.initState();
    _scrollDirection = PdfScrollDirection.vertical; // default
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfPdfViewer.network(
          widget.fileUrl,
          controller: _pdfController,
          canShowPaginationDialog: false,
          enableDoubleTapZooming: true,
          onDocumentLoaded: (details) {
            setState(() {
              _totalPages = details.document.pages.count;

              /// Check page count
              if (_totalPages >= 3) {
                _scrollDirection = PdfScrollDirection.horizontal;
              } else {
                _scrollDirection = PdfScrollDirection.vertical;
              }

              _isLoading = false;
            });
          },
          scrollDirection: _scrollDirection,
          onDocumentLoadFailed: (details) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to load PDF.")),
            );
            setState(() {
              _isLoading = false;
            });
          },
        ),
        if (_isLoading)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
