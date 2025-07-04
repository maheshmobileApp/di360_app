import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    downloadAndLoadFile();
  }

  Future<void> downloadAndLoadFile() async {
    final response = await http.get(Uri.parse(widget.fileUrl));
    final contentType = response.headers['content-type'];

    final dir = await getTemporaryDirectory();
    final fileName = widget.fileName.isEmpty ? 'temp' : widget.fileName;

    if (contentType?.contains('pdf') == true) {
      final file = File("${dir.path}/$fileName.pdf");
      await file.writeAsBytes(response.bodyBytes, flush: true);

      setState(() {
        localPath = file.path;
      });
    } else if (contentType?.contains('msword') == true ||
        contentType?.contains('officedocument.wordprocessingml.document') ==
            true) {
      final file = File("${dir.path}/$fileName.docx");
      await file.writeAsBytes(response.bodyBytes, flush: true);

        OpenFile.open(file.path);

      // Optionally show a placeholder instead of PDFView
      setState(() {
        localPath = null;
      });
    } else {
      setState(() {
        localPath = null;
      });

      _showUnsupportedFileDialog(contentType);
    }
  }

  void _showUnsupportedFileDialog(String? contentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unsupported File"),
        content: Text(
            "This file cannot be previewed in-app. Content-Type: $contentType"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (localPath == null) {
      return const Center(
        child: Text("Cannot preview this file."),
      );
    }

    return PDFView(
      filePath: localPath,
      swipeHorizontal: true,
      autoSpacing: true,
      pageFling: true,
    );
  }
}
