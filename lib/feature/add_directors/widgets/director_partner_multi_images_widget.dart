import 'dart:convert';
import 'dart:io';

import 'package:di360_flutter/feature/add_directors/model/get_partners_res.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectorPartnerMultiImagesWidget extends StatefulWidget {
  const DirectorPartnerMultiImagesWidget({super.key});

  @override
  State<DirectorPartnerMultiImagesWidget> createState() => _DirectorPartnerMultiImagesWidgetState();
}

class _DirectorPartnerMultiImagesWidgetState extends State<DirectorPartnerMultiImagesWidget> {
  Widget _fileCard(
      Widget child, int index, EditDeleteDirectorViewModel viewModel,
      {bool isExisting = false}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              if (isExisting) {
                viewModel.removeExistingFile(index);
              } else {
                viewModel.removeFile(index);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFilePreview(
      PlatformFile file, int index, EditDeleteDirectorViewModel viewModel) {
    final extension = file.extension?.toLowerCase();

    if (['jpg', 'png', 'jpeg'].contains(extension)) {
      return _fileCard(
          Image.file(File(file.path!), fit: BoxFit.cover), index, viewModel);
    } else if (extension == 'pdf') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text('PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else {
      return _fileCard(
          Icon(Icons.insert_drive_file, size: 40), index, viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditDeleteDirectorViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload File", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: viewModel.pickFiles,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.attach_file, size: 30),
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          children: [
            ...List.generate(
              viewModel.existingImages.length,
              (index) => _buildExistingImagePreview(
                  viewModel.existingImages[index], index, viewModel),
            ),
            ...List.generate(
              viewModel.selectedFiles.length,
              (index) => _buildFilePreview(
                  viewModel.selectedFiles[index], index, viewModel),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildExistingImagePreview(
      PartnerAttachments image, int index, EditDeleteDirectorViewModel viewModel) {
    final type = image.type ?? image.mimeType ?? '';
    final url = image.url ?? '';

    // Helper: check if base64
    bool isBase64Image(String data) => data.startsWith('data:image/');

    if (type.startsWith('image/') ||
        type.startsWith('application/octet-stream')) {
      if (isBase64Image(url)) {
        try {
          final decodedBytes = base64Decode(url.split(',').last);
          return _fileCard(
              Image.memory(decodedBytes, fit: BoxFit.cover), index, viewModel,
              isExisting: true);
        } catch (e) {
          return Icon(Icons.broken_image);
        }
      } else {
        return _fileCard(
            Image.network(url, fit: BoxFit.cover), index, viewModel,
            isExisting: true);
      }
    } else if (type == 'application/pdf') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text('PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else if (type == 'application/msword') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text('PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else {
      return _fileCard(Image.network(url, fit: BoxFit.cover), index, viewModel,
          isExisting: true);
    }
  }
}
